import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tolo/model/cart.dart';

class CartRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> getCarts() async {
    // not stream
    try {
      final carts = await _firestore.collection('carts').get();
      for (var cart in carts.docs) {
        Cart _cart = Cart.fromMap(cart.data()).copyWith(id: cart.id);
        // print("alo ${_cart.toMap()}");
      }
    } catch (e) {
      throw e;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshots() {
    // stream
    return _firestore.collection("carts").orderBy("title").snapshots();
  }

  Future<void> streamCarts() async {
    print("---------------------------------------------");
    try {
      await for (var snapshot in _firestore.collection('carts').snapshots()) {
        for (var cart in snapshot.docs) {
          print(cart.data());
        }
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> addCart({required Cart cart}) async {
    try {
      await _firestore.collection('carts').add(cart.toMap());
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteCart({required Cart cart}) async {
    try {
      await _firestore.collection('carts').doc(cart.id).delete();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateCart({required Cart cart}) async {
    try {
      await _firestore.collection('carts').doc(cart.id).update(cart.toMap());
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> recoverCart({required Cart cart}) async {
    try {
      print(cart.toMap());
      await _firestore.collection('carts').add(cart.toMap());
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
