import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_lv/client/manager/brand_manager.dart';
import 'package:app_lv/client/manager/collection_manager.dart';
import 'package:app_lv/client/manager/product_manager.dart';
import 'package:app_lv/client/models/brand_model.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/ui/collection/brand_collection_screen.dart';
import 'package:app_lv/client/ui/collection/seasonal_collection_screen.dart';
import 'package:app_lv/client/ui/homepage/discountCodes_screen.dart';
import 'package:app_lv/client/ui/product/product_detail/product_detail_screen.dart';
import 'package:app_lv/client/ui/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomePageScreen({super.key, required this.scrollController});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  DateTime now = DateTime.now();

  //Danh sách tháng bằng tiếng anh
  final List<String> englishMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  //Chuyển thứ sang tiếng anh
  String _getDayOfWeek(int dayIndex) {
    switch (dayIndex) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Lấy thứ tiếng anh
    String dayName = _getDayOfWeek(now.weekday);

    //Lấy tháng tiếng anh
    String monthName = englishMonths[now.month - 1];
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  snap: false,
                  backgroundColor: Colors.white,
                  title: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'MC - SHOP',
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 1, 149, 163),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TyperAnimatedText(
                        'Xin chào, ${context.read<LoginService>().username}',
                        textStyle: GoogleFonts.aboreto(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  shadowColor: Colors.black,
                  elevation: 4,
                  actions: [
                    Row(
                      children: [
                        const Column(
                          children: [],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 14),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SearchScreen()));
                                },
                                child: const Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '$dayName, ${now.day} $monthName',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                            const DiscountCodesScreen(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 400,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/image/homepage/adidas.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  "SỰ KIỆN THỂ THAO",
                                                  style: GoogleFonts.aBeeZee(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  // style: TextStyle(
                                                  //   fontSize: 17,
                                                  //   fontWeight: FontWeight.bold,
                                                  //   color: Color.fromARGB(
                                                  //       255, 255, 255, 255),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 80,
                                            left: 60,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  "THỂ THAO MÙA HÈ",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 20,
                                            left: 60,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "KHÁM PHÁ THÊM",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 70,
                                                    ),
                                                    Icon(Icons.navigate_next),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 64,
                                            bottom: 14,
                                            child: Container(
                                              width: 260,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
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
                            const Padding(
                              padding: EdgeInsets.only(top: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "  Sản Phẩm Mới",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Xem Tất Cả",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 95, 95, 95),
                                        ),
                                      )
                                    ],
                                  ),
                                  NewProductScreen(),
                                ],
                              ),
                            ),
                            const BrandCollection(),
                            const SeasonalCollection(),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Container(
                                    height: 780,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            top: 30,
                                            right: 15,
                                            left: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Sản Phẩm Gợi Ý",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "Xem Tất Cả",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: Container(
                                            height: 350,
                                            width: 300,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/image/homepage/goiy_nike.png",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20,
                                            left: 15,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "6 Sản phẩm dành cho bạn",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              TopSellScreen(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 40,
                                            left: 40,
                                          ),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 74, 74, 74),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "Xem Tất Cả",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 30,
                                bottom: 50,
                              ),
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      "assets/image/homepage/logo_shop.png",
                                    ),
                                    width: 300,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Cảm ơn bạn đã đồng hành cùng chúng tôi.",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}

class TopSellScreen extends StatefulWidget {
  const TopSellScreen({super.key});

  @override
  State<TopSellScreen> createState() => _TopSellScreenState();
}

class _TopSellScreenState extends State<TopSellScreen> {
  // Danh sách ảnh và tên
  final List<String> _listBrandsName = [
    'Nike',
    'Adidas',
    // 'Puma',
    'Levents',
    'DirtyCoins',
  ];

  final List<String> _listBrandsImage = [
    'assets/image/shop/men/nike.png',
    'assets/image/shop/men/adidas.png',
    // 'assets/image/shop/puma.webp',
    'assets/image/shop/men/levents.webp',
    'assets/image/shop/men/dirtycoins.webp',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _listBrandsName.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: AssetImage(_listBrandsImage[index]),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _listBrandsName[index],
                          style: const TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  // Danh sách ảnh và tên
  final List<String> _listBrandsName = [
    'Nike',
    'Adidas',
    'Levents',
    'DirtyCoins',
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductManager>().fetchAllProducts();
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 450,
          child: Consumer<ProductManager>(
            builder: (context, value, child) {
              if (value.allProducts.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.allProducts.length > 10
                      ? 10
                      : value.allProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "http://192.168.56.1:3005/${change(value.allProducts[index].colors![0].images![0])}")),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 20,
                                  left: 20,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        value.allProducts[index].name!,
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 40,
                                  left: 60,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailScreen(
                                                  id: value
                                                      .allProducts[index].id!),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "MUA NGAY",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 70,
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 66,
                                  bottom: 35,
                                  child: Container(
                                    width: 200,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      right: BorderSide(
                                        color: Colors.black,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.black,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("Hiện tại không có sản phẩm"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class BrandCollection extends StatefulWidget {
  const BrandCollection({super.key});

  @override
  State<BrandCollection> createState() => _BrandCollectionState();
}

class _BrandCollectionState extends State<BrandCollection> {
  @override
  void initState() {
    super.initState();
    context.read<CollectionManager>().fetchAllBrandCollection();
    context.read<BrandManager>().fetchBrands();
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer2<CollectionManager, BrandManager>(
          builder: (context, value, value1, child) {
            if (value.brandCollection.isNotEmpty) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.brandCollection.length,
                itemBuilder: (context, index) {
                  var brand = value1.brands
                      .where((element) =>
                          element.id == value.brandCollection[index].brandId!)
                      .toList();
                  return Column(
                    children: [
                      index == 0
                          ? const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bộ Sưu Tập",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://192.168.56.1:3005/${change(value.brandCollection[index].images?[0])}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 80,
                                      left: 20,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "BỘ SƯU TẬP",
                                                style: GoogleFonts.inter(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                " ${brand[0].name}",
                                                style: GoogleFonts.inter(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 30,
                                      left: 20,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BrandCollectonScreen(
                                                          id: value
                                                              .brandCollection[
                                                                  index]
                                                              .brandId!),
                                                ),
                                              );
                                            },
                                            child: const Row(
                                              children: [
                                                Text(
                                                  "Khám phá",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

class SeasonalCollection extends StatefulWidget {
  const SeasonalCollection({super.key});

  @override
  State<SeasonalCollection> createState() => _SeasonalCollectionState();
}

class _SeasonalCollectionState extends State<SeasonalCollection> {
  @override
  void initState() {
    super.initState();
    context.read<CollectionManager>().fetchAllSeasonalCollection();
  }

  String change(String? path) {
    return path!.replaceAll('\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<CollectionManager>(
          builder: (context, value, child) {
            if (value.seasonalCollection.isNotEmpty) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.seasonalCollection.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      index == 0
                          ? const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bộ Sưu Tập Theo Mùa",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://192.168.56.1:3005/${change(value.seasonalCollection[index].images?[0])}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 80,
                                      left: 20,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                value.seasonalCollection[index]
                                                    .collectionName!,
                                                style: GoogleFonts.inter(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 30,
                                      left: 20,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SeasonalCollectionScreen(
                                                          id: value
                                                              .seasonalCollection[
                                                                  index]
                                                              .id!),
                                                ),
                                              );
                                            },
                                            child: const Row(
                                              children: [
                                                Text(
                                                  "Khám phá",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
