import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';
import 'package:restaurant_app/provider/setting/reminder_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/screen/setting/setting_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

Future<void> main({bool isTest = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!isTest) {
    await NotificationHelper.init();
  }

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  final reminderProvider = ReminderProvider();

  if (!isTest) {
    await reminderProvider.loadReminder();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IndexNavProvider()),
        ChangeNotifierProvider(create: (_) => themeProvider),
        ChangeNotifierProvider(create: (_) => reminderProvider),

        Provider(create: (_) => ApiServices()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiServices>()),
        ),

        Provider(create: (_) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<LocalDatabaseService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
        NavigationRoute.settingRoute.name: (context) => const SettingScreen(),
      },
    );
  }
}
