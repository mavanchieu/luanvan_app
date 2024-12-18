import 'dart:io';

import 'package:app_lv/client/manager/user_manager.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({super.key});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  File? imageFile;
  late String imageData = '';

  choiceImage() async {
    var pickerimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerimage != null) {
      setState(() {
        imageFile = File(pickerimage.path);
      });
      imageData = base64Encode(imageFile!.readAsBytesSync());
      return imageData;
    } else {
      return null;
    }
  }

  showImage(String image) {
    return Image.memory(
      base64Decode(image),
      width: 400,
      height: 400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cập nhật ảnh đại diện",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        actions: [],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              imageData == ''
                  ? const Text(
                      'Không có ảnh nào được chọn',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  : Column(
                      children: [
                        showImage(imageData),
                        const SizedBox(height: 20),
                      ],
                    ),
              const SizedBox(height: 20),
              SizedBox(
                width: 115,
                child: ElevatedButton(
                  onPressed: choiceImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Chọn ảnh',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 115,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    // _submit();
                    bool result = await context.read<UserManager>().updateImage(
                        context.read<LoginService>().userId, imageFile!);
                    if (result == true) {
                      toast(context, "Cập nhật ảnh thành công");
                    } else {
                      toast(context, "Có lỗi trong quá trình cập nhật");
                    }
                  },
                  child: const Text(
                    'Lưu',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
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
