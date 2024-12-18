import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceivingAddressScreen extends StatelessWidget {
  const ReceivingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Địa chỉ nhận hàng",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        shadowColor: Colors.black,
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddreceivingAddress(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        const Text(
                          "Thêm địa chỉ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.navigate_next,
                            size: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 230, 228, 228),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Mã Văn Chiều",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            // ElevatedButton(
                            //   onPressed: () {
                            //     // Navigator.push(
                            //     //   context,
                            //     //   MaterialPageRoute(
                            //     //     builder: (context) =>
                            //     //         const AddreceivingAddress(),
                            //     //   ),
                            //     // );
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.white,
                            //     side: const BorderSide(
                            //       color: Colors.white,
                            //     ),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(0),
                            //     ),
                            //   ),
                            //   child: const Text(
                            //     "Mặc định",
                            //     style: TextStyle(
                            //         fontSize: 16, color: Colors.black),
                            //   ),
                            // ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditReceivingAddress(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "0388135076",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Hẻm 547, đường 30/4, phường Hưng Lợi, quận Ninh Kiều, TP Cần Thơ",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddreceivingAddress extends StatefulWidget {
  const AddreceivingAddress({super.key});

  @override
  State<AddreceivingAddress> createState() => _AddreceivingAddressState();
}

class _AddreceivingAddressState extends State<AddreceivingAddress>
    with WidgetsBindingObserver {
  // Hiển thị mật khẩu

  TextEditingController _fullname = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();

  double _containerHeight = 0.0;
  final double _defaultHeight = 180;
  final double _reducedHeight = 400;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _containerHeight = _defaultHeight;
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardVisible =
        // ignore: deprecated_member_use
        WidgetsBinding.instance.window.viewInsets.bottom > 0;

    setState(() {
      _containerHeight = keyboardVisible ? _reducedHeight : _defaultHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thêm địa chỉ nhận hàng",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight - _containerHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _fullname,
                        decoration: const InputDecoration(
                          labelText: "Họ và tên",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _phone,
                        decoration: const InputDecoration(
                          labelText: "Số điện thoại",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _address,
                        decoration: const InputDecoration(
                          labelText: "Địa chỉ nhận hàng",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LƯU",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditReceivingAddress extends StatefulWidget {
  const EditReceivingAddress({super.key});

  @override
  State<EditReceivingAddress> createState() => _EditReceivingAddressState();
}

class _EditReceivingAddressState extends State<EditReceivingAddress>
    with WidgetsBindingObserver {
  // Hiển thị mật khẩu

  TextEditingController _fullname = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();

  double _containerHeight = 0.0;
  final double _defaultHeight = 180;
  final double _reducedHeight = 400;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _containerHeight = _defaultHeight;
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardVisible =
        // ignore: deprecated_member_use
        WidgetsBinding.instance.window.viewInsets.bottom > 0;

    setState(() {
      _containerHeight = keyboardVisible ? _reducedHeight : _defaultHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chỉnh sửa địa chỉ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outline,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight - _containerHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _fullname,
                        decoration: const InputDecoration(
                          labelText: "Họ và tên",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _phone,
                        decoration: const InputDecoration(
                          labelText: "Số điện thoại",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _address,
                        decoration: const InputDecoration(
                          labelText: "Địa chỉ nhận hàng",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 17),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.8),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:  EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: [
                           Text(
                            "Cài làm mặc định",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LƯU THAY ĐỔI",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
