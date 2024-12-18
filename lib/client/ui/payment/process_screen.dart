import 'package:flutter/material.dart';

class Process extends StatelessWidget {
  const Process({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Thông tin nhận hàng",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 143, 143, 143),
                      ),
                    ),
                    child: const Text(
                      "Sửa",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "Mã Văn Chiều",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const Text(
                "Hẻm 547, đường 30/4, Hưng Lợi, Ninh Kiều, TP Cần Thơ",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const Text(
                "0388135076",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const Text(
                "chieub2005665@student.ctu.edu.vn",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              thickness: 0.5,
              color: Color.fromARGB(255, 143, 143, 143),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Thời gian giao hàng",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 143, 143, 143),
                      ),
                    ),
                    child: const Text(
                      "Sửa",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "250.000 vnd Phí vận chuyển",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                "Ngày giao: 17 - 20/07/2024",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              thickness: 0.5,
              color: Color.fromARGB(255, 143, 143, 143),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Thanh toán",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 143, 143, 143),
                      ),
                    ),
                    child: const Text(
                      "Sửa",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "Số tiền được giảm: 100.000 vnd",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Row(
                children: [
                  Text(
                    "Tổng thanh toán: ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "2.050.000 vnd",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "Hình thức thanh toán: ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Tiền mặt",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
