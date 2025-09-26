import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nusthackationwebsite/models/diagnosis_service.dart';
import 'package:nusthackationwebsite/models/diagnosis_model.dart';
import 'package:nusthackationwebsite/pages/contactus.dart';
import 'package:nusthackationwebsite/pages/dashboard.dart';

class ChatbotPage extends StatefulWidget {
  final String userId;

  const ChatbotPage({super.key, required this.userId});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  List<String> _symptoms = [];
  List<String> _selectedSymptoms = [];
  String _currentStep = 'welcome';
  String? _initialSymptom;
  int? _daysExperiencing;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSymptoms();
  }

  void _loadSymptoms() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final symptomResponse = await DiagnosisService.getSymptoms();
      setState(() {
        _symptoms = symptomResponse.symptoms;
        _isLoading = false;
      });
      _addWelcomeMessage();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _addMessage('bot', 'Error loading symptoms: $e');
    }
  }

  void _addWelcomeMessage() {
    _addMessage('bot', 'Welcome to Medical Diagnosis Assistant! 🩺');
    _addMessage('bot', 'Let\'s start by selecting your primary symptom.');
    _showInitialSymptoms();
  }

  void _addMessage(String role, String text) {
    setState(() {
      _messages.add({"role": role, "text": text, "type": "text"});
    });
  }

  void _showInitialSymptoms() {
    setState(() {
      _currentStep = 'select_initial';
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add({
          "role": "bot",
          "text": "Select your PRIMARY symptom:",
          "options": _symptoms,
          "type": "symptoms_selector",
          "step": "initial",
          "selectedIndex": -1,
        });
      });
    });
  }

  void _selectInitialSymptom(int index) {
    final symptom = _symptoms[index];
    setState(() {
      _initialSymptom = symptom;
      _selectedSymptoms.add(symptom);
      _currentStep = 'select_days';

      final symptomsMessageIndex = _messages.indexWhere(
        (msg) => msg['type'] == 'symptoms_selector' && msg['step'] == 'initial',
      );
      if (symptomsMessageIndex != -1) {
        _messages[symptomsMessageIndex]['selectedIndex'] = index;
      }
    });

    _addMessage('user', symptom);
    _addMessage('bot', 'How many days have you been experiencing "$symptom"?');
    _addMessage('bot', 'Please type a number between 1 and 365:');
  }

  void _selectDays() {
    final text = _controller.text.trim();
    final days = int.tryParse(text);

    if (days == null || days < 1 || days > 365) {
      _addMessage('bot', 'Please enter a valid number between 1 and 365:');
      _controller.clear();
      return;
    }

    setState(() {
      _daysExperiencing = days;
      _currentStep = 'select_additional';
    });

    _addMessage('user', '$days days');
    _addMessage(
      'bot',
      'Now, select any ADDITIONAL symptoms you\'re experiencing:',
    );
    _showAdditionalSymptoms();
  }

  void _showAdditionalSymptoms() {
    final availableSymptoms = _symptoms
        .where((symptom) => symptom != _initialSymptom)
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add({
          "role": "bot",
          "text": "Select ADDITIONAL symptoms (optional):",
          "options": availableSymptoms,
          "type": "symptoms_selector",
          "step": "additional",
          "selectedIndices": <int>[], // Explicitly type as List<int>
        });
      });
    });
  }

  void _toggleAdditionalSymptom(int index) {
    final symptomsMessageIndex = _messages.indexWhere(
      (msg) =>
          msg['type'] == 'symptoms_selector' && msg['step'] == 'additional',
    );

    if (symptomsMessageIndex != -1) {
      final availableSymptoms =
          _messages[symptomsMessageIndex]['options'] as List<String>;
      final symptom = availableSymptoms[index];

      setState(() {
        final selectedIndices =
            _messages[symptomsMessageIndex]['selectedIndices'] as List<int>;
        if (selectedIndices.contains(index)) {
          selectedIndices.remove(index);
          _selectedSymptoms.remove(symptom);
        } else {
          selectedIndices.add(index);
          _selectedSymptoms.add(symptom);
        }
      });
    }
  }

  void _submitAdditionalSymptoms() {
    setState(() {
      _currentStep = 'diagnosis';
    });

    final additionalSymptoms = _selectedSymptoms
        .where((s) => s != _initialSymptom)
        .toList();
    _addMessage(
      'user',
      'Additional symptoms: ${additionalSymptoms.join(', ')}',
    );
    _getDiagnosis();
  }

  void _getDiagnosis() async {
    if (_initialSymptom == null || _daysExperiencing == null) return;

    setState(() {
      _isLoading = true;
    });

    _addMessage('bot', 'Analyzing your symptoms...');

    try {
      final additionalSymptoms = _selectedSymptoms
          .where((s) => s != _initialSymptom)
          .toList();

      final diagnosis = await DiagnosisService.getDiagnosis(
        initialSymptom: _initialSymptom!,
        daysExperiencing: _daysExperiencing!,
        additionalSymptoms: additionalSymptoms,
        userId: widget.userId, // ✅ use widget.userId
      );

      setState(() {
        _isLoading = false;
      });

      _showDiagnosisResults(diagnosis);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _addMessage('bot', 'Error getting diagnosis: $e');
    }
  }

  void _showDiagnosisResults(Diagnosis diagnosis) {
    // Create a single formatted diagnosis message
    final diagnosisMessage = _buildDiagnosisMessage(diagnosis);
    _addMessage('bot', diagnosisMessage);

    _addMessage('bot', 'Type "restart" to start a new diagnosis.');
  }

  String _buildDiagnosisMessage(Diagnosis diagnosis) {
    final buffer = StringBuffer();

    // Header
    buffer.writeln('🩺 **DIAGNOSIS RESULTS**');
    buffer.writeln('');

    // Primary Diagnosis
    buffer.writeln(
      '**Primary Diagnosis:** ${diagnosis.diagnosis.primaryDiagnosis}',
    );
    buffer.writeln('');

    // Description (if available)
    if (diagnosis.diagnosis.description.isNotEmpty &&
        diagnosis.diagnosis.description != "No description available") {
      buffer.writeln('**Description:** ${diagnosis.diagnosis.description}');
      buffer.writeln('');
    }

    // Severity and Confidence
    buffer.writeln('**Severity:** ${diagnosis.diagnosis.severityAssessment}');
    buffer.writeln(
      '**Confidence Level:** ${diagnosis.diagnosis.confidenceLevel}',
    );
    buffer.writeln('');

    // Precautions (bulleted list)
    if (diagnosis.diagnosis.precautions.isNotEmpty) {
      buffer.writeln('**Precautions & Recommendations:**');
      for (final precaution in diagnosis.diagnosis.precautions) {
        buffer.writeln('• $precaution');
      }
      buffer.writeln('');
    }

    // Secondary Diagnoses (bulleted list)
    if (diagnosis.diagnosis.secondaryDiagnoses.isNotEmpty) {
      buffer.writeln('**Other Possible Conditions:**');
      for (final secondary in diagnosis.diagnosis.secondaryDiagnoses) {
        buffer.writeln('• $secondary');
      }
    }

    return buffer.toString();
  }

  void _resetChat() {
    setState(() {
      _messages.clear();
      _selectedSymptoms.clear();
      _initialSymptom = null;
      _daysExperiencing = null;
      _currentStep = 'welcome';
    });
    _addWelcomeMessage();
  }

  void _handleTextInput() {
    final text = _controller.text.trim().toLowerCase();
    if (text.isEmpty) return;

    switch (_currentStep) {
      case 'select_days':
        _selectDays();
        break;
      case 'diagnosis':
        if (text == 'restart') {
          _resetChat();
        }
        break;
      default:
        _addMessage('user', text);
        _addMessage('bot', 'Please use the symptom selection above.');
        break;
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header (your existing header code)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "MESMTF",
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF009688),
                        fontFamily: "BalooPaajiR",
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            fontFamily: "Clarendon",
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "AI Diagnosis",
                      style: TextStyle(
                        fontFamily: "Clarendon",
                        fontSize: 16,
                        color: Color(0xFF009688),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Contactus(userId: widget.userId),
                        ),
                      );
                    },
                    child: Text(
                      "Contact",
                      style: TextStyle(
                        fontFamily: "Clarendon",
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF009688),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            "GO TO ACCOUNT",
                            style: TextStyle(
                              fontFamily: "Clarendon",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            // Chat Area
            Expanded(
              child: _isLoading && _messages.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF009688),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(20.w),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];

                        if (msg['type'] == 'symptoms_selector') {
                          if (msg['step'] == 'initial') {
                            return _buildInitialSymptomsSelector(
                              msg['options'] as List<String>,
                              msg['selectedIndex'] as int,
                            );
                          } else {
                            return _buildAdditionalSymptomsSelector(
                              msg['options'] as List<String>,
                              msg['selectedIndices'] as List<int>,
                            );
                          }
                        }

                        final isUser = msg["role"] == "user";
                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            decoration: BoxDecoration(
                              color: isUser
                                  ? Color(0xFF009688)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: _buildMessageContent(
                              msg["text"] as String,
                              isUser,
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Input Box
            if (_currentStep == 'select_days' || _currentStep == 'diagnosis')
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Color(0xFF009688),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: TextField(
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "ClarendonBold",
                            ),
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: _getHintText(),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _handleTextInput(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    IconButton(
                      onPressed: _handleTextInput,
                      icon: Icon(LucideIcons.send, color: Color(0xFF009688)),
                    ),
                  ],
                ),
              ),

            if (_isLoading)
              Padding(
                padding: EdgeInsets.all(20.w),
                child: CircularProgressIndicator(color: Color(0xFF009688)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(String text, bool isUser) {
    // For diagnosis messages, parse the formatted text
    if (!isUser && text.contains('**DIAGNOSIS RESULTS**')) {
      return _buildDiagnosisMessageWidget(text);
    }

    // Regular text messages
    return Text(
      text,
      style: TextStyle(color: isUser ? Colors.white : Colors.black),
    );
  }

  Widget _buildDiagnosisMessageWidget(String text) {
    final lines = text.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.trim().isEmpty) {
          return SizedBox(height: 8.h);
        }

        if (line.contains('**DIAGNOSIS RESULTS**')) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Text('🩺 ', style: TextStyle(fontSize: 16.sp)),
                Expanded(
                  child: Text(
                    line.replaceAll('**', ''),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (line.startsWith('**') && line.endsWith('**')) {
          return Padding(
            padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
            child: Text(
              line.replaceAll('**', ''),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          );
        }

        if (line.startsWith('• ')) {
          return Padding(
            padding: EdgeInsets.only(left: 16.w, bottom: 2.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(fontSize: 14.sp)),
                Expanded(
                  child: Text(
                    line.substring(2),
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  ),
                ),
              ],
            ),
          );
        }

        return Text(
          line,
          style: TextStyle(fontSize: 14.sp, color: Colors.black87),
        );
      }).toList(),
    );
  }

  String _getHintText() {
    switch (_currentStep) {
      case 'select_days':
        return 'Enter number of days...';
      case 'diagnosis':
        return 'Type "restart" for new diagnosis...';
      default:
        return 'Type a message...';
    }
  }

  Widget _buildInitialSymptomsSelector(
    List<String> symptoms,
    int selectedIndex,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your PRIMARY symptom (choose one):',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10.h),

        Container(
          constraints: BoxConstraints(maxHeight: 300.h),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: List.generate(symptoms.length, (index) {
                final isSelected = selectedIndex == index;
                return InkWell(
                  onTap: () => _selectInitialSymptom(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF009688) : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Color(0xFF009688), width: 2),
                    ),
                    child: Text(
                      _formatSymptomName(symptoms[index]),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xFF009688),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        if (selectedIndex != -1) SizedBox(height: 10.h),
        if (selectedIndex != -1)
          Text(
            'Selected: ${_formatSymptomName(symptoms[selectedIndex])}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF009688),
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildAdditionalSymptomsSelector(
    List<String> symptoms,
    List<int> selectedIndices,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select ADDITIONAL symptoms (optional):',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10.h),

        Container(
          constraints: BoxConstraints(maxHeight: 300.h),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: List.generate(symptoms.length, (index) {
                final isSelected = selectedIndices.contains(index);
                return InkWell(
                  onTap: () => _toggleAdditionalSymptom(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF009688) : Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Color(0xFF009688), width: 2),
                    ),
                    child: Text(
                      _formatSymptomName(symptoms[index]),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xFF009688),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        SizedBox(height: 20.h),

        Center(
          child: ElevatedButton(
            onPressed: _submitAdditionalSymptoms,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF009688),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
            child: Text(
              'Continue to Diagnosis',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        SizedBox(height: 10.h),
        Text(
          'Selected: ${selectedIndices.length} additional symptoms',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  String _formatSymptomName(String symptom) {
    return symptom
        .split('_')
        .map((word) {
          if (word.isNotEmpty) {
            return word[0].toUpperCase() + word.substring(1);
          }
          return word;
        })
        .join(' ');
  }
}
