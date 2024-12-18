import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/manager/search_manager.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistorySearchScreen extends StatefulWidget {
  const HistorySearchScreen({super.key});

  @override
  State<HistorySearchScreen> createState() => _HistorySearchScreenState();
}

class _HistorySearchScreenState extends State<HistorySearchScreen> {
  final SocketService socketService = SocketService();

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
        title: const Text(
          "Lịch sử tìm kiếm",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                child: Text(
                  "Xóa tất cả",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Wrap(
              //   spacing: 8.0,
              //   runSpacing: 4.0,
              //   children: <Widget>[
              //     for (int i = 0; i < _listSearch.length; i++)
              //       Chip(
              //         label: Text(_listSearch[i]),
              //         onDeleted: () {},
              //       ),
              //   ],
              // ),
              Consumer<SearchManager>(
                builder: (context, searchManager, child) {
                  if (searchManager.searchModel.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Thêm padding nếu cần thiết
                      child: Wrap(
                        spacing: 8.0, // Khoảng cách giữa các Chip
                        runSpacing: 4.0, // Khoảng cách giữa các dòng Chip
                        alignment: WrapAlignment.start, // Bắt đầu từ trái
                        children: searchManager.searchModel.map((searchItem) {
                          return Chip(
                            label: Text(searchItem.searchName),
                            onDeleted: () {
                              context
                                  .read<SearchManager>()
                                  .deleteOne(searchItem.id);
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      "Hiện tại bạn không có từ khóa tìm kiếm nào!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
