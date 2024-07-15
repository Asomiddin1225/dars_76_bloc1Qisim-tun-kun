import 'package:dars_74/models/admin_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// AdminCubit - mahsulotlarni boshqarish uchun Cubit
class AdminCubit extends Cubit<List<Product>> {
  // Boshlang'ich holat bo'sh mahsulotlar ro'yxati
  AdminCubit() : super([]);

  // Firestore dagi 'products' kolleksiyasiga murojaat
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  // Mahsulot qo'shish funksiyasi
  Future<void> addProduct(Product product) async {
    // Yangi mahsulotni Firestore ga qo'shish
    await products.add(product.toJson());
    // Mahsulotlarni yangilab olish
    fetchProducts();
  }

  // Mahsulotni tahrirlash funksiyasi
  Future<void> editProduct(String id, Product newProduct) async {
    // Berilgan ID bo'yicha mahsulotni yangilash
    await products.doc(id).update(newProduct.toJson());
    // Mahsulotlarni yangilab olish
    fetchProducts();
  }

  // Mahsulotni o'chirish funksiyasi
  Future<void> deleteProduct(String id) async {
    // Berilgan ID bo'yicha mahsulotni o'chirish
    await products.doc(id).delete();
    // Mahsulotlarni yangilab olish
    fetchProducts();
  }

  // Mahsulotlarni olish va holatni yangilash funksiyasi
  Future<void> fetchProducts() async {
    // 'products' kolleksiyasidan barcha hujjatlarni olish
    final querySnapshot = await products.get();
    // Hujjatlarni Product obyektlariga aylantirish
    final productsList = querySnapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    // Holatni yangi mahsulotlar ro'yxati bilan yangilash
    emit(productsList);
  }
}
