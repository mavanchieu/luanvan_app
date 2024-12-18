import 'dart:collection';
import 'package:app_lv/client/manager/Evaluation_manager.dart';
import 'package:app_lv/client/manager/brand_manager.dart';
import 'package:app_lv/client/manager/collection_manager.dart';
import 'package:app_lv/client/manager/favroite_manager.dart';
import 'package:app_lv/client/manager/gender_manager.dart';
import 'package:app_lv/client/manager/message_manager.dart';
import 'package:app_lv/client/manager/typeDetail_manager.dart';
import 'package:app_lv/client/manager/userDiscountCode.dart';
import 'package:app_lv/client/manager/viewedProduct_manager.dart';
import 'package:app_lv/client/models/message.dart';
import 'package:app_lv/client/services/login.service.dart';
import 'package:app_lv/client/services/signup.service.dart';
import 'package:app_lv/client/manager/search_manager.dart';
import 'package:app_lv/client/services/socket.io.dart';
import 'package:app_lv/client/ui/account/body/system/help/helpForm_screen.dart';
import 'package:app_lv/client/ui/account/body/system/help/help_manager.dart';
import 'package:app_lv/client/manager/user_manager.dart';
import 'package:app_lv/client/ui/bottomnavigation/bottomnavigation_screen.dart';
import 'package:app_lv/client/manager/discountCodes_manager.dart';
import 'package:app_lv/client/ui/login/login_screen.dart';
import 'package:app_lv/client/manager/product_manager.dart';

import 'package:app_lv/client/ui/signup/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

//import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loginService = LoginService();
  await loginService.initializeLoginState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LoginService(),
          ),
          ChangeNotifierProvider(
            create: (_) => SignupService(),
          ),
          ChangeNotifierProvider(
            create: (_) => ProductManager(),
          ),
          ChangeNotifierProvider(
            create: (_) => BrandManager(),
          ),
          ChangeNotifierProvider(
            create: (_) => TypeDetailManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => DiscountcodesManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => GenderManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => BrandManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => HelpManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoriteManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => ViewedProductManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => EvaluationManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => BottomNavigationModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => MessageManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => CollectionManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserDiscountCodeManager(),
          ),
        ],
        child: const AppWrapper(),
      ),
    );
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final SocketService socketService = SocketService();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    socketService.connect();
    initializeNotifications();
    setupSocketListener();
  }

  // Khởi tạo thông báo
  Future<void> initializeNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  // Function to handle when a notification is tapped
  Future<void> onSelectNotification(NotificationResponse response) async {
    String? payload = response.payload;
    if (payload != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Notification Tapped'),
            content: Text('Payload: $payload'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      print('No payload received');
    }
  }

  // Function to show a notification
  Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'Order Confirmed!',
    );
  }

  // lắng nghe socket
  void setupSocketListener() {
    socketService.on('confirmOrder', (data) async {
      String currentUserId = context.read<LoginService>().userId;

      if (data['userId'] == currentUserId) {
        if (mounted) {
          print('confirmOrder: $data');

          await showNotification(
              'ĐƠN HÀNG', 'Đơn hàng của bạn đã được xác nhận thành công');
        }
      }
    });

    socketService.on('confirmShipping', (data) async {
      if (mounted) {
        print('confirmShipping: $data');
        await showNotification('ĐƠN HÀNG', 'Đơn hàng đã vận chuyển thành công');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginService>(
      builder: (context, loginModel, child) {
        if (loginModel.isLogin) {
          return const BottomNavigation();
          // return HelpFormScreen();
        } else {
          //return const BottomNavigation();
          //return const IntroScreen();
          return const LoginScreen();
          //  return const SignupScreen();
          //return HomeScreen();
        }
      },
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _videoController;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // Initialize the video controller with your video file
    _videoController = VideoPlayerController.asset('assets/video/intro2.mp4')
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Stack(
                children: [
                  // Background video
                  _videoController.value.isInitialized
                      ? SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),

                  // Overlay content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 300, 30, 0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Đăng nhập',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              SizedBox(
                                width: 140,
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Đăng ký',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
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
            );
          },
        );
      },
    );
  }
}
