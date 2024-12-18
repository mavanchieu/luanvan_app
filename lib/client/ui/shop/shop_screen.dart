import 'package:app_lv/client/manager/gender_manager.dart';
import 'package:app_lv/client/ui/account/profile/edit_name.dart';
import 'package:app_lv/client/ui/product/product_detail/product_detail_screen.dart';
import 'package:app_lv/client/ui/search/search_screen.dart';
import 'package:app_lv/client/ui/shop/all_products.dart';
import 'package:app_lv/client/ui/shop/kid/gender/gender_shop_screen.dart';
import 'package:app_lv/client/ui/shop/kid_screen.dart';
import 'package:app_lv/client/ui/shop/men_screen.dart';
import 'package:app_lv/client/ui/shop/women_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class ShopScreen extends StatefulWidget {
  final ScrollController scrollController;
  const ShopScreen({super.key, required this.scrollController});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _selectedMenuIndex = 0;
  String _selectedGenderId = "";
  String _selectedGenderName = "";

  late List<Widget> _listStatus = [
    MenScreen(),
    const WomenScreen(),
    const KidScreen(),
    const KidScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeGenders();
  }

  void _initializeGenders() async {
    await context.read<GenderManager>().fetchGenders();
    setState(() {
      _selectedGenderId = context.read<GenderManager>().genderId();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return NestedScrollView(
            controller: widget.scrollController,
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsSCrolled) => [
              SliverAppBar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                pinned: true,
                floating: true,
                snap: true,
                shadowColor: Colors.black,
                elevation: 4,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(90.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const ProductDetailScreen(),
                            //   ),
                            // );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Shop",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllProducts(
                                        genderId: _selectedGenderId,
                                        genderName: _selectedGenderName,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Xem tất cả",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 120, 120, 120),
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Consumer<GenderManager>(
                          builder: (context, value, child) {
                            if (value.genders.isNotEmpty) {
                              return SizedBox(
                                height: 37,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: value.genders.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedMenuIndex = index;
                                            if (index == 0) {
                                              _selectedGenderId =
                                                  value.genders[0].id;
                                              _selectedGenderName =
                                                  value.genders[0].name;
                                            } else {
                                              _selectedGenderId =
                                                  value.genders[index].id;
                                              _selectedGenderName =
                                                  value.genders[index].name;
                                            }
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    _selectedMenuIndex == index
                                                        ? const Color.fromARGB(
                                                            255, 0, 0, 0)
                                                        : const Color.fromARGB(
                                                            0, 255, 255, 255),
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            value.genders[index].name
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight:
                                                  _selectedMenuIndex == index
                                                      ? FontWeight.w800
                                                      : FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          _listStatus[_selectedMenuIndex],
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
