import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/view_model/cloud_view_model.dart';
import 'package:jars_mobile/view_model/transaction_view_model.dart';
import 'package:jars_mobile/views/screens/app/app.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';
import 'package:jars_mobile/views/widgets/error_snackbar.dart';
import 'package:mime/mime.dart';

class AddTransactionExpense extends StatefulWidget {
  const AddTransactionExpense({Key? key, required this.wallets})
      : super(key: key);

  final List wallets;

  @override
  State<AddTransactionExpense> createState() => _AddTransactionExpenseState();
}

class _AddTransactionExpenseState extends State<AddTransactionExpense> {
  DateTime selectedDate = DateTime.now();
  String? walletName;
  int? walletId;
  File? _image;
  String? _base64Image;

  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _cloudVM = CloudViewModel();
  final _transactionVM = TransactionViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    walletName = (widget.wallets.first as Wallet).name;
    walletId = (widget.wallets.first as Wallet).id;
    super.initState();
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: InkWell(
                    onTap: selectWallets,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Assets.svgs.jar.svg(
                                color: Colors.black,
                                width: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Text(
                                walletName!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 18),
                      ],
                    ),
                  ),
                ),
                // const Divider(thickness: 1, height: 8),
                // Row(
                //   children: [
                //     const Padding(
                //       padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                //       child: Icon(Icons.edit_calendar_rounded),
                //     ),
                //     Expanded(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           InkWell(
                //             onTap: () {},
                //             child: Text(
                //               DateFormat("EE dd, MMMM, yyyy")
                //                   .format(selectedDate),
                //               style: const TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //           ),
                //           Material(
                //             color: Colors.transparent,
                //             child: InkWell(
                //               child: DropdownButton(
                //                 value: dropdownValue,
                //                 elevation: 4,
                //                 onChanged: (String? newValue) {
                //                   setState(() => dropdownValue = newValue!);
                //                 },
                //                 items: [
                //                   'None-recurring',
                //                   'Daily',
                //                   'Weekly',
                //                   'Monthly',
                //                 ].map<DropdownMenuItem<String>>((value) {
                //                   return DropdownMenuItem(
                //                     value: value,
                //                     child: Text(value),
                //                   );
                //                 }).toList(),
                //               ),
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
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
                        keyboardType: TextInputType.text,
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
                            height: MediaQuery.of(context).size.height * 0.33,
                            child: Image.file(_image!),
                          ),
                  ],
                ),
              ],
            ),
            AdaptiveButton(
              text: "Save",
              enabled: true,
              onPressed: () async {
                if (await addExpense()) {
                  Navigator.of(context).popAndPushNamed(JarsApp.routeName);
                } else {
                  showErrorSnackbar(
                    context: context,
                    message: "Something went wrong! Please try again.",
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<bool> addExpense() async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    String? imageUrl;
    String? comment = _descriptionController.text;
    int? amount = int.tryParse(_amountController.text);
    if (amount == null) {
      showErrorSnackbar(
          context: context, message: "Amount should be numberic.");
      return false;
    }
    amount = -amount;

    if (_base64Image != null) {
      imageUrl = await uploadImage(base64: _base64Image!);
    }

    if (comment.isEmpty) {
      comment = null;
    }

    return await _transactionVM.addExpense(
      idToken: idToken,
      amount: amount,
      walletId: walletId!,
      noteComment: comment,
      noteImage: imageUrl,
    );
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  Future<String> uploadImage({required String base64}) async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    return await _cloudVM.uploadImage(idToken: idToken, base64: base64);
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
        _base64Image =
            "data:image/${lookupMimeType(result.path)!.split("/")[1]};base64,${base64Encode(bytes)}";
      });
    }
  }

  void selectWallets() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 380,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select jar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.wallets.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          walletName = widget.wallets[index].name;
                          walletId = widget.wallets[index].id;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  Utilities.getJarImageByName(
                                      widget.wallets[index].name),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  widget.wallets[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'BALANCE',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  NumberFormat.currency(
                                    locale: 'vi_VN',
                                    symbol: 'đ',
                                  ).format(
                                    widget.wallets[index].walletAmount,
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
