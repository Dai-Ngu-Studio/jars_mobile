import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/data/models/bill_details.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/view_model/bill_details_view_model.dart';
import 'package:jars_mobile/views/screens/bill_details/components/bill_details_box.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class BillDetailsBody extends StatefulWidget {
  const BillDetailsBody({Key? key, required this.billId}) : super(key: key);

  final int billId;

  @override
  State<BillDetailsBody> createState() => _BillDetailsBodyState();
}

class _BillDetailsBodyState extends State<BillDetailsBody> {
  final _billDetailsVM = BillDetailsViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  List<BillDetails> billDetails = [];

  Future<bool> getData() async {
    _firebaseAuth.currentUser!.getIdToken().then((idToken) {
      _billDetailsVM.getBillDetails(idToken: idToken, billId: widget.billId).whenComplete(
        () {
          if (_billDetailsVM.billDetails.data == null) {
            return;
          }
          for (var billDetail in _billDetailsVM.billDetails.data!) {
            var _billDetail = BillDetails(
              id: (billDetail as BillDetails).id,
              billId: billDetail.billId,
              itemName: billDetail.itemName,
              price: billDetail.price,
              quantity: billDetail.quantity,
            );
            billDetails.add(_billDetail);
          }
        },
      );
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Widget getBillDetailsViewUI() {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong! Please try again later."),
          );
        } else {
          return ChangeNotifierProvider<BillDetailsViewModel>(
            create: (BuildContext context) => _billDetailsVM,
            child: Consumer<BillDetailsViewModel>(
              builder: (context, viewModel, _) {
                switch (viewModel.billDetails.status) {
                  case Status.LOADING:
                    return const LoadingWidget();
                  case Status.ERROR:
                    return ErrorWidget(
                      viewModel.billDetails.message ??
                          "Something went wrong! Please try again later.",
                    );
                  case Status.COMPLETED:
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.2,
                      ),
                      itemCount: billDetails.length,
                      itemBuilder: (context, index) {
                        return BillDetailsBox(
                          name: billDetails[index].itemName!,
                          quantity: billDetails[index].quantity!,
                          price: billDetails[index].price!,
                        );
                      },
                    );
                  default:
                }
                return const SizedBox.shrink();
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: getBillDetailsViewUI(),
        ),
      ],
    );
  }
}
