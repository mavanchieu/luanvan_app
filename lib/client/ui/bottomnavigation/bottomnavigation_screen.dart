import 'package:app_lv/client/services/login.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:app_lv/client/ui/account/account_screen.dart';
import 'package:app_lv/client/ui/cart/cart_screen.dart';
import 'package:app_lv/client/ui/favorite/favorite_screen.dart';
import 'package:app_lv/client/ui/homepage/homepage_screen.dart';
import 'package:app_lv/client/ui/shop/shop_screen.dart';

class BottomNavigationModel with ChangeNotifier {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  final List<ScrollController> _scrollControllers =
      List.generate(5, (_) => ScrollController());

  DateTime? _lastTapTime;

  // bool isLogin = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loginService = Provider.of<LoginService>(context, listen: false);
      loginService.onLogout = () {
        Provider.of<BottomNavigationModel>(context, listen: false)
            .setSelectedIndex(0);
      };
    });
  }

  @override
  void dispose() {
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context);
    int currentIndex = bottomNavigationModel.selectedIndex;

    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [
            _buildNavigator(context, 0,
                HomePageScreen(scrollController: _scrollControllers[0])),
            _buildNavigator(context, 1,
                ShopScreen(scrollController: _scrollControllers[1])),
            _buildNavigator(context, 2,
                FavoriteScreen(scrollController: _scrollControllers[2])),
            _buildNavigator(context, 3,
                CartScreen(scrollController: _scrollControllers[3])),
            _buildNavigator(context, 4,
                AccountScreen(scrollController: _scrollControllers[4])),
          ],
        ),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 234, 232, 232),
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == currentIndex) {
                  DateTime now = DateTime.now();
                  // if (_lastTapTime != null &&
                  //     now.difference(_lastTapTime!) <
                  //         const Duration(milliseconds: 300)) {
                  _scrollControllers[index].animateTo(
                    _scrollControllers[index].position.minScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                  // }
                } else {
                  bottomNavigationModel.setSelectedIndex(index);
                }
                // _lastTapTime = DateTime.now();
              },
              backgroundColor: Colors.white,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 28,
                  ),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.manage_search_outlined,
                    size: 28,
                  ),
                  label: 'Cửa hàng',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Colors.pink,
                    size: 28,
                  ),
                  label: 'Yêu thích',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    size: 28,
                  ),
                  label: 'Giỏ hàng',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                    size: 28,
                  ),
                  label: 'Cá nhân',
                ),
              ],
              selectedItemColor: Colors.black,
              unselectedItemColor: const Color.fromARGB(255, 162, 162, 162),
            )));
  }

  Widget _buildNavigator(BuildContext context, int index, Widget screen) {
    return Navigator(
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => screen,
        );
      },
    );
  }
}
