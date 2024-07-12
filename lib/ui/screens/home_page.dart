// import 'package:dars_74/cubit/covunter_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final covunterCubit =context.read<CovunterCubit>();
//     return Scaffold(
//       appBar: AppBar(
// leading: IconButton(onPressed: () {

// }, icon: Icon(Icons.menu_open)),

//         actions: [
//           IconButton(onPressed: () {
//             covunterCubit.increment();
//           }, icon: Icon(Icons.add)),
//           IconButton(onPressed: () {
//             covunterCubit.decrment();
//           }, icon: Icon(Icons.remove_outlined)),
//         ],
//       ),
//       body: BlocBuilder<CovunterCubit,int>(

//         builder: (context, state) {
//           return Center(
//             child: Text(
//               state.toString(),
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           );
//         }
//       ),
//     );
//   }
// }

import 'package:dars_74/cubit/covunter_cubit.dart';
import 'package:dars_74/ui/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final covunterCubit = context.read<CovunterCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              covunterCubit.increment();
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              covunterCubit.decrment();
            },
            icon: Icon(Icons.remove_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Row(
                children: [Text('Settings'), Spacer(), Icon(Icons.settings)],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),


             ListTile(
              title: Row(
                children: [Text('Test'), Spacer(), Icon(Icons.abc)],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyWidget()),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<CovunterCubit, int>(
        builder: (context, state) {
          return Center(
            child: Text(
              state.toString(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
