import 'package:flutter/material.dart';

class OrderConfirmationDialog extends StatelessWidget {
  final double totalPrice;

  const OrderConfirmationDialog({Key? key, required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.check_circle, size: 100, color: Colors.orange),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Buyurtma berildi.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Umumiy narx: $totalPrice UZS',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
