import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practical_exam/Cubit/OtpVerify/otp_verify_cubit.dart';
import 'package:practical_exam/Cubit/Welcome/welcome_cubit.dart';
import 'package:practical_exam/Preference.dart';
import 'package:practical_exam/home.dart';
import 'package:practical_exam/welcome.dart';

class Otp extends StatefulWidget {
  String requestId;
  Otp({Key? key, required this.requestId}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController textfield1 = TextEditingController();
  TextEditingController textfield2 = TextEditingController();
  TextEditingController textfield3 = TextEditingController();
  TextEditingController textfield4 = TextEditingController();
  TextEditingController textfield5 = TextEditingController();
  TextEditingController textfield6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpVerifyCubit, OtpVerifyState>(
      listener: (context, state) {
        if (state.status == OtpVerifyStatus.success) {
          if (state.otpVerifyModel?.status ?? false) {
            if (state.otpVerifyModel?.profileExists ?? false) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ), (route) => false);
            } else {
              Preference()
                  .setString(Preference.token, state.otpVerifyModel?.jwt ?? '');

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => WelcomeCubit(),
                    child: Welcome(),
                  );
                },
              ), (route) => false);
            }
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xfff7f6fb),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/illustration-3.png',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "OTP has been sent to +91-number",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _textFieldOTP(
                                first: true,
                                last: false,
                                textEditingController: textfield1),
                            _textFieldOTP(
                                first: false,
                                last: false,
                                textEditingController: textfield2),
                            _textFieldOTP(
                                first: false,
                                last: false,
                                textEditingController: textfield3),
                            _textFieldOTP(
                                first: false,
                                last: false,
                                textEditingController: textfield4),
                            _textFieldOTP(
                                first: false,
                                last: false,
                                textEditingController: textfield5),
                            _textFieldOTP(
                                first: false,
                                last: true,
                                textEditingController: textfield6),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              String otp = textfield1.text +
                                  textfield2.text +
                                  textfield3.text +
                                  textfield4.text +
                                  textfield5.text +
                                  textfield6.text;

                              print(otp);
                              var data = {
                                "request_id": widget.requestId,
                                "code": otp
                              };
                              context
                                  .read<OtpVerifyCubit>()
                                  .sendOtpVerifyData(data);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.purple),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Verify',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textFieldOTP(
      {bool? first, last, TextEditingController? textEditingController}) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextField(
          controller: textEditingController,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
