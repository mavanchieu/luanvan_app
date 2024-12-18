import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:app_lv/client/models/cart_model.dart';
import 'package:app_lv/client/models/evaluation_model.dart';
import 'package:app_lv/client/models/order_model.dart';
import 'package:app_lv/client/models/product_model.dart';
import 'package:app_lv/client/services/cart.service.dart';
import 'package:app_lv/client/services/evaluation.service.dart';
import 'package:app_lv/client/services/order.service.dart';
import 'package:app_lv/client/services/product.servcie.dart';
import 'package:app_lv/client/services/userDiscountCode.service.dart';
import 'package:app_lv/client/ui/account/body/shop/userDiscountCode_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductManager with ChangeNotifier {
  //Lưu chi tiết sản phẩm
  List<ProductModel> _productDetails = [];
  List<ProductModel> get productDetails => _productDetails;

  // Lưu tất cả sản phẩm // trường hợp hidden == false
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  // Lưu tất cả sản phẩm //
  List<ProductModel> _allProducts = [];
  List<ProductModel> get allProducts => _allProducts;

  // Lưu sản phẩm theo genderId
  List<ProductModel> _productsByGenderId = [];
  List<ProductModel> get productsByGenderId => _productsByGenderId;

  // Lưu giỏ hàng của người dùng theo userId
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;

  // Lưu danh sách sản phẩm khi tìm kiếm
  List<ProductModel> _searchList = [];
  List<ProductModel> get searchList => _searchList;

  // Lưu danh sách orders của người dùng
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  Future<List<ProductModel>> fetchProduct() async {
    try {
      var productService = ProductService();
      _products = await productService.getAll();
      // print(_products.length);
      notifyListeners();
      return _products;
    } catch (e) {
      print(e);
    }
    return _products;
  }

