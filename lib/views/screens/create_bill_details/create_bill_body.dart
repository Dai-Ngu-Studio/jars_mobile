import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jars_mobile/data/models/bill_details.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';

class CreateBillDetailsBody extends StatelessWidget {
  const CreateBillDetailsBody({Key? key, required this.onPressed}) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    final _quantityController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
          AdaptiveButton(
            text: "Save",
            enabled: true,
            onPressed: () {
              if (_nameController.text.trim() == "" || _priceController.text == "") {
                Fluttertoast.showToast(
                  msg: "Please fill in all fields",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                onPressed(
                  BillDetails(
                    itemName: _nameController.text,
                    price: int.parse(_priceController.text),
                    quantity: int.parse(_quantityController.text),
                  ),
                );
                Fluttertoast.showToast(
                  msg: "Bill details added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                _nameController.clear();
                _priceController.clear();
                _quantityController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
