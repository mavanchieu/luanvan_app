import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KidScreen extends StatefulWidget {
  const KidScreen({super.key});

  @override
  State<KidScreen> createState() => _KidScreenState();
}

class _KidScreenState extends State<KidScreen> {
  final List<String> _listBrandsName = [
    'Nike',
    'Adidas',
    // 'Puma',
    'Levents',
    'DirtyCoins',
    'Levents',
    'DirtyCoins',
  ];

  final List<String> _listName = [
    'Nam',
    'Nữ',
    // 'Puma',
    'Nike',
    'Adidas',
    'Phong cách',
    'Cá tính',
  ];

  final List<String> _listBrandsImage = [
    'assets/image/shop/kid/adidas_2.png',
    'assets/image/shop/kid/adidas_3.png',
    // 'assets/image/shop/puma.webp',
    'assets/image/shop/kid/nike_2.png',
    'assets/image/shop/kid/adidas_4.png',
    'assets/image/shop/kid/nike.png',
    'assets/image/shop/kid/adidas.png',
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
                "Khám phá",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 450,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: _listBrandsName.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  index < 2 && index < 4
                      ? Container(
                          height: 205,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                _listBrandsImage[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 25,
                                      left: 20,
                                      child: Column(
                                        children: [
                                          Text(
                                            _listName[index],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                        )
                      : Container(
                          height: 205,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                _listBrandsImage[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 20,
                                      bottom: 5,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(_listName[index],
                                                  style:
                                                      // const TextStyle(
                                                      //   fontSize: 17,
                                                      //   fontWeight: FontWeight.w700,
                                                      //   color: Color.fromARGB(
                                                      //       255, 255, 255, 255),
                                                      // ),
                                                      GoogleFonts.aBeeZee(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  )),
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
                  // Container(
                  //   child: Image.asset(
                  //     _listBrandsImage[index],
                  //     fit: BoxFit.cover,

                  //   ),
                  // ),
                ],
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
                      "assets/image/shop/kid/nike_banner.png",
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
                            top: 37,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Quần",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            child: Divider(
                              thickness: 5,
                              height: 217,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          const Positioned(
                            top: 147,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Áo",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            child: Divider(
                              thickness: 5,
                              height: 437,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          const Positioned(
                            top: 257,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Giày Dép",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 327,
                            child: Container(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: MediaQuery.of(context).size.width,
                              height: 5,
                            ),
                          ),
                          const Positioned(
                            top: 367,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  "Sale",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(239, 255, 69, 1),
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
      ],
    );
  }
}
