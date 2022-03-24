import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/bill.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/view_model/bill_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/bill_details/bill_details_screen.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';
import 'package:jars_mobile/views/widgets/error_snackbar.dart';
import 'package:jars_mobile/views/widgets/loading.dart';

class UpdateBillBody extends StatefulWidget {
  const UpdateBillBody({
    Key? key,
    required this.billId,
  }) : super(key: key);

  final int billId;

  @override
  State<UpdateBillBody> createState() => _UpdateBillBodyState();
}

class _UpdateBillBodyState extends State<UpdateBillBody> {
  final _billVM = BillViewModel();
  final _walletVM = WalletViewModel();
  final _firebaseAuth = FirebaseAuth.instance;
  final _amountController = TextEditingController();

  Bill? _bill;
  List? wallets;
  String? walletName;
  int? walletId;
  num? walletAmount;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser!.getIdToken().then((idToken) async {
      var wallets = await _walletVM.getWallets(
        idToken: idToken,
      );
      var bill = await _billVM.getBill(
        idToken: idToken,
        billId: widget.billId,
      );
      setState(() {
        this.wallets = wallets;
        walletName = (this.wallets!.first as Wallet).name;
        walletId = (this.wallets!.first as Wallet).id;
        walletAmount = (this.wallets!.first as Wallet).walletAmount;
        _bill = bill;
      });
    });
    super.initState();
  }

  Future<Map<String, dynamic>> getData() async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    Map<String, dynamic> data = <String, dynamic>{};

    var bill = await _billVM.getBill(
      idToken: idToken,
      billId: widget.billId,
    );
    data.addAll({"bill": bill});

    return data;
  }

  Widget getUpdateBillUI() {
    return FutureBuilder(
      future: getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<Map<String, dynamic>> snapshot,
      ) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong! Please try again later."),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return LoadingWidget();
          case ConnectionState.done:
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
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'vi_VN',
                                    decimalDigits: 0,
                                    symbol: '',
                                  )
                                      .format(snapshot.data!["bill"].amount)
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'vi_VN',
                                    decimalDigits: 0,
                                    symbol: '',
                                  )
                                      .format(snapshot.data!["bill"].leftAmount)
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
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
                              child: Icon(Icons.calendar_month_rounded),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      DateFormat("dd/MM/yyyy HH:mm").format(
                                        DateTime.parse(
                                          snapshot.data!["bill"].date,
                                        ).toLocal(),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1, height: 8),
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
                                        walletName ?? "Necessities",
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
                        const Divider(thickness: 1, height: 8),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    AdaptiveButton(
                      text: "View Bill Details",
                      enabled: true,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          BillDetailsScreen.routeName,
                          arguments: BillDetailsScreenArguments(
                            billId: widget.billId,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    AdaptiveButton(
                      text: "Save",
                      enabled: true,
                      onPressed: () => updateBill(
                        bill: snapshot.data!["bill"],
                      ),
                    )
                  ],
                ),
              ),
            );
        }
      },
    );
  }

  Future updateBill({Bill? bill}) async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    int? payingAmount = int.tryParse(_amountController.text);
    if (payingAmount == null) {
      showErrorSnackbar(
          context: context, message: "Paying amount should be numberic.");
      return;
    }
    num? leftAmount = bill!.leftAmount!.toInt() - payingAmount;
    if (payingAmount > walletAmount!.toInt()) {
      showErrorSnackbar(
          context: context, message: 'Insufficient money in wallet.');
      return;
    }
    if (leftAmount < 0) {
      leftAmount = 0;
      var actualPayingAmount = NumberFormat.currency(
        locale: 'vi_VN',
        symbol: 'đ',
      ).format(
        bill.leftAmount!,
      );
      showErrorSnackbar(
          context: context, message: 'Paying $actualPayingAmount instead.');
    }
    await _billVM.updateBill(
      idToken: idToken,
      billId: widget.billId,
      walletId: walletId!,
      name: null,
      date: null,
      leftAmount: leftAmount,
    );
    Navigator.of(context).pop();
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
                "Select a jar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: wallets!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          walletName = (wallets![index] as Wallet).name;
                          walletId = (wallets![index] as Wallet).id;
                          walletAmount =
                              (wallets![index] as Wallet).walletAmount;
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
                                      (wallets![index] as Wallet).name!),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  (wallets![index] as Wallet).name!,
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
                                    (wallets![index] as Wallet).walletAmount!,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          getUpdateBillUI(),
        ],
      ),
    );
  }
}
