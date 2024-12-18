import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/signup.service.dart';
import 'package:app_lv/client/ui/login/login_screen.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _password1Controller;
  late TextEditingController _password2Controller;

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _showPassword = false;
  bool _showRepeatPassword = false;
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _password1Controller = TextEditingController();
    _password2Controller = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool signUp = await context
          .read<SignupService>()
          .signup(_usernameController.text, _password2Controller.text);
      if (signUp == false) {
        await showErrorDialog(context, "Đăng ký không thành công!");
      } else {
        await toast(context,
            "Bạn đăng ký tài khoản thành công, vui lòng đăng nhập đế sử dụng");
      }
    } catch (error) {
      if (mounted) {
        print("Đã xảy ra lỗi: $error");
        await showErrorDialog(context, "Đăng ký không thành công!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ĐĂNG KÝ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Tên đăng nhập",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(25),
                            //   ),
                            // ),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 29, 29, 29),
                              fontSize: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value! == "") {
                              return "Tên đăng nhập không được trống";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Mật khẩu",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _password1Controller,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.key),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: _showPassword == false
                                  ? const Icon(
                                      Icons.visibility,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                    ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 29, 29, 29),
                              fontSize: 16,
                            ),
                          ),
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value! == "") {
                              return "Tên đăng nhập không được trống";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Nhập lại mật khẩu",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _password2Controller,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.key),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showRepeatPassword = !_showRepeatPassword;
                                });
                              },
                              icon: _showRepeatPassword == false
                                  ? const Icon(
                                      Icons.visibility,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                    ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(25),
                            //   ),
                            // ),
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 29, 29, 29),
                              fontSize: 16,
                            ),
                          ),
                          obscureText: !_showRepeatPassword,
                          validator: (value) {
                            if (value! == "") {
                              return "Mật khẩu không được trống";
                            }
                            if (value != _password1Controller.text) {
                              return "Nhập lại mật khẩu không khớp";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 60, right: 60),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.purple
                          ], // Choose your gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(
                            12), // Border radius for rounded corners
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          _submit();
                        },
                        child: const Text(
                          "Đăng Ký",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 75, right: 75),
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
