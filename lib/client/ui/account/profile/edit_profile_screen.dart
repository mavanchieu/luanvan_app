import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/account/profile/edit_email.dart';
import 'package:app_lv/client/ui/account/profile/edit_image_screen.dart';
import 'package:app_lv/client/ui/account/profile/edit_name.dart';
import 'package:app_lv/client/ui/account/profile/edit_phone.dart';
import 'package:app_lv/client/manager/user_manager.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _selectedGender = "Nam";
  final List<String> _genders = ["Nam", "Nữ", "Khác"];
  String? _tempGender;

  GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit(String gender1) async {
    try {
      bool gender = await context
          .read<UserManager>()
          .editGender(context.read<LoginService>().userId, gender1);
      if (gender == false) {
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

  Future<void> _submitDate(String date) async {
    try {
      bool date1 = await context
          .read<UserManager>()
          .editDate(context.read<LoginService>().userId, date);
      if (date1 == false) {
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

  void _showGenderSelection() {
    _tempGender = _selectedGender;

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text(
            "Chọn giới tính",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            Container(
              height: 120,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: _genders.indexOf(_tempGender!),
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _tempGender = _genders[index];
                  });
                },
                itemExtent: 32.0,
                children: _genders.map((gender) {
                  return Center(
                    child: Text(gender),
                  );
                }).toList(),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _selectedGender = _tempGender ?? _selectedGender;
              });
              Navigator.pop(context);
            },
            isDestructiveAction: true,
            child: GestureDetector(
              onTap: () {
                _submit(_selectedGender);
              },
              child: const Text(
                "Lưu",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        );
      },
    );
  }

  DateTime _selectedDate = DateTime.now();
  DateTime _tempDate = DateTime.now();

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text(
            "Chọn ngày sinh",
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            SizedBox(
              height: 216,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _tempDate,
                onDateTimeChanged: (dateTime) {
                  _tempDate = dateTime;
                },
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _selectedDate = _tempDate;
              });

              Navigator.pop(context);
            },
            child: GestureDetector(
              onTap: () {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(_selectedDate);
                _submitDate(formattedDate);
              },
              child: const Text(
                "Lưu",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<UserManager>().fetchUsers(context.read<LoginService>().userId);
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat =
        "${_selectedDate.day.toString().padLeft(2, '0')}/${(_selectedDate.month).toString().padLeft(2, '0')}/${_selectedDate.year}";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chỉnh sửa thông tin cá nhân",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<UserManager>(builder: (context, value, child) {
              if (value.user.id! != "") {
                return Container(
                  color: const Color.fromARGB(255, 220, 219, 219),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      value.user.image != null
                          ? CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 40,
                              backgroundImage: NetworkImage(
                                "http://192.168.56.1:3005/${change(value.user.image)}",
                              ),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 40,
                            ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditImageScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(),
                        child: const Text(
                          "Thay đổi",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            Column(
              children: [
                Consumer<UserManager>(
                  builder: (context, value, child) {
                    if (value.user.id != "") {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EditName(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Họ và tên",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // ignore: unnecessary_null_comparison
                                        value.user.fullname! != null
                                            ? Text(
                                                value.user.fullname!,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                ),
                                              )
                                            : const Text(
                                                "Trống",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.red),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(Icons.navigate_next)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 10,
                            color: Color.fromARGB(255, 221, 220, 220),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: _showGenderSelection,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Giới tính",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      value.user.gender! != null
                                          ? Text(
                                              value.user.gender!,
                                              style: const TextStyle(
                                                fontSize: 17,
                                              ),
                                            )
                                          : const Text(
                                              "Trống",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.red),
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.navigate_next)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: _showDatePicker,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Ngày sinh",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      value.user.birth != null
                                          ? Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(value.user.birth!),
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 17,
                                              ),
                                            )
                                          : const Text(
                                              "Trống",
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.red,
                                              ),
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.navigate_next)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 10,
                            color: Color.fromARGB(255, 221, 220, 220),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EditPhone(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Số điện thoại",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      value.user.phone != null
                                          ? Text(
                                              value.user.phone!,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 17,
                                              ),
                                            )
                                          : const Text(
                                              "trống",
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.red,
                                              ),
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.navigate_next)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EditEmail(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      value.user.email != null
                                          ? Text(
                                              value.user.email!,
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 17,
                                              ),
                                            )
                                          : const Text(
                                              "Trống",
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.red,
                                              ),
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.navigate_next)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 10,
                            color: Color.fromARGB(255, 221, 220, 220),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("Lỗi hiển thị người dùng"),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
