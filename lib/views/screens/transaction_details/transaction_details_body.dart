import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/view_model/bill_view_model.dart';
import 'package:jars_mobile/view_model/note_view_model.dart';
import 'package:jars_mobile/view_model/transaction_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/widgets/loading.dart';

class TransactionDetailsBody extends StatefulWidget {
  const TransactionDetailsBody({Key? key, this.transactionId})
      : super(key: key);

  final int? transactionId;

  @override
  State<TransactionDetailsBody> createState() => _TransactionDetailsBodyState();
}

class _TransactionDetailsBodyState extends State<TransactionDetailsBody> {
  final transactionVM = TransactionViewModel();
  final walletVM = WalletViewModel();
  final noteVM = NoteViewModel();
  final billVM = BillViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  Transactions? transaction;

  Future<Map<String, dynamic>> getData() async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    Map<String, dynamic> data = <String, dynamic>{};

    var transaction = await transactionVM.getTransaction(
      idToken: idToken,
      transactionId: widget.transactionId!,
    );
    data.addAll({"transaction": transaction});

    var wallet = await walletVM.getAWallet(
      idToken: idToken,
      walletId: transaction.walletId!,
    );
    data.addAll({"wallet": wallet});

    if (transaction.noteId != null) {
      var note = await noteVM.getNote(
        idToken: idToken,
        noteId: transaction.noteId!,
      );
      data.addAll({"note": note});
    }

    if (transaction.billId != null) {
      var bill = await billVM.getBill(
        idToken: idToken,
        billId: transaction.billId!,
      );
      data.addAll({"bill": bill});
    }

    return data;
  }

  Future<Transactions> getTransactionData() async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    return transactionVM.getTransaction(
      idToken: idToken,
      transactionId: widget.transactionId!,
    );
  }

  Future<Wallet> getWalletData({required int walletId}) async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    return walletVM.getAWallet(
      idToken: idToken,
      walletId: walletId,
    );
  }

  Widget getTransactionDetailsUI() {
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
                                  .format(snapshot.data!["transaction"].amount)
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: SvgPicture.asset(
                                    Utilities.getJarImageByName(
                                      snapshot.data!["wallet"].name,
                                    ),
                                    height: 24,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Text(
                                    snapshot.data!["wallet"].name!.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat("dd/MM/yyyy HH:mm").format(
                                  DateTime.parse(snapshot.data!["transaction"]
                                          .transactionDate!)
                                      .toLocal(),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
                          child: Icon(Icons.note_rounded),
                        ),
                        Expanded(
                          child: Text(
                            snapshot.data!["note"]?.comments == null ||
                                    snapshot.data!["note"]?.comments.isEmpty
                                ? 'No comments written.'
                                : snapshot.data!["note"]?.comments,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(thickness: 1, height: 8),
                    snapshot.data!["note"] != null &&
                            snapshot.data!["note"].image != null
                        ? Column(
                            children: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                                    child: Icon(Icons.image_rounded),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.33,
                                child:
                                    Image.network(snapshot.data!["note"].image),
                              )
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          getTransactionDetailsUI(),
        ],
      ),
    );
  }

  String? getJarNameByJarId({required int jarID}) {
    for (Wallet element in walletVM.wallet.data!) {
      if (element.id == jarID) return element.name!;
    }
    return null;
  }
}
