import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "MESMTF",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: const Color(0xFF009688),
                      fontWeight: FontWeight.bold,
                      fontFamily: "BalooPaajiR",
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Services",
                          style: TextStyle(
                            fontFamily: "Clarendon",
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "About Us",
                          style: TextStyle(
                            fontFamily: "Clarendon",
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Contact",
                          style: TextStyle(
                            fontFamily: "Clarendon",
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF009688),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "GO TO ACCOUNT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Profile content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),

                    // Avatar, name,email
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: const Color(0xFF009688).withOpacity(0.2),
                      child: Icon(Icons.person, size: 60.sp, color: const Color(0xFF009688)),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "John Doe",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF009688),
                      ),
                    ),
                    Text(
                      "johndoe@email.com",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                      label: const Text("Edit Profile",
                      style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF009688),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // User Info Cards
                    _buildInfoCard(Icons.phone, "Phone", "+264 812345678"),
                    _buildInfoCard(Icons.location_on, "Address", "Windhoek, Namibia"),
                    _buildInfoCard(Icons.cake, "Date of Birth", "12 March 1995"),
                    _buildInfoCard(Icons.work, "Occupation", "Software Developer"),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF009688).withOpacity(0.2),
            child: Icon(icon, color: const Color(0xFF009688)),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
