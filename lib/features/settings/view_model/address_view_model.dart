import 'package:flutter/material.dart';
import '../model/address_model.dart';
import '../services/address_service.dart';



class AddressViewModel extends ChangeNotifier {
  final AddressService addressService = AddressService();

  bool isLoading = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();

  /// -----------------------------
  /// ADD ADDRESS
  /// -----------------------------

  Future<void> addAddress() async {
    isLoading = true;
    notifyListeners();

    try {
      AddressModel address = AddressModel(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        house: houseController.text.trim(),
        area: areaController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        pincode: pincodeController.text.trim(),
      );

      await addressService.addAddress(address);

      clearControllers();
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  /// -----------------------------
  /// UPDATE ADDRESS
  /// -----------------------------

  Future<void> updateAddress(String addressId) async {
    isLoading = true;
    notifyListeners();

    try {
      AddressModel address = AddressModel(
        id: addressId,
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        house: houseController.text.trim(),
        area: areaController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        pincode: pincodeController.text.trim(),
      );

      await addressService.updateAddress(address);

      clearControllers();
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  /// -----------------------------
  /// DELETE ADDRESS
  /// -----------------------------

  Future<void> deleteAddress(String addressId) async {
    try {
      await addressService.deleteAddress(addressId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// -----------------------------
  /// GET ALL ADDRESSES
  /// -----------------------------

  Stream<List<AddressModel>> getAddresses() {
    return addressService.getAddresses();
  }

  /// -----------------------------
  /// SET ADDRESS FOR EDIT
  /// -----------------------------

  void setAddress(AddressModel address) {
    nameController.text = address.name ?? "";
    phoneController.text = address.phone ?? "";
    houseController.text = address.house ?? "";
    areaController.text = address.area ?? "";
    cityController.text = address.city ?? "";
    stateController.text = address.state ?? "";
    pincodeController.text = address.pincode ?? "";
  }

  /// -----------------------------
  /// CLEAR CONTROLLERS
  /// -----------------------------

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    houseController.clear();
    areaController.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    houseController.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();

    super.dispose();
  }
}