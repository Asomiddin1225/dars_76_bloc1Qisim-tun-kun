import 'package:dars_74/cubit/cart_cubit.dart';
import 'package:dars_74/models/cart_model.dart';
import 'package:dars_74/ui/widgets/order_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Savatcha'),
      ),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cartItems) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return ListTile(
                      title: Text(cartItem.name),
                      subtitle:
                          Text('${cartItem.price} UZS x ${cartItem.quantity}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<CartCubit>().removeItem(cartItem.id);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    final totalPrice = context.read<CartCubit>().totalPrice;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return OrderConfirmationDialog(totalPrice: totalPrice);
                      },
                    );
                  },
                  child: Text('Buyurtma berish'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
