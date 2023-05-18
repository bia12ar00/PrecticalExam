import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_exam/Cubit/OtpSend/otp_send_cubit.dart';
import 'package:practical_exam/Preference.dart';
import 'package:practical_exam/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference().instance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter OTP Verification',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => OtpSendCubit(),
        child: Register(),
      ),
    );
  }
}
