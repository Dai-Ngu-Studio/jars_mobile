import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/bill.dart';
import 'package:jars_mobile/data/models/bill_details.dart';
import 'package:jars_mobile/view_model/bill_view_model.dart';
import 'package:jars_mobile/views/screens/create_bill_details/create_bill_details_screen.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';

class CreateBillBody extends StatefulWidget {
  const CreateBillBody({Key? key}) : super(key: key);

  @override
  State<CreateBillBody> createState() => _CreateBillBodyState();
}

class _CreateBillBodyState extends State<CreateBillBody> {
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  final _billVM = BillViewModel();
  final _firebaseAuth = FirebaseAuth.instance;
  DateTime date = DateTime.now();
  List billDetails = [];

  @override
  void initState() {
    _amountController.text = 0.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Row(
                    children: [
                      const Text("Date", style: TextStyle(fontSize: 16, color: Colors.black54)),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Text(
                          DateFormat("EE dd, MM, yyyy").format(date),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        enabled: false,
                        controller: _amountController,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("đ"),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AdaptiveButton(
                  text: "Add Bill Details",
                  enabled: true,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CreateBillDetailsScreen.routeName,
                      arguments: CreateBillDetailsScreenArguments(onPressed: _addBillDetails),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: billDetails.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          billDetails.removeAt(index);

                                          final int amount =
                                              billDetails.fold(0, (previousValue, element) {
                                            return previousValue +
                                                (element as BillDetails).quantity! *
                                                    element.price!.toInt();
                                          });
                                          _amountController.text = amount.toString();
                                        });
                                      },
                                    ),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                text: billDetails[index].itemName!,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${billDetails[index].quantity.toString()}x ' +
                                                        NumberFormat.currency(
                                                          locale: 'vi_VN',
                                                          decimalDigits: 0,
                                                          symbol: 'đ',
                                                        )
                                                            .format(billDetails[index].price)
                                                            .toString(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: billDetails.length,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
          AdaptiveButton(
            text: "Save",
            enabled: true,
            onPressed: () async {
              await createBill();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<Bill> createBill() async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    return await _billVM.createBill(
      idToken: idToken,
      date: date.toIso8601String(),
      name: _nameController.text,
      billDetails: billDetails,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() => date = picked);
    }
  }

  void _addBillDetails(BillDetails billDetails) {
    billDetails.id = 0;
    billDetails.billId = 0;
    setState(() {
      this.billDetails.add(billDetails);
      final int amount = this.billDetails.fold(0, (previousValue, element) {
        return previousValue + (element as BillDetails).quantity! * element.price!.toInt();
      });
      _amountController.text = amount.toString();
    });
  }
}
