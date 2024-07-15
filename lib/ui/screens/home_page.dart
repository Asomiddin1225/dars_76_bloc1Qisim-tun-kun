import 'package:dars_74/cubit/admin_cubit.dart';
import 'package:dars_74/cubit/cart_cubit.dart';
import 'package:dars_74/models/admin_model.dart';
import 'package:dars_74/models/cart_model.dart';
import 'package:dars_74/ui/screens/cart_screen.dart';
import 'package:dars_74/ui/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().fetchProducts();
  }

  int son = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Do'kon"),
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
                children: [Text('ADMIN'), Spacer(), Icon(Icons.post_add_sharp)],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreens()),
                );
              },
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
          ],
        ),
      ),
      body: BlocBuilder<AdminCubit, List<Product>>(
        builder: (context, products) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: Column(
                  children: [
                    Image.network(product.imageUrl, height: 100, width: 100),
                    Text(product.name),
                    Text('${product.price} UZS'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            context.read<CartCubit>().addItem(CartItem(
                                  id: product.id,
                                  name: product.name,
                                  price: product.price,
                                ));
                            son++;
                          },
                        ),
                        Text("${son}"),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            context.read<CartCubit>().removeItem(product.id);
                            son--;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
      ),
    );
  }
}
