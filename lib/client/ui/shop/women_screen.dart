import 'package:flutter/material.dart';

class WomenScreen extends StatefulWidget {
  const WomenScreen({super.key});

  @override
  State<WomenScreen> createState() => _WomenScreenState();
}

class _WomenScreenState extends State<WomenScreen> {
  final List<String> _listBrandsName = [
    'Nike',
    'Adidas',
    // 'Puma',
    'Levents',
    'DirtyCoins',
  ];

  final List<String> _listBrandsImage = [
    'assets/image/shop/women/nike.png',
    'assets/image/shop/women/adidas.png',
    // 'assets/image/shop/puma.webp',
    'assets/image/shop/men/levents.webp',
    'assets/image/shop/men/dirtycoins.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Nhãn hàng nổi bật",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
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
                    Image(
                      image: AssetImage(
                        _listBrandsImage[index],
                      ),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      _listBrandsName[index],
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 440,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/image/shop/women/nike_banner.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          const Positioned(
                            top: 35,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Quần",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 255, 85, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            child: Divider(
                              thickness: 5,
                              height: 215,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          const Positioned(
                            top: 145,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Áo",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 255, 85, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            child: Divider(
                              thickness: 5,
                              height: 435,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          const Positioned(
                            top: 255,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Giày Dép",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 255, 85, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 325,
                            child: Container(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: MediaQuery.of(context).size.width,
                              height: 5,
                            ),
                          ),
                          const Positioned(
                            top: 365,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Sale",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
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
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    "SẢN PHẨM MỚI",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 15),
                child: Container(
                  width: 140,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      left: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "XEM TẤT CẢ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.navigate_next,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _listBrandsName.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 290,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_listBrandsImage[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 10,
                                        bottom: 70,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 157, 156, 156),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(_listBrandsName[index]),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        bottom: 40,
                                        child: Text(
                                          _listBrandsName[index],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.favorite_outline,
                                            color: Colors.pink,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
