import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../model/address_model.dart';



class AddressService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String get userId => auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get addressRef {
    return firestore
        .collection("users")
        .doc(userId)
        .collection("addresses");
  }

  /// Add Address
  Future<void> addAddress(AddressModel address) async {
    final document = addressRef.doc();

    address.id = document.id;

    await document.set(
      address.toJson(),
    );
  }

  /// Update Address
  Future<void> updateAddress(AddressModel address) async {
    await addressRef
        .doc(address.id)
        .update(
      address.toJson(),
    );
  }

  /// Delete Address
  Future<void> deleteAddress(String documentId) async {
    await addressRef
        .doc(documentId)
        .delete();
  }

  /// Get Addresses
  Stream<List<AddressModel>> getAddresses() {
    return addressRef
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => AddressModel.fromJson(
          doc.data(),
        ),
      )
          .toList(),
    );
  }
}