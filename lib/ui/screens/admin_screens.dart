import 'package:dars_74/cubit/admin_cubit.dart';
import 'package:dars_74/models/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AdminScreens extends StatefulWidget {
  const AdminScreens({Key? key}) : super(key: key);

  @override
  _AdminScreensState createState() => _AdminScreensState();
}

class _AdminScreensState extends State<AdminScreens> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: BlocBuilder<AdminCubit, List<Product>>(
        builder: (context, products) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.price.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _nameController.text = product.name;
                              _priceController.text = product.price.toString();
                              _imageUrl = product.imageUrl;
                              _showFormDialog(
                                context: context,
                                onSave: () {
                                  context.read<AdminCubit>().editProduct(
                                      product.id,
                                      Product(
                                        id: product.id,
                                        name: _nameController.text,
                                        price:
                                            double.parse(_priceController.text),
                                        imageUrl: _imageUrl,
                                      ));
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<AdminCubit>()
                                  .deleteProduct(product.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _showFormDialog(
                    context: context,
                    onSave: () {
                      context.read<AdminCubit>().addProduct(Product(
                            id: DateTime.now().toString(),
                            name: _nameController.text,
                            price: double.parse(_priceController.text),
                            imageUrl: _imageUrl,
                          ));
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFormDialog(
      {required BuildContext context, required VoidCallback onSave}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Maxsulod Qo'shish"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nomi'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Maxsulod nomini yozing";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: "Narxi"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Maxsulod narxini yozing";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final pickedImage = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      setState(() {
                        _imageUrl = pickedImage.path;
                      });
                    }
                  },
                  child: Text("Rasm Qo'shish uchun"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onSave();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Saqlash'),
            ),
          ],
        );
      },
    );
  }
}
