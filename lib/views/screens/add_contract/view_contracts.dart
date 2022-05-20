import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/data/models/contract.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/views/screens/add_contract/add_contract.dart';
import 'package:jars_mobile/views/screens/add_contract/detail_contract.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../../../view_model/contract_view_model.dart';
class ListContractScreen extends StatefulWidget {
  const ListContractScreen({Key? key, this.animationController}) : super(key: key);
  final AnimationController? animationController;
  static String routeName = '/view_contracts';

  @override
  State<ListContractScreen> createState() => _ListContractScreenState();
}

class _ListContractScreenState extends State<ListContractScreen> {
  final contractViewModel = ContractViewModel();
  final _firebaseAuth = FirebaseAuth.instance;
  List<Contract> contracts = [];

  @override
  void initState() {

    super.initState();
     getData();
 
  }

  Future<bool> getData() async {
    try{
      await Future<dynamic>.delayed(const Duration(milliseconds: 50));
       _firebaseAuth.currentUser!.getIdToken().then((idToken) {
        contractViewModel.getContracts(
        idToken: idToken,
        page: 0,
        size: 100,
        ).whenComplete(() {
          if (contractViewModel.contract.data == null) {
            return;
          }
          log('Tới Gán list');
          debugPrint('movieTitle: Tới Gán list');
          for (var contract in contractViewModel.contract.data!) {
            var _contract = Contract(
              name: contract.name,
              amount : contract.amount ,
              startDate: contract.startDate,
              endDate: contract.endDate,
              scheduleTypeId: contract.scheduleTypeId,
              id:  contract.id
            );
            contracts.add(_contract);
          }
          contracts = contracts.reversed.toList();        
        });
      });
    }catch(e){
      log('get List error: '+e.toString());
    }
    
    return true;
  }

  Widget getContractsViewUI() {
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
          return ChangeNotifierProvider<ContractViewModel>(
              create: (BuildContext context) => contractViewModel,
              child: Consumer<ContractViewModel>(
                builder: (context, viewModel, _) {
                  switch (contractViewModel.contract.status) {
                    case Status.LOADING:
                      return LoadingWidget();
                    case Status.ERROR:
                      return ErrorWidget(
                        contractViewModel.contract.message ??
                            "Something went wrong.",
                      );
                    case Status.COMPLETED:
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final contract = contracts[index];
                          var startDate = DateFormat("dd/MM/yyyy HH:mm").format(
                            DateTime.parse(contract.startDate!)
                                .toLocal(),
                          );
                          var endDate = DateFormat("dd/MM/yyyy HH:mm").format(
                            DateTime.parse(contract.endDate!)
                                .toLocal(),
                          );                      
                          var amount = NumberFormat.currency(
                            locale: 'vi_VN',
                            decimalDigits: 0,
                            symbol: 'đ',
                          ).format(contract.amount);                    
                           var sheduleType = 'Monthly' ;
                           if(contract.scheduleTypeId ==1 ){
                             sheduleType = 'day';
                           } 
                           else if(contract.scheduleTypeId ==2){
                              sheduleType = 'week';
                           }
                           else{
                             sheduleType = 'month';
                           }
                          return ListTile(
                            onTap: () {                          
                              Navigator.of(context).pushNamed(
                                DetailContractScreen.routeName,
                                arguments: DetailContractScreenArguments(
                                  contractID: contract.id!,
                                ),
                              );
                            },
                            title: Text("Name: "+contract.name.toString() + '. Amount per ' + sheduleType +" is: " +amount),
                            subtitle: Text('startDate:'+startDate + '\nendDate:'+endDate),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: contracts.length,
                      );
                    default:
                  }
                  return const SizedBox.shrink();
                },
              ));
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
          appBar: AppBar(
            title: Text('ContractList'),
            actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, 
                AddContractScreen.routeName);
              },
              child: Text("Add contract"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              
              getContractsViewUI(),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
