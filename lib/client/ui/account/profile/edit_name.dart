import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/signup.service.dart';
import 'package:app_lv/client/manager/user_manager.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  TextEditingController _fullname = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      bool signUp = await context
          .read<UserManager>()
          .editFullname(context.read<LoginService>().userId, _fullname.text);
      if (signUp == false) {
        await showErrorDialog(context, "Cập nhật không thành công!");
      } else {
        await toast(context, "Bạn đăng cập nhật thành công");
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sửa Tên",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                _submit();
              },
              child: const Text(
                "Lưu",
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 247, 104, 1)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _fullname,
                  decoration: const InputDecoration(
                    hintText: "Nhập tại đây",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.8),
                    ),
                  ),
                  validator: (value) {
                    if (value! == "") {
                      return "Tên đầy đủ không được trống";
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
