import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/data/models/bill.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/view_model/bill_view_model.dart';
import 'package:jars_mobile/views/screens/bill/components/bill_box.dart';
import 'package:jars_mobile/views/widgets/show_snackbar.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class BillBody extends StatefulWidget {
  const BillBody({Key? key}) : super(key: key);

  @override
  State<BillBody> createState() => _BillBodyState();
}

class _BillBodyState extends State<BillBody> {
  final _billVM = BillViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  final _scrollController = ScrollController();

  int currPage = 0;
  bool canLoadMore = true;

  List<Bill> bills = [];

  @override
  void initState() {
    super.initState();
    currPage = 0;

    _scrollController.addListener(
      () async {
        if (_scrollController.position.atEdge) {
          bool isAtTopOfList = _scrollController.position.pixels == 0;
          if (!isAtTopOfList) {
            if (canLoadMore) {
              currPage++;
              await getData();
              showSnackbar(context: context, message: "Loading more...", duration: 500);
            }
          }
        }
      },
    );
  }

  Future<bool> getData() async {
    _firebaseAuth.currentUser!.getIdToken().then((idToken) {
      _billVM.getBills(idToken: idToken, page: currPage).whenComplete(() {
        if (_billVM.bills.data == null) {
          return;
        }
        for (var bill in _billVM.bills.data!) {
          var _bill = Bill(
            id: (bill as Bill).id,
            name: bill.name,
            date: bill.date,
            leftAmount: bill.leftAmount,
            amount: bill.amount,
          );
          bills.add(_bill);
        }
        if (_billVM.bills.data!.length < 8) {
          canLoadMore = false;
        }
      });
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Widget getBillsViewUI() {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong! Please try again later."));
        } else {
          return ChangeNotifierProvider<BillViewModel>(
            create: (BuildContext context) => _billVM,
            child: Consumer<BillViewModel>(
              builder: (context, viewModel, _) {
                switch (viewModel.bills.status) {
                  case Status.LOADING:
                    return const LoadingWidget();
                  case Status.ERROR:
                    return ErrorWidget(
                      viewModel.bills.message ?? "Something went wrong! Please try again later.",
                    );
                  case Status.COMPLETED:
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: bills.length,
                      itemBuilder: (context, index) {
                        return BillBox(
                          billId: bills[index].id!,
                          name: bills[index].name!,
                          date: bills[index].date!,
                          leftAmount: bills[index].leftAmount!,
                          amount: bills[index].amount!,
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
    return SafeArea(
      child: Container(
        color: kBackgroundColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              getBillsViewUI(),
            ],
          ),
        ),
      ),
    );
  }
}
