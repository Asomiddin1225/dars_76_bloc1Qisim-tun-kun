// import 'package:dars_74/cubit/covunter_cubit.dart';
// import 'package:dars_74/ui/screens/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         return CovunterCubit();
//       },
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: const HomePage(),
//       ),
//     );
//   }
// }




import 'package:dars_74/cubit/covunter_cubit.dart';
import 'package:dars_74/cubit/theme_cubit.dart';
import 'package:dars_74/ui/screens/home_page.dart';
import 'package:dars_74/ui/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CovunterCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDark) {
          return MaterialApp(
            theme: isDark ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
