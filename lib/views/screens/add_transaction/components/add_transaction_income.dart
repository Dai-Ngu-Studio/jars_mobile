import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';
import 'package:mime/mime.dart';

class AddTransactionIncome extends StatefulWidget {
  const AddTransactionIncome({Key? key}) : super(key: key);

  @override
  State<AddTransactionIncome> createState() => _AddTransactionIncomeState();
}

class _AddTransactionIncomeState extends State<AddTransactionIncome> {
  DateTime selectedDate = DateTime.now();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String dropdownValue = 'None-recurring';

  File? _image;
  String? _fileName;
  String? _base64Image;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("đ"),
                    )
                  ],
                ),
                const Divider(thickness: 1, height: 8),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                      child: Icon(Icons.edit_calendar_rounded),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: Text(
                              DateFormat("EE dd, MMMM, yyyy")
                                  .format(selectedDate),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: DropdownButton(
                                value: dropdownValue,
                                elevation: 4,
                                onChanged: (String? newValue) {
                                  setState(() => dropdownValue = newValue!);
                                },
                                items: [
                                  'None-recurring',
                                  'Daily',
                                  'Weekly',
                                  'Monthly',
                                ].map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1, height: 8),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                      child: Icon(Icons.edit_note_rounded),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _descriptionController,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Note",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(thickness: 1, height: 8),
                Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                          child: Icon(Icons.image_rounded),
                        ),
                        InkWell(
                          onTap: _handleImageSelection,
                          child: const Text("Click here to select note image"),
                        ),
                      ],
                    ),
                    _image == null
                        ? const SizedBox.shrink()
                        : SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Image.file(_image!),
                          ),
                  ],
                ),
              ],
            ),
            AdaptiveButton(
              text: "Save",
              enabled: true,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = File(result.path).readAsBytesSync();
      _base64Image =
          "data:image/${lookupMimeType(result.path)!.split("/")[1]};base64,${base64Encode(bytes)}";

      log("img : $_base64Image");

      setState(() {
        _image = File(result.path);
        _fileName = result.name;
        _base64Image =
            "data:image/${lookupMimeType(result.path)!.split("/")[1]};base64,${base64Encode(bytes)}";
      });
    }
  }
}
