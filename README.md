# Medical Expert System - Malaria & Typhoid Fever

This codebase implements a **cross-platform medical expert system** built with **Flutter**, providing a comprehensive healthcare platform for patients and doctors. Features include user authentication, profile management, AI-powered diagnosis, appointment scheduling, and more.

---

## 📌 Project Functionality Overview

### 1. **User Authentication & Account Management**
- **Patient & Doctor Signup/Login**  
  - Pages: `signuppage.dart`, `doctorsignup.dart`, `signinpage.dart`, `doctorlogin.dart`
  - Credentials stored securely using **Shared Preferences** (`storage_service.dart`, `doctor_storage_service.dart`)
  - Authentication logic: `auth_model.dart`, API calls: `api_service.dart`, `doctor_api_service.dart`

- **Auth Wrapper**  
  - `authchecker.dart` routes users based on authentication status.

---

### 2. **Patient Dashboard**
- **Health Overview**  
  - Personalized dashboard: `dashboard.dart`
  - Health stats: heart rate, menstrual cycle tracking
  - Animated charts & calendars: `animatetime.dart`, `heartrategraph.dart`, `calender.dart`

- **Navigation**  
  - Access AI diagnosis, support, and profile.

---

### 3. **Doctor Dashboard**
- **Appointment & Performance Management**  
  - Dashboard: `doctordashboard.dart`
  - Shows upcoming appointments, performance charts, quick actions (appointments, reports, messages, prescriptions)

---

### 4. **AI-Powered Diagnosis**
- **Symptom Input & Diagnosis**  
  - Chatbot: `chatbot.dart` for Malaria & Typhoid Fever diagnosis
  - Guides users through symptom selection, duration
  - Provides diagnosis results: severity, confidence, precautions, secondary conditions
  - Logic/API: `diagnosis_service.dart`, `diagnosis_model.dart`

---

### 5. **Profile Management**
- **View & Edit Profile**: `profile.dart`  
  - Editable fields: contact info, address, date of birth, occupation

---

### 6. **Contact & Support**
- **Contact Us Page**: `contactus.dart`  
  - Users can send messages to support  
  - Custom text fields: `const/textfield.dart`

---

### 7. **Landing Page & Onboarding**
- **Responsive Landing Page**: `landingpage.dart`  
  - Showcases services, partners, customer reviews  
  - Animated counters, service highlights, testimonials

- **Account Type Selection**: `accounttype.dart`  
  - Choose between patient or doctor account

---

### 8. **Models & Data Structures**
- **Patient & Doctor Models**: `patient_model.dart`, `doctors_model.dart`  
- **Diagnosis & Symptom Models**: `diagnosis_model.dart`, `system_model.dart`

---

### 9. **API Integration**
- RESTful API communication for login, signup, diagnosis, profile retrieval
- Handles error responses and parsing

---

### 10. **UI Components & Utilities**
- Custom reusable widgets for charts, calendars, counters, text fields
- Responsive layouts using `flutter_screenutil`

---

### 11. **Other Features**
- **Code Verification Page**: `codepage.dart`
- **Persistent Storage**: Shared Preferences for tokens & user data

---

## ⚡ Summary

This codebase delivers a full-featured medical expert system with:

- Secure patient & doctor authentication
- Personalized dashboards & health tracking
- AI-powered diagnosis chatbot
- Doctor appointment & performance management
- Profile management & support contact
- Responsive, animated landing and onboarding
- Robust API integration & data modeling

---

### 📂 Key Files & Roles

| File/Folder                  | Purpose                                          |
|-------------------------------|------------------------------------------------|
| `main.dart`                   | App entry point & theme setup                  |
| `authchecker.dart`            | Authentication routing                         |
| `dashboard.dart`              | Patient dashboard                               |
| `doctordashboard.dart`        | Doctor dashboard                                |
| `chatbot.dart`                | AI diagnosis chatbot                            |
| `landingpage.dart`            | Landing & onboarding                            |
| `models/`                     | Data models (users, diagnosis, symptoms)       |
| `services/`                   | API & storage services                          |
| `const/`                      | Custom widgets & UI utilities                  |

For more details, explore the code structure and see the README.md.
