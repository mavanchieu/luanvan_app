import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/account/body/system/help/help_manager.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpFormScreen extends StatefulWidget {
  const HelpFormScreen({super.key});

  @override
  State<HelpFormScreen> createState() => _HelpFormScreenState();
}

class _HelpFormScreenState extends State<HelpFormScreen> {
  TextEditingController _fullname = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _question = TextEditingController();

  @override
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool add = await context.read<HelpManager>().create(
          context.read<LoginService>().userId,
          _fullname.text,
          _phone.text,
          _email.text,
          _question.text);
      if (add == false) {
        await showErrorDialog(context, "Bạn đặt câu hỏi không thành công!");
      } else {
        await toast(context, "Bạn đã đặt câu hỏi thành công");
      }
    } catch (error) {
      if (mounted) {
        print("Đã xảy ra lỗi: $error");
        await showErrorDialog(context, "Bạn đặt câu hỏi không thành công!");
      }
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Đặt Câu Hỏi",
          style: TextStyle(
            fontSize: 22,
            // fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Điền Thông Tin",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _fullname,
                      decoration: const InputDecoration(
                        hintText: "Nhập họ và tên",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _phone,
                      decoration: const InputDecoration(
                        hintText: "Nhập số điện thoại",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        hintText: "Nhập email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _question,
                      decoration: const InputDecoration(
                        hintText: "Nhập câu hỏi",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _submit();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.zero),
                                ),
                                side: const BorderSide(
                                  color: Colors.black,
                                )),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Gửi",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
