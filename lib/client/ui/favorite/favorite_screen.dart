import 'package:app_lv/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:app_lv/client/ui/favorite/all_favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  final ScrollController scrollController;
  const FavoriteScreen({super.key, required this.scrollController});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: GlobalKey<NavigatorState>(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            //  return NotFavorite(scrollController: widget.scrollController);
            return AllFavoriteScreen(scrollController: widget.scrollController);
          },
        );
      },
    );
  }
}

// class NotFavorite extends StatefulWidget {
//   final ScrollController scrollController;
//   const NotFavorite({super.key, required this.scrollController});

//   @override
//   State<NotFavorite> createState() => _NotFavoriteState();
// }

// class _NotFavoriteState extends State<NotFavorite> {
//   @override
//   Widget build(BuildContext context) {
//     return NestedScrollView(
//       controller: widget.scrollController,
//       floatHeaderSlivers: true,
//       headerSliverBuilder: (context, innerBoxIsSCrolled) => [
//         SliverAppBar(
//           pinned: true,
//           floating: false,
//           snap: false,
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(4.0),
//             child: Container(
//               color: const Color.fromARGB(255, 213, 211, 211),
//               height: 1.0,
//             ),
//           ),
//           actions: [
//             const Icon(
//               Icons.favorite_outline,
//               size: 25,
//               color: Colors.pink,
//             ),
//             PopupMenuButton(
//               color: const Color.fromARGB(221, 0, 0, 0),
//               iconColor: Colors.black,
//               onSelected: (value) => (),
//               icon: const Icon(
//                 Icons.more_vert,
//               ),
//               itemBuilder: (ctx) => [
//                 PopupMenuItem(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       'Hủy yêu thích tất cả',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//           title: const Text("Danh sách yêu thích"),
//         ),
//       ],
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 20,
//                   right: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     const Row(
//                       children: [
//                         Text(
//                           "HIỆN TẠI KHÔNG CÓ SẢN PHẨM NÀO",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 20),
//                         ),
//                       ],
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 3),
//                       child: Row(
//                         children: [
//                           Text(
//                             "Nhấn vào icon trái tim để yêu thích.",
//                             style: TextStyle(fontSize: 17),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: SizedBox(
//                         height: 50,
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // bottomNavigationModel.setSelectedIndex(1);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.black,
//                           ),
//                           child: const Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'YÊU THÍCH NGAY',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.arrow_forward,
//                                     color: Colors.white,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class NotFavorite extends StatefulWidget {
  const NotFavorite({super.key});

  @override
  State<NotFavorite> createState() => _NotFavoriteState();
}

class _NotFavoriteState extends State<NotFavorite> {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    return Center(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "HIỆN TẠI KHÔNG CÓ SẢN PHẨM NÀO",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Row(
                  children: [
                    Text(
                      "Nhấn vào icon trái tim để yêu thích.",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      bottomNavigationModel.setSelectedIndex(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'YÊU THÍCH NGAY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    )));
  }
}
