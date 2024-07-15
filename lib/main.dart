import 'package:dars_74/cubit/admin_cubit.dart';
import 'package:dars_74/cubit/cart_cubit.dart';
import 'package:dars_74/cubit/theme_cubit.dart';
import 'package:dars_74/ui/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AdminCubit()..fetchProducts()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDark) {
        return MaterialApp(
          theme: isDark ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );
  }
}
