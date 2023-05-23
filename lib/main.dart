import 'package:flutter/material.dart';
import 'package:flutter_shopping_apps/common/widgets/bottom_bar.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/features/admin/screen/admin_screen.dart';
import 'package:flutter_shopping_apps/features/auth/screens/auth_screen.dart';
import 'package:flutter_shopping_apps/features/auth/services/auth_services.dart';
import 'package:flutter_shopping_apps/provider/user_provider.dart';
import 'package:flutter_shopping_apps/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static final messangerKey = GlobalKey<ScaffoldMessengerState>();
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final messengerKey = GlobalKey<ScaffoldMessengerState>();
  final AuthService authService = AuthService();

  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    authService.getuserdata(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}

