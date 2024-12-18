import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/manager/user_manager.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen>
    with WidgetsBindingObserver {
  //  form thay đổi mật khẩu

  final GlobalKey<FormState> _formKey = GlobalKey();
  // Hiển thị mật khẩu
  final TextEditingController _pass1 = TextEditingController();
  bool _showPass1 = false;
  final TextEditingController _pass2 = TextEditingController();
  bool _showPass2 = false;
  final TextEditingController _pass3 = TextEditingController();
  bool _showPass3 = false;

  double _containerHeight = 0.0;
  final double _defaultHeight = 180;
  final double _reducedHeight = 400;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _containerHeight = _defaultHeight;
    _pass1.clear();
    _pass2.clear();
    _pass3.clear();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardVisible =
        WidgetsBinding.instance!.window.viewInsets.bottom > 0;

    setState(() {
      _containerHeight = keyboardVisible ? _reducedHeight : _defaultHeight;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool loginResponse = await context
          .read<UserManager>()
          .editPassword(context.read<LoginService>().userId, _pass3.text);
      if (loginResponse == false) {
        await showErrorDialog(context, "Cập nhật không thành công!");
      } else {
        await toast(context, "Bạn đã thay đổi mật khẩu thành công");
        await context.read<LoginService>().logout();
      }
    } catch (error) {
      if (mounted) {
        print("Đã xảy ra lỗi: $error");
        await showErrorDialog(context, "Cập nhật không thành công!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thay đổi mật khẩu",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight - _containerHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _pass1,
                          decoration: InputDecoration(
                            labelText: "Nhập mật khẩu hiện tại",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 17),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.8),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPass1 = !_showPass1;
                                });
                              },
                              icon: Icon(
                                _showPass1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _showPass1 ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ),
                          obscureText: !_showPass1,
                          validator: (value) {
                            if (value == "") {
                              return "Không được trống";
                            }
                            // if (_pass1.text !=
                            //     context.read<LoginService>().password) {
                            //   return "Mật khẩu hiện tại không đúng";
                            // }
                            // if (value ==
                            //     context.read<LoginService>().password) {
                            //   return "Mật khẩu hợp lệ";
                            // }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _pass2,
                          decoration: InputDecoration(
                            labelText: "Nhập mật khẩu mới",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 17),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.8),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPass2 = !_showPass2;
                                });
                              },
                              icon: Icon(
                                _showPass2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _showPass2 ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ),
                          obscureText: !_showPass2,
                          validator: (value) {
                            if (value == "") {
                              return "Không được trống";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _pass3,
                          decoration: InputDecoration(
                            labelText: "Nhập lại mật khẩu mới",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 17),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.8),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPass3 = !_showPass3;
                                });
                              },
                              icon: Icon(
                                _showPass3
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _showPass3 ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ),
                          obscureText: !_showPass3,
                          validator: (value) {
                            if (value == "") {
                              return "Không được trống";
                            }
                            if (_pass3.text != _pass2.text) {
                              return "Nhập lại mật khẩu không khớp";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LƯU THAY ĐỔI",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