// tất cả sản phẩm kể cả hidden true hoặc false
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      var productService = ProductService();
      _allProducts = await productService.getAllProducts();
      notifyListeners();
      return _products;
    } catch (e) {
      print(e);
    }
    return _products;
  }

  // fetch sản phẩm theo genderId
  Future<List<ProductModel>> fetchProductsByGenderId(String id) async {
    _productsByGenderId = [];
    await fetchProduct();
    try {
      _productsByGenderId = products.where((product) {
        return product.genderId == id;
      }).toList();
      notifyListeners();
      return _productsByGenderId;
    } catch (e) {
      print(e);
    }
    return _productsByGenderId;
  }

  // fetch chi tiết sản phẩm theo id
  Future<List<ProductModel>> fetchProductById(String id) async {
    await fetchProduct();
    try {
      _productDetails = products.where((product) {
        return product.id == id;
      }).toList();
      notifyListeners();
      return _productDetails;
    } catch (e) {
      print(e);
    }
    return _productDetails;
  }

  // Quản lý giỏ hàng
  Future<List<CartModel>> fetchCarts(String userId) async {
    _carts.clear();
    try {
      var cartService = CartService();
      _carts = await cartService.getByUserId(userId);
      notifyListeners();
      return _carts;
    } catch (e) {
      print(e);
    }
    return _carts;
  }

  Future<bool> createCart(String userId, String productId, String colorItemId,
      String sizeId, int quantity, int quantityInStock) async {
    await fetchCarts(userId);
    try {
      bool item = _carts.any((element) =>
          element.userId == userId &&
          element.productId == productId &&
          element.colorItemId == colorItemId &&
          element.sizeId == sizeId);
      // print(item!);
      if (item == true) {
        var item1 = _carts.firstWhere((element) =>
            element.userId == userId &&
            element.productId == productId &&
            element.colorItemId == colorItemId &&
            element.sizeId == sizeId);
        int newQuantity = quantity + item1.quantity;
        if (newQuantity > quantityInStock) {
          return false;
        } else {
          var cartService = CartService();
          bool result = await cartService.updateCart(item1.id, newQuantity);
          if (result == true) {
            fetchCarts(userId);
            notifyListeners();
            return true;
          }
        }
      } else {
        // print(colorItemId);
        var cartService = CartService();
        bool result = await cartService.create(
            userId, productId, colorItemId, sizeId, quantity);
        if (result == true) {
          await fetchCarts(userId);
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  // Cập nhật số lượng từ giỏ hàng
  Future<String> updateCart(CartModel cart) async {
    const message = "";
    try {
      await fetchAllProducts();

      ProductModel product =
          _allProducts.firstWhere((element) => element.id! == cart.productId);
      ColorItem colorItem = product.colors!
          .firstWhere((element) => element.id! == cart.colorItemId);
      Size size =
          colorItem.sizes!.firstWhere((element) => element.id! == cart.sizeId);
      if (cart.quantity > size.quantity!) {
        return "Vượt quá số lượng trong kho";
      }
      if (cart.quantity <= size.quantity!) {
        var cartService = CartService();
        bool result = await cartService.updateCart(cart.id, cart.quantity);
        if (result == true) {
          notifyListeners();
          return "Cập nhật số lượng sản phẩm thành công";
        }
      }
    } catch (e) {
      print(e);
      return "Lỗi";
    }
    return "Lỗi";
  }

  Future<bool> deleteOneCart(String cartId) async {
    try {
      // print(cartId);
      var cartService = CartService();
      bool result = await cartService.deleteOne(cartId);
      if (result == true) {
        var cart = _carts.firstWhere((element) => element.id == cartId);
        _carts.remove(cart);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  Future<bool> deleteAllCart(String userId) async {
    try {
      // print(cartId);
      var cartService = CartService();
      bool result = await cartService.deleteAll(userId);
      if (result == true) {
        _carts.clear();
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  //Tổng thanh toán
  double totalPrice() {
    // print(_allProducts.length);
    double total = 0.0;
    for (var cart in _carts) {
      var product =
          _allProducts.firstWhere((element) => element.id == cart.productId);

      var color = product.colors!
          .firstWhere((element) => element.id == cart.colorItemId);
      total = total +
          (cart.quantity *
              (color.price! - (color.price! * product.discount! / 100)));
    }
    total = double.parse(total.toStringAsFixed(2));
    print(total);
    // notifyListeners();

    return total;
  }

  double totalPricePayment(String useId) {
    double total = 0.0;
    // print(_products.length);
    for (var cart in _carts) {
      var product =
          _products.firstWhere((element) => element.id == cart.productId);

      var color = product.colors!
          .firstWhere((element) => element.id == cart.colorItemId);
      total = total +
          (cart.quantity *
              (color.price! - (color.price! * product.discount! / 100)));
    }
    total = double.parse(total.toStringAsFixed(2));
    print("cart ${_carts.length}");
    print("Payment ${total}");
    return total;
  }

  // phần tìm kiếm sản phẩm
  Future<List<ProductModel>> fetchSearchProduct(String searchName) async {
    fetchProduct();
    _searchList.clear();
    try {
      for (var product in _products) {
        if (product.name!.toLowerCase().contains(searchName.toLowerCase())) {
          _searchList.add(product);
        }
      }
    } catch (error) {
      print(error);
    }
    // print(_searchList.length);
    notifyListeners();
    return _searchList;
  }

  // Quản lý đơn hàng
  // fetch đơn hàng theo userId
  List<OrderModel> _handleOrders = [];
  List<OrderModel> get handleOrders => _handleOrders;

  List<OrderModel> _orderConfirmed = []; // đơn hàng đã được xác nhận
  List<OrderModel> get orderConfirmed => _orderConfirmed;

  List<OrderModel> _orderDelivery = []; // đơn hàng đã được xác nhận
  List<OrderModel> get orderDelivery => _orderDelivery;

  List<OrderModel> _evals = []; // sản phẩm đã nhận
  List<OrderModel> get evals => _evals;

  // Quản lý đơn hàng
  Future<List<OrderModel>> fetchOrders(String userId) async {
    _orders.clear();
    _handleOrders.clear();
    try {
      var orderService = OrderService();
      _orders = await orderService.getByUserId(userId);
      if (_orders.isNotEmpty) {
        _handleOrders = _orders.where((order) => order.status == '0').toList();
        _orderConfirmed =
            _orders.where((order) => order.status == '1').toList();
        _orderDelivery = _orders.where((order) => order.status == '3').toList();
        _evals = _orders.where((order) => order.status == '2').toList();
        print(_evals.length);
      }
      notifyListeners();
      return _orders;
    } catch (e) {
      print(e);
    }
    return _orders;
  }

  // Thêm đơn hàng mới // id là id của bảng userDiscountCode
  Future<bool> addOrder(
      String fullname,
      String address,
      String phone,
      String email,
      String paymentMethod,
      String userId,
      int discount,
      String userDiscountCodeId,
      String code) async {
    try {
      // các thông số có sẵn
      double total = 0;
      print(discount);
      if (discount != 0) {
        total = totalPrice() - (totalPrice() * discount / 100);
      } else {
        total = totalPrice();
      }

      print(total);
      String totalString = total.toInt().toString();

      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      DateTime now = DateTime.now();
      String formattedDate = formatter.format(now);

      var orderService = OrderService();
      List<Map<String, dynamic>> cartOrders = [];
      for (int i = 0; i < carts.length; i++) {
        ProductModel pro =
            products.firstWhere((element) => element.id! == carts[i].productId);
        ColorItem colorItem = pro.colors!
            .firstWhere((element) => element.id == carts[i].colorItemId);
        Size size = colorItem.sizes!
            .firstWhere((element) => element.id! == carts[i].sizeId);

        cartOrders.add({
          'productId': carts[i].productId,
          'productName': pro.name!,
          'discount': pro.discount!,
          'colorItemId': carts[i].colorItemId,
          'colorItemName': colorItem.name!,
          'sizeId': carts[i].sizeId,
          'sizeName': size.name!,
          'quantity': carts[i].quantity,
          'price': colorItem.price!,
          'image': colorItem.images![0].replaceFirst("uploads\\", ""),
        });
      }

      bool result = await orderService.create(
          fullname,
          address,
          phone,
          email,
          userId,
          cartOrders,
          totalString,
          formattedDate,
          paymentMethod,
          discount,
          userDiscountCodeId,
          code);

      if (result == true) {
        await fetchOrders(userId);
        var productService = ProductService();
        for (int j = 0; j < carts.length; j++) {
          List<ProductModel> product =
              await fetchProductById(carts[j].productId);
        }

        var cartService = CartService();
        bool result2 = await cartService.deleteAll(userId);
        if (result2 == true) {
          carts.clear();
          var userDiscountCodeService = UserDiscountCodeService();
          bool result =
              await userDiscountCodeService.update(userDiscountCodeId);
        }
        notifyListeners();
        return true;
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Hủy đơn hàng
  Future<bool> deleteOneOrder(String orderId, String id) async {
    print(orderId);
    try {
      var productService = ProductService();

      if (orderId != "") {
        var order = _orders.firstWhere((element) => element.id == orderId);
        for (int i = 0; i < order.products.length; i++) {
          await productService.updateInscreaseQuantity(
              order.products[i].colorItemId,
              order.products[i].sizeId,
              order.products[i].quantity);
          print(order.products[i].colorItemId);
          print(order.products[i].sizeId);
          print(order.products[i].quantity);

          List<ProductModel> product =
              await fetchProductById(order.products[i].productId);
        }
        bool result = await productService.deleteOneOrder(orderId);
        if (result) {
          var userDiscountCodeService = UserDiscountCodeService();
          bool result1 = await userDiscountCodeService.update(id);
        }

        _handleOrders.remove(order);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  //fetch tất cả evaluations theo userId
  List<EvaluationModel> _allEvals = [];
  List<EvaluationModel> get allEvals => _allEvals;

  List<EvaluationModel> _evalsByUserId = [];
  List<EvaluationModel> get evalsByUserId => _evalsByUserId;

  Future<List<EvaluationModel>> fetchEvalutions(String userId) async {
    try {
      var evalService = EvaluationService();
      _allEvals = await evalService.getEvaluations();
      _evalsByUserId =
          _allEvals.where((eval) => eval.userId == userId).toList();
      notifyListeners();
      return _evalsByUserId;
    } catch (e) {
      print(e);
    }
    return _evalsByUserId;
  }

  // fetch Evaluations của  1 sản phẩm
  List<EvaluationModel> _evalsByProId = [];
  List<EvaluationModel> get evalsByProId => _evalsByProId;

  Future<List<EvaluationModel>> fetchEvalsByProId(String productId) async {
    try {
      var evalService = EvaluationService();
      _evalsByProId = await evalService.getEvaluations();
      if (_evalsByProId.isNotEmpty) {
        _evalsByProId =
            _evalsByProId.where((eval) => eval.productId == productId).toList();
        print("Số đánh giá  ${_evalsByProId.length}");
      }
      // await rateEval(productId);
      notifyListeners();
      return _evalsByProId;
    } catch (e) {
      print(e);
    }
    return _evalsByProId;
  }

  Future<void> handleLike(
      String productId, String userId, String evalId) async {
    try {
      var evalService = EvaluationService();
      await evalService.handleLike(userId, evalId);
      await fetchEvalsByProId(productId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  double _rate = 0.0;
  double get rate => _rate;
  Future<double> rateEval(String productId) async {
    await fetchEvalsByProId(productId);
    int total = 0;
    for (var eva in _evalsByProId) {
      double rate = double.parse(eva.rate);
      int t = rate.toInt();
      total = total + t;
    }
    print("so dah gia ${rate}");
    _rate = total / _evalsByProId.length;
    return _rate;
  }

  // thêm đánh giá
  // productOrderId là _id trong products của order
  Future<bool> addToRate(
    String userId,
    String productOrderId,
    String productId,
    bool incognito,
    String content,
    double rate,
    String sizeName,
    String colorItemName,
    String fullname,
    List<File> images,
  ) async {
    await fetchOrders(userId);
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      DateTime now = DateTime.now();
      String date = formatter.format(now);
      var evalService = EvaluationService();
      bool reuslt = await evalService.addToRate(
          userId,
          productOrderId,
          productId,
          incognito,
          content,
          rate,
          sizeName,
          colorItemName,
          fullname,
          date,
          images);
      if (reuslt == true) {
        await fetchEvalutions(userId);
        notifyListeners();
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Lọc sản phẩm
  List<ProductModel> _filters = [];
  List<ProductModel> _filterBrandIds = [];
  List<ProductModel> get filters => _filters;
  Future<List> fetchFilter(String genderId, List<String> brandIds,
      List<String> typeDetailIds) async {
    await fetchProductsByGenderId(genderId);
    // cả 2 không có
    if (brandIds.isEmpty && typeDetailIds.isEmpty) {
      _filters = [];
    }
    // Có brandIds
    else if (brandIds.isNotEmpty && typeDetailIds.isEmpty) {
      _filters = _productsByGenderId
          .where((product) => brandIds.contains(product.brandId))
          .toList();
    }
    // Có typeDetailsId
    else if (brandIds.isEmpty && typeDetailIds.isNotEmpty) {
      _filters = _productsByGenderId
          .where((product) => typeDetailIds.contains(product.typeDetailsId!))
          .toList();
    }
    // Lọc cả 2
    else {
      _filterBrandIds = _productsByGenderId
          .where((product) => brandIds.contains(product.brandId))
          .toList();
      _filters = _filterBrandIds
          .where((product) => typeDetailIds.contains(product.typeDetailsId!))
          .toList();
    }
    print(brandIds.length);
    print(typeDetailIds.length);
    print("Số sản phẩm ${_filters.length}");
    return _filters;
  }
}
