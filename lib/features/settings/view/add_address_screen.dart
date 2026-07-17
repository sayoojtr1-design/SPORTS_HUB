import 'package:e_store/core/common/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/address_model.dart';
import '../view_model/address_view_model.dart';



class AddAddressScreen extends StatefulWidget {
  final AddressModel? address;

  const AddAddressScreen({
    super.key,
    this.address,
  });

  @override
  State<AddAddressScreen> createState() =>
      _AddAddressScreenState();
}

class _AddAddressScreenState
    extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();

    isEdit = widget.address != null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
      context.read<AddressViewModel>();

      if (isEdit) {
        provider.setAddress(widget.address!);
      } else {
        provider.clearControllers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    Provider.of<AddressViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? "Edit Address"
              : "Add Address",
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [

              CustomInputField(
                keyBoardType: TextInputType.text,
                controller:
                provider.nameController,
                label: "Full Name",
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter Full Name";
                  }
                  return null;
                },
              ),

              CustomInputField(
                controller:
                provider.phoneController,
                label: "Phone Number",
                keyBoardType:
                TextInputType.phone,
                validator: (value) {
                  if (value == null ||
                      value.length != 10) {
                    return "Enter Valid Phone Number";
                  }
                  return null;
                },
              ),

              CustomInputField(
                keyBoardType: TextInputType.text,
                controller:
                provider.houseController,
                label: "House / Flat No",
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter House Number";
                  }
                  return null;
                },
              ),

              CustomInputField(
                keyBoardType: TextInputType.text,
                controller:
                provider.areaController,
                label: "Area",
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter Area";
                  }
                  return null;
                },
              ),

              CustomInputField(
                keyBoardType: TextInputType.text,
                controller:
                provider.cityController,
                label: "City",
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter City";
                  }
                  return null;
                },
              ),

              CustomInputField(
                keyBoardType: TextInputType.text,
                controller:
                provider.stateController,
                label: "State",
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter State";
                  }
                  return null;
                },
              ),

              CustomInputField(
                controller:
                provider.pincodeController,
                label: "Pincode",
                keyBoardType:
                TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.length != 6) {
                    return "Enter Valid Pincode";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed:
                  provider.isLoading
                      ? null
                      : () async {
                    if (!_formKey
                        .currentState!
                        .validate()) {
                      return;
                    }

                    if (isEdit) {
                      await provider
                          .updateAddress(
                        widget
                            .address!.id!,
                      );
                    } else {
                      await provider
                          .addAddress();
                    }

                    if (!mounted) return;

                    Navigator.pop(
                        context);
                  },
                  child: provider.isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Text(
                    isEdit
                        ? "Update Address"
                        : "Save Address",
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}