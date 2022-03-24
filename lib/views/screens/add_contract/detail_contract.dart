
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/contract.dart';
import 'package:jars_mobile/data/models/note.dart';
import 'package:jars_mobile/view_model/cloud_view_model.dart';
import 'package:jars_mobile/view_model/contract_view_model.dart';
import 'package:jars_mobile/views/screens/add_contract/components/contract_detail_body.dart';
import 'package:mime/mime.dart';

import '../../../constant.dart';
import '../../widgets/error_snackbar.dart';



class DetailContractScreen extends StatelessWidget {
const DetailContractScreen({ Key? key }) : super(key: key);
 static String routeName = '/detail-contract';

  @override
  Widget build(BuildContext context) {
    DetailContractScreenArguments args = ModalRoute.of(context)!.settings.arguments
        as DetailContractScreenArguments;
    log('args.contractID:' +args.contractID.toString());
    if(args.contractID.toString().isEmpty){
      log('args.contractID null');
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: const Text('Contract Detail', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      
      body: DetailContractBody(contractId: args.contractID),
    );
  }
}

class DetailContractScreenArguments {
  final int contractID;

  DetailContractScreenArguments({required this.contractID});
}