import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/manager/search_manager.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/search/search_product_screen.dart';
import 'package:app_lv/client/ui/shared/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchName = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  final SocketService socketService = SocketService();
  Future<void> _submit(String searchName) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      if (searchName == null || searchName == "") {
        await toast(context, "Từ khóa không được trống");
      } else {
        context
            .read<SearchManager>()
            .create(context.read<LoginService>().userId, searchName);
      }
    } catch (error) {
      if (mounted) {
        print("Đã xảy ra lỗi: $error");
        await showErrorDialog(context, "Lỗi trong quá trình tìm kiếm!");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    socketService.connect();
    context
        .read<SearchManager>()
        .fetchByUserId(context.read<LoginService>().userId);

    socketService.on('createSearch', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('Favorite deleted: $data');
        await context
            .read<SearchManager>()
            .fetchByUserId(context.read<LoginService>().userId);
      }
    });
    socketService.on('deleteOneSearchName', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('deleteOneSearchName: $data');
        await context
            .read<SearchManager>()
            .fetchByUserId(context.read<LoginService>().userId);
      }
    });
    socketService.on('deleteAllSearchName', (data) async {
      // await fetchUserFavorites();
      if (mounted) {
        print('deleteAllSearchName: $data');
        await context
            .read<SearchManager>()
            .fetchByUserId(context.read<LoginService>().userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          key: _formKey,
          child: TextFormField(
            controller: _searchName,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 234, 233, 233),
              hintText: "Tìm kiếm sản phẩm",
              hintStyle: const TextStyle(fontSize: 18),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: GestureDetector(
                onTap: () async {
                  if (_searchName.text == null || _searchName.text == "") {
                    await toast(context, "Từ khóa không được trống");
                  } else {
                    context.read<SearchManager>().create(
                        context.read<LoginService>().userId, _searchName.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchProductScreen(searchName: _searchName.text),
                      ),
                    );
                  }
                },
                child: const Icon(
                  Icons.search_outlined,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 181, 181, 181),
                    ),
                    top: BorderSide(
                      color: Color.fromARGB(255, 181, 181, 181),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SẢN PHẨM ĐÃ XEM GẦN ĐÂY",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 20,
                left: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "LỊCH SỬ TÌM KIẾM",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<SearchManager>(
                        builder: (context, searchManager, child) {
                          if (searchManager.searchModel.isNotEmpty) {
                            return InkWell(
                              onTap: () {
                                searchManager.deleteAll(
                                    context.read<LoginService>().userId);
                              },
                              child: const Text(
                                "XÓA TẤT CẢ",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),

                      // InkWell(
                      //   onTap: () {
                      //     context
                      //         .read<SearchManager>()
                      //         .deleteAll(context.read<LoginService>().userId);
                      //   },
                      //   child: const Text(
                      //     "XÓA TẤT CẢ",
                      //     style: TextStyle(
                      //       fontSize: 19,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      children: [
                        Consumer<SearchManager>(
                          builder: (context, searchManager, child) {
                            if (searchManager.searchModel.isNotEmpty) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: searchManager.searchModel.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchProductScreen(
                                                        searchName:
                                                            searchManager
                                                                .searchModel[
                                                                    index]
                                                                .searchName),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            searchManager
                                                .searchModel[index].searchName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 25,
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 227, 226, 226),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(50),
                                            ),
                                            // border: Border.all(
                                            //   color: Colors.black,
                                            // ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<SearchManager>()
                                                  .deleteOne(searchManager
                                                      .searchModel[index].id);
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Color.fromARGB(
                                                  255, 70, 69, 69),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Hiện tại bạn không có từ khóa tìm kiếm nào!",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
