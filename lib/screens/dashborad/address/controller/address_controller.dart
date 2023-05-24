// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/model/address_list_response.dart';
import 'package:kisan_facility/screens/dashborad/address/repository/address_repository.dart';
import 'package:kisan_facility/screens/onboardiing/controller/onboarding_controller.dart';
import 'package:kisan_facility/utils/app_snackbar.dart';

final userAddressList = Provider<List<SingleAddress>>((ref) => []);

final addressControllerProvider =
    StateNotifierProvider<AddressController, bool>((ref) {
  return AddressController(
      ref: ref, addressRepository: ref.watch(addressRepository));
});

class AddressController extends StateNotifier<bool> {
  final Ref _ref;
  final AddressRepository _addressRepository;

  AddressController({
    required Ref ref,
    required AddressRepository addressRepository,
  })  : _ref = ref,
        _addressRepository = addressRepository,
        super(false);

  void getUserAddress(BuildContext context) async {
    state = true;
    final addresses = await _addressRepository.fetchUserAddressList();
    state = false;
    addresses.fold((l) => showSnackBar(context, l.message), (address) {
      _ref.watch(userAddressList).clear();
      _ref.read(userAddressList).addAll(address);
    });
  }

  void addNewAddress(
      BuildContext context,
      String name,
      String local,
      String country,
      String sttate,
      String city,
      String pinCode,
      String isDefault,
      {bool isEditable = false,
      String? id}) async {
    state = true;
    final address = await _addressRepository.addNewAddress(
        name, local, country, sttate, city, pinCode, isDefault,
        isEditable: isEditable, id: id);
    state = false;
    address.fold((l) => showSnackBar(context, l.message), (address) {
      if (isEditable == true) {
        getUserAddress(context);
      } else {
        _ref.read(userAddressList).add(address);
      }
      Navigator.pop(context);
    });
  }

  void deleteAddress(String id, BuildContext context) async {
    state = true;
    final address = await _addressRepository.deleteAddress(id);
    state = false;
    address.fold((l) => showSnackBar(context, l.message), (r) {
      getUserAddress(context);
    });
  }
}
