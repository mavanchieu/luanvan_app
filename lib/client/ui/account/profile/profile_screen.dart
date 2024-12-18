import 'package:app_lv/client/manager/user_manager.dart';
import 'package:app_lv/client/models/login_model.dart';
import 'package:app_lv/client/models/user_model.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/account/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  void initState() {
    super.initState();
    context.read<UserManager>().fetchUsers(context.read<LoginService>().userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hồ sơ cá nhân",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
              child: const Text(
                "Sửa",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 220, 219, 219),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<UserManager>(builder: (context, value, child) {
                    if (value.user.id! != "") {
                      return value.user.image != null
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
                            );
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
                ],
              ),
            ),
            Column(
              children: [
                Consumer<UserManager>(
                  builder: (context, value, _) {
                    if (value.user.id != "") {
                      return Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
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
                                  onTap: () {},
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
                                  onTap: () {},
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
                                                      .format(
                                                          value.user.birth!),
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
                                  onTap: () {},
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
                                  onTap: () {},
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
                          )
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
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
