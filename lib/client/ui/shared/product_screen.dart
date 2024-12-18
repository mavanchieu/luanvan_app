import 'package:flutter/widgets.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<String> _listBrandsName = [
    'Nike',
    'Adidas',
    'Levents',
    'DirtyCoins',
  ];

  final List<String> _listBrandsImage = [
    'assets/image/shop/men/nike.png',
    'assets/image/shop/men/adidas.png',
    'assets/image/shop/men/levents.webp',
    'assets/image/shop/men/dirtycoins.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
        right: 10,
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                "CÓ THỂ BẠN THÍCH",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _listBrandsName.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(
                          _listBrandsImage[index],
                        ),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        children: [
                          Text(
                            _listBrandsName[index],
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "800.000 vnd",
                            style: const TextStyle(
                                fontSize: 17,
                                color: Color.fromRGBO(74, 74, 74, 1),
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
      ),
    );
  }
}
