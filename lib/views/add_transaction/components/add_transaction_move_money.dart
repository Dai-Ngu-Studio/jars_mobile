import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';

class AddTransactionMoveMoney extends StatefulWidget {
  const AddTransactionMoveMoney({Key? key, required this.jars})
      : super(key: key);

  final List jars;

  @override
  State<AddTransactionMoveMoney> createState() =>
      _AddTransactionMoveMoneyState();
}

class _AddTransactionMoveMoneyState extends State<AddTransactionMoveMoney> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? jarNameFrom;
  String? jarNameTo;
  String? jarIdFrom;
  String? jarIdTo;

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'MOVE JAR',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => selectJars(moveOrReceive: false),
                          child: Row(
                            children: [
                              jarNameFrom == null
                                  ? Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      Utilities.getJarImageByName(jarNameFrom!),
                                      height: 40,
                                      width: 40,
                                    ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Please select MOVE JAR',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward, color: jarsColor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'RECEIVE JAR',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => selectJars(moveOrReceive: true),
                          child: Row(
                            children: [
                              jarNameTo == null
                                  ? Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      Utilities.getJarImageByName(jarNameTo!),
                                      height: 40,
                                      width: 40,
                                    ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Please select RECEIVE JAR',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(thickness: 1, height: 16),
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
                const Divider(thickness: 1, height: 16),
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

  /// move: false, receive: true
  void selectJars({required bool moveOrReceive}) {
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
                  itemCount: widget.jars.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        moveOrReceive
                            ? setState(() {
                                jarNameTo = widget.jars[index]['jarName'];
                                jarIdTo = widget.jars[index]['id'];
                              })
                            : setState(() {
                                jarNameFrom = widget.jars[index]['jarName'];
                                jarIdFrom = widget.jars[index]['id'];
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
                                    widget.jars[index]['jarName'],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  widget.jars[index]['jarName'],
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
                                    int.parse(
                                      widget.jars[index]['amount'],
                                    ),
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
