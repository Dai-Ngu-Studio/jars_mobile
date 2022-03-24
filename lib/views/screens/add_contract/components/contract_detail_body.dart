import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/contract.dart';
import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/view_model/bill_view_model.dart';
import 'package:jars_mobile/view_model/contract_view_model.dart';
import 'package:jars_mobile/view_model/note_view_model.dart';
import 'package:jars_mobile/view_model/transaction_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:mime/mime.dart';

import '../../../../view_model/cloud_view_model.dart';

class DetailContractBody extends StatefulWidget {
  const DetailContractBody({Key? key, this.contractId})
      : super(key: key);

  final int? contractId;

  @override
  State<DetailContractBody> createState() => _DetailContractBodyState();
}

class _DetailContractBodyState extends State<DetailContractBody> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedStartDate = DateTime.now();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  File? _image;
  DateTime selectedEndDate = DateTime.now(); 
  final transactionVM = TransactionViewModel();
  final _cloudVM = CloudViewModel();
  final walletVM = WalletViewModel();
  
  final noteVM = NoteViewModel();
  final contracVM = ContractViewModel();
  final billVM = BillViewModel();
  final _firebaseAuth = FirebaseAuth.instance;
  String? _fileName;
  String dropdownValue = 'Daily';
  String? _base64Image;
  Contract? contractDetail;
  

  @override
  void initState() {
    super.initState();
    getData();
  }
  TextEditingController _descriptionController = TextEditingController(text: '');
  Future<Map<String, dynamic>> getData() async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    Map<String, dynamic> data = <String, dynamic>{};

    var contract = await contracVM.getContract(
      idToken: idToken,
      contractID: widget.contractId!,
    ); 
    data.addAll({"contract": contract});
    return data;
  }

  
   TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  Widget getDetailContractUI() {
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
              child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Expanded(
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child:    TextFormField(
                              controller: _nameController,                         
                              decoration: new InputDecoration(
                                hintText: snapshot.data!['contract'].name.toString(),
                                border: InputBorder.none,  
                                        
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                
                                ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          )
                        ),           
                    ],
                ),
                 const Divider(thickness: 1, height: 8),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Expanded(
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child:    TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: snapshot.data!['contract'].amount.toString(),                             
                                border: InputBorder.none,                
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                
                                ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          )
                        ),           
                    ],
                ),
                 const Divider(thickness: 1, height: 8),
                Row(
                    children: [
                      
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 16, 8),
                        child: Text('ScheduleType'),
                      ),
                      Expanded(
                        child: Row(                    
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [                        
                               Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: DropdownButton(
                                  value: snapshot.data!['contract'].scheduleTypeId.toString() == 1 ?
                                  'Daily':
                                  snapshot.data!['contract'].scheduleTypeId.toString() == 2 ?'Weekly' :'Monthly' ,
                                  elevation: 4,
                                  onChanged: (String? newValue) {
                                    setState(() => dropdownValue = newValue!);
                                  },
                                  items: [                                
                                    'Daily',
                                    'Weekly',
                                    'Monthly',
                                  ].map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
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
                    children: [
                      Text('StartDate\n'),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                        child: Icon(Icons.edit_calendar_rounded),
                      ),
                      Expanded(
                        child: Row(                    
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [                        
                            InkWell(
                              onTap: () => _selectStartDate(context),
                              child: Text(
                                snapshot.data!['contract'].startDate.toString() == null?
                                DateTime.now().toIso8601String():
                                snapshot.data!['contract'].startDate.toString(),
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
                    children: [
                      Text('EndDate\n'),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                        child: Icon(Icons.edit_calendar_rounded),
                      ),
                      Expanded(
                        child: Row(                    
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [                        
                            InkWell(
                              onTap: () => _selectEndDate(context),
                              child: Text(
                               snapshot.data!['contract'].endDate.toString() == null?
                                DateTime.now().toIso8601String():snapshot.data!['contract'].endDate.toString(),
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
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                        child: Icon(Icons.edit_note_rounded),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _descriptionController,                  
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText:  snapshot.data!['contract'].note != null ?
                             snapshot.data!['contract'].note.comments !=null ?
                            snapshot.data!['contract'].note.comments.toString():'':'',
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
                  const Divider(thickness: 1, height: 8),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                            child: Icon(Icons.image_rounded),
                          ),
                          InkWell(
                            onTap: _handleImageSelection,
                            child: const Text("Click here to select note image"),
                          ),
                        ],
                      ),
                     
                      _image == null
                          ? snapshot.data!['contract'].note != null ? 
                            snapshot.data!['contract'].note.image != null?
                                 SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * 0.26,
                                    child: Image.network(snapshot.data!['contract'].note.image.toString()),
                                  )                                   
                                : SizedBox.shrink()
                                : SizedBox.shrink():SizedBox(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height * 0.26,
                                  child: Image.file(_image!),
                          ),
                    ],
                  ),              
              Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async{
                },
                child: const Text('Edit'
                ,textAlign: TextAlign.center,
                ),    
              ),
            ),
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
          getDetailContractUI(),
        ],
      ),
    );
  }
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (pickedStartDate != null && pickedStartDate != selectedStartDate) {
      setState(() {
        selectedStartDate = pickedStartDate;
      });
    }
  }
    Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }
  Future<String> uploadImage({required String base64}) async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    return await _cloudVM.uploadImage(idToken: idToken, base64: base64);
  }
  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = File(result.path).readAsBytesSync();
      _base64Image =
          "data:image/${lookupMimeType(result.path)!.split("/")[1]};base64,${base64Encode(bytes)}";

      log("img : $_base64Image");

      setState(() {
        _image = File(result.path);
        _fileName = result.name;
        _base64Image =
            "data:image/${lookupMimeType(result.path)!.split("/")[1]};base64,${base64Encode(bytes)}";
      });
    }
  }
}
