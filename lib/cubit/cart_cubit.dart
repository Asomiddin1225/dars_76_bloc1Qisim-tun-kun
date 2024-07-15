import 'package:dars_74/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// CartCubit - savatchani boshqarish uchun Cubit
class CartCubit extends Cubit<List<CartItem>> {
  // Boshlang'ich holat bo'sh savatcha ro'yxati
  CartCubit() : super([]);

  // Savatchaga mahsulot qo'shish funksiyasi
  void addItem(CartItem item) {
    // Savatchada mavjud mahsulotni topish
    final existingItem = state.firstWhere(
      (cartItem) => cartItem.id == item.id,
      orElse: () => CartItem(id: '', name: '', price: 0),
    );

    // Agar mahsulot mavjud bo'lmasa, uni qo'shish
    if (existingItem.id.isEmpty) {
      emit([...state, item]);
    } else {
      // Agar mahsulot mavjud bo'lsa, uning miqdorini oshirish
      existingItem.quantity++;
      emit(List.from(state));
    }
  }

  // Savatchadan mahsulotni olib tashlash funksiyasi
  void removeItem(String id) {
    // Savatchada mavjud mahsulotni topish
    final existingItem = state.firstWhere(
      (cartItem) => cartItem.id == id,
      orElse: () => CartItem(id: '', name: '', price: 0),
    );

    // Agar mahsulot mavjud bo'lsa
    if (existingItem.id.isNotEmpty) {
      // Agar mahsulot miqdori 1 dan ko'p bo'lsa, uni kamaytirish
      if (existingItem.quantity > 1) {
        existingItem.quantity--;
      } else {
        // Aks holda, mahsulotni savatchadan olib tashlash
        state.removeWhere((cartItem) => cartItem.id == id);
      }
      emit(List.from(state));
    }
  }

  // Savatchani tozalash funksiyasi
  void clearCart() {
    emit([]);
  }

  // Savatchaning umumiy narxini hisoblash funksiyasi
  double get totalPrice => state.fold(
    0,
    (sum, item) => sum + (item.price * item.quantity),
  );
}
