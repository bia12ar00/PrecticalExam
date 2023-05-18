// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practical_exam/Cubit/Welcome/welcome_cubit.dart';
import 'package:practical_exam/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeCubit, WelcomeState>(
      listener: (context, state) {
        if (state.status == WelcomeStatus.success) {
          if (state.welcomeDataModel?.status ?? false) {
            Fluttertoast.showToast(msg: state.welcomeDataModel?.response ?? '');
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            ), (route) => false);
          } else {
            Fluttertoast.showToast(msg: state.welcomeDataModel?.response ?? '');
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Looks like you are new here. Tell us a bit about yourself.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldDesign(
                    textName: 'Name', textEditingController: nameController),
                TextFieldDesign(
                    textName: 'Email', textEditingController: emailController),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text != '') {
                        if (emailController.text != '') {
                          var data = {
                            "name": nameController.text,
                            "email": emailController.text
                          };
                          context.read<WelcomeCubit>().sendWelcomeData(data);
                        } else {
                          Fluttertoast.showToast(msg: 'Please Enter Email Id');
                        }
                      } else {
                        Fluttertoast.showToast(msg: 'Please Enter Name');
                      }

                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      //   builder: (context) {
                      //     return const Welcome();
                      //   },
                      // ), (route) => false);
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldDesign extends StatelessWidget {
  String textName;

  TextEditingController textEditingController;
  TextFieldDesign({
    super.key,
    required this.textName,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            //    color: colorFromHex('#F1F1F1'),
            ),
        borderRadius: BorderRadius.circular(6.0),
        //  color: colorFromHex('#FFFFFF'),
      ),
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.only(top: 14),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              controller: textEditingController,
              style: const TextStyle(
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                  // color: colorFromHex('#000000'),
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
              decoration: InputDecoration(
                hintText: textName,
                border: InputBorder.none,
                hintStyle: const TextStyle(
                    //   color: colorFromHex('#7E7E7E'),
                    fontWeight: FontWeight.w300,
                    fontSize: 13),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
