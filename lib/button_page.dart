import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';
import 'package:lipslay_flutter_frontend/colorscheme2.dart';
import 'package:lipslay_flutter_frontend/colorsheme1.dart';
import 'package:lipslay_flutter_frontend/colorsheme3.dart';
import 'package:lipslay_flutter_frontend/freelancerspage.dart';
import 'package:lipslay_flutter_frontend/homepage2.dart';
import 'package:lipslay_flutter_frontend/ladies_salon2.dart';
import 'package:lipslay_flutter_frontend/layout_1.dart';
import 'package:lipslay_flutter_frontend/login2page.dart';
import 'package:lipslay_flutter_frontend/myprofilescreen.dart';
import 'package:lipslay_flutter_frontend/notificationpage.dart';

import 'package:lipslay_flutter_frontend/register_1.dart';
import 'package:lipslay_flutter_frontend/schedule_appointment.dart';
import 'package:lipslay_flutter_frontend/schedule_screen.dart';
// import 'package:lipslay_flutter_frontend/login3page.dart';

class MyButtonScreen extends StatelessWidget {
  const MyButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("navigation page")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildButton(
                context,
                "Notifications",
                Icons.notifications,
                AppColors.lightBlue,
                NotificationsPage(),
              ),
              SizedBox(height: 10),

              SizedBox(height: 10),
              
              SizedBox(height: 10),

              _buildButton(
                context,
                "ScheduleAppointment",
                Icons.login,
                AppColors.calenderblueGrey,
                ScheduleAppointmentScreen(),
              ),
              SizedBox(height: 10),

              _buildButton(
                context,
                "ScheduleScreen",
                Icons.login,
                AppColors.red,
                MyScheduleScreen(),
              ),
              SizedBox(height: 10),

              _buildButton(
                context,
                "Login2",
                Icons.login,
                AppColors.lightBlue,
                Login2Page(),
              ),
              SizedBox(height: 10),

              _buildButton(
                context,
                "Layout 1",
                Icons.login,
                AppColors.lightBlue,
                SpaServicesScreen(),
              ),
              SizedBox(height: 10),

              _buildButton(
                context,
                "register",
                Icons.login,
                AppColors.lightBlue,
                SignUpPage(),
              ),

              SizedBox(height: 10),
              _buildButton(
                context,
                "ladies salon",
                Icons.girl,
                AppColors.red,
                FreelancersPage(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    Widget page,
  ) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      icon: Icon(icon, color: AppColors.white),
      label: Text(label, style: TextStyle(color: AppColors.white)),
    );
  }
}
