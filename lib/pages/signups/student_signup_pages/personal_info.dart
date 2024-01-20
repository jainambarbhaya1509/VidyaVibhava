import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_project/widgets/app_text.dart';
import 'package:intl/intl.dart';

DateTime selectedDate = DateTime.now();
TextEditingController dateController = TextEditingController(); // Move it here

Widget buildPersonalInformationSection(BuildContext context) {
  // ignore: no_leading_underscores_for_local_identifiers
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    }
  }

  return Container(
    margin: const EdgeInsets.only(left: 30, top: 30, right: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralAppText(
          text: "Personal Information",
          size: 20,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'First Name',
                    ),
                  ),
                ),
                Container(
                  width: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Last Name',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Date of Birth',
                    ),
                    controller: dateController,
                  ),
                ),
                Container(
                  width: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Blood Group',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Enter your phone number',
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    '+91 |',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Enter your full address',
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
