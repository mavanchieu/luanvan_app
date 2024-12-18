import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WarrantyScreen extends StatelessWidget {
  const WarrantyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chính sách bảo hành",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                "assets/image/account/system/warranty.png",
                width: 80,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '   MC - SHOP xin lỗi vì sự cố các thiết bị điện tử của quý khách'
                  ' bị hỏng và phải đi bảo hành. MC - SHOP có 2 hỗ trợ dành rieng cho khách hàng mua'
                  ' đồ điện tử tại shop như sau:',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Text(
                '   MC - SHOP sẽ cung cấp cho khách hàng một thiết bị điện tử khác đã qua sử dụng '
                'để khách hàng sử dụng tạm thời.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                '   Bảo hành 12 tháng nếu máy đi bảo hành quá 15 ngày hãng chưa trả máy cho khách hàng'
                ' hoặc phải bảo hành lại một lần nữa trong 30 ngày kể từ làn bảo hành trước'
                ', khách hàng được áp dụng phương thức hư gì đổi nấy ngay và luôn hoặc hoàn tiền với mức phí giảm 50%. '
                'Lưu ý: Chỉ áp dụng cho điện thoại và phải còn trong điều kiện bảo hành.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
