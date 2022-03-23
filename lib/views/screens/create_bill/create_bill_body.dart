import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/bill_details.dart';
import 'package:jars_mobile/views/screens/create_bill_details/create_bill_details_screen.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';

class CreateBillBody extends StatefulWidget {
  const CreateBillBody({Key? key}) : super(key: key);

  @override
  State<CreateBillBody> createState() => _CreateBillBodyState();
}

class _CreateBillBodyState extends State<CreateBillBody> {
  DateTime date = DateTime.now();
  List billDetails = [];

  @override
  void initState() {
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
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Date",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Text(
                          DateFormat("EE dd, MM, yyyy").format(date),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AdaptiveButton(
                  text: "Add Bill Details",
                  enabled: true,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CreateBillDetailsScreen.routeName,
                      arguments: CreateBillDetailsScreenArguments(
                        onPressed: _addBillDetails,
                      ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
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
                                        });
                                      },
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: "Bill Details Name: ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: billDetails[index]
                                                    .itemName!,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: "Bill Details Price: ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: billDetails[index]
                                                    .price
                                                    .toString(),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: "Bill Details Quantity: ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: billDetails[index]
                                                    .quantity
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  void _addBillDetails(BillDetails billDetails) {
    setState(() => this.billDetails.add(billDetails));
  }
}
