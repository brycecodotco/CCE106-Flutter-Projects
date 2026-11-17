import 'package:cloud_firestore/cloud_firestore.dart';

class CrudService {
  final CollectionReference items = FirebaseFirestore.instance.collection('items');

  Future <void> addItem(String name, int quantity) {

    //Create
    return items.add({
      'name': name,
      'quantity': quantity,
      'favorite': false,
      'created_at': Timestamp.now()
    });

  }

  //Read
  Stream<QuerySnapshot> getItems() {
    return items.orderBy('created_at', descending: true).snapshots();
  }

  //Update
  Future <void> updateItem(String id, String name, int quantity){
    return items.doc(id).update({
      'name': name,
      'quantity': quantity,
    });
  }

  //Delete
  Future<void> deleteItem(String id) {
    return items.doc(id).delete();
  }

//Favorite
Future<void> updateFavorite(String id, bool favorite) async {
  await FirebaseFirestore.instance
      .collection('items')
      .doc(id)
      .update({
    'favorite': favorite,
  });
}

}
