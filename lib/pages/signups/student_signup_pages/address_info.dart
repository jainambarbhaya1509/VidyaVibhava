import 'package:flutter/material.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressInformationSection extends ConsumerStatefulWidget {
  const AddressInformationSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddressInformationSectionState();
}

class _AddressInformationSectionState
    extends ConsumerState<AddressInformationSection> {
  @override
  Widget build(BuildContext context) {
    return buildAddressInformationSection(context);
  }
}

TextEditingController addressController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController zipCodeController = TextEditingController();
TextEditingController countryController = TextEditingController();

final addressInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'address': addressController.text,
    'zipCode': zipCodeController.text,
    'city': cityController.text,
    'state': stateController.text,
  };
});

Widget buildAddressInformationSection(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      return Container(
        margin: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppText(
              text: "Address Information",
              size: 20,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                ref.read(addressInfoProvider)['address'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: zipCodeController,
              decoration: InputDecoration(
                labelText: "Zip Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                ref.read(addressInfoProvider)['zipCode'] = value;
              },
              inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly
                  ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                ref.read(addressInfoProvider)['city'] = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: stateController,
              decoration: InputDecoration(
                labelText: "State",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                ref.read(addressInfoProvider)['state'] = value;
              },
            ),
          ],
        ),
      );
    },
  );
}
