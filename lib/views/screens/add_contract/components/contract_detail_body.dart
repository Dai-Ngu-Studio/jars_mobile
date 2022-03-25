import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
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
import 'package:jars_mobile/views/screens/login/components/body.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:mime/mime.dart';

import '../../../../data/models/note.dart';
import '../../../../view_model/cloud_view_model.dart';
import '../../../widgets/error_snackbar.dart';

class DetailContractBody extends StatefulWidget {
  const DetailContractBody({Key? key, this.contractId})
      : super(key: key);

  final int? contractId;

  @override
  State<DetailContractBody> createState() => _DetailContractBodyState();
}

class _DetailContractBodyState extends State<DetailContractBody> {
  final _formKey = GlobalKey<FormState>();
  
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  File? _image;
  
  final transactionVM = TransactionViewModel();
  final _cloudVM = CloudViewModel();
  final walletVM = WalletViewModel();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  final noteVM = NoteViewModel();
  final contracVM = ContractViewModel();
  final billVM = BillViewModel();
  final _firebaseAuth = FirebaseAuth.instance;
  String? _fileName;
  String dropdownValue = 'Daily';
  String? _base64Image;
  Contract? contractDetail;
  Note? note;

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
    selectedStartDate = selectedStartDate ?? DateTime.parse(contract.startDate!);
    selectedEndDate = selectedEndDate ?? DateTime.parse(contract.endDate!);
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
                                  value: snapshot.data!['contract'].scheduleTypeId.toString() == '1' ?
                                  'Daily':
                                  snapshot.data!['contract'].scheduleTypeId.toString() == '2' ?'Weekly' :
                                  snapshot.data!['contract'].scheduleTypeId.toString() == '3'?'Monthly' :'Demo' ,
                                  elevation: 4,
                                  onChanged: (String? newValue) {
                                    setState(() => dropdownValue = newValue!);
                                  },
                                  items: [                                
                                    'Daily',
                                    'Weekly',
                                    'Monthly',
                                    'Demo'
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
                              onTap: ()=> _selectStartDate(context),
                                
                              child: Text(
                                selectedStartDate!.toIso8601String(),
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
                              onTap: () =>
                                _selectEndDate(context),
                              
                              child: Text(
                                selectedEndDate!.toIso8601String(),
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
                  contractDetail =Contract();
                  note = Note();
                   contractDetail!.scheduleTypeId = 1;
                  if(dropdownValue == "Weekly"){
                    contractDetail!.scheduleTypeId = 2;
                  }
                  else if(dropdownValue == "Monthly"){
                    contractDetail!.scheduleTypeId = 3;
                  }else{
                    contractDetail!.scheduleTypeId = 4;
                  }
                  String? imageUrl;
                  if (_base64Image != null) {
                    imageUrl = await uploadImage(base64: _base64Image!);
                  }

                  contractDetail!.noteId = snapshot.data!["contract"].noteId;
                  contractDetail!.id = snapshot.data!["contract"].id;
                  if(_nameController.text.isNotEmpty){
                    contractDetail!.name = _nameController.text.toString();
                  }
                  else{
                    contractDetail!.name = snapshot.data!["contract"].name;
                  }
                  contractDetail!.accountId = snapshot.data!["contract"].accountId;
                  if(_amountController.text.isNotEmpty){
                    contractDetail!.amount = double.parse(_amountController.text.toString());
                  }
                  else{
                    contractDetail!.amount = snapshot.data!["contract"].amount;
                  }
                //   selectedStartDate =DateTime.parse(snapshot.data!["contract"].startDate.toString()); 
                //   selectedEndDate = DateTime.parse(snapshot.data!["contract"].endDate.toString()); 
                  if( selectedEndDate!.toIso8601String().isNotEmpty){
                  contractDetail!.endDate = selectedEndDate!.toIso8601String();
                  }
                  else{
                    contractDetail!.endDate = snapshot.data!["contract"].endDate;
                  }
                  if(selectedStartDate!.toIso8601String().isNotEmpty){
                  contractDetail!.startDate = selectedStartDate!.toIso8601String();
                  }
                  else{
                    contractDetail!.startDate = snapshot.data!["contract"].startDate.toString();
                  }
                  //
                  log('Description for form : '+_descriptionController.text.toString());
                
                   //Nếu contract không có note và 2 field hình và des != null -> add note
                  if(snapshot.data!["contract"].note ==null){
                    if(_descriptionController.text.isNotEmpty || imageUrl != null){
                      var idToken = await _firebaseAuth.currentUser!.getIdToken();
                      note?.contractId = widget.contractId;
                      note?.addedDate = DateTime.now().toIso8601String();
                      note?.image = imageUrl;                
                      note?.comments = _descriptionController.text.toString();
                       var notePost = await noteVM.createNote(
                        idToken: idToken,
                         addDate: DateTime.now().toIso8601String(), 
                         contractId: num.parse(widget.contractId.toString()),
                         image: imageUrl,
                        comments:  _descriptionController.text.toString(),
                        );
                        contractDetail!.noteId = notePost.id;
                    }
                 
                  }
                    //Nếu contract  có note -> update note
                  else{
                       await Geolocator.checkPermission();
                      await Geolocator.requestPermission();
                      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                    if(_descriptionController.text.toString().isNotEmpty ){
                    note?.comments = _descriptionController.text;
                    }
                    else{
                    note?.comments = snapshot.data!["contract"].note.comments;
                    }
                    // 
                    if(snapshot.data!["contract"].note.longitude != null){
                      note?.longitude = snapshot.data!["contract"].note.longitude;
                    }
                    else{
                      note?.longitude = position.longitude;
                    }
                    if(snapshot.data!["contract"].note.latitude != null){
                        note?.latitude = snapshot.data!["contract"].note.latitude;
                    }
                    else{
                      note?.latitude = position.latitude;
                    }
                  
                    if(imageUrl != null ){
                      note?.image = imageUrl;
                    }
                    else{
                      note?.image = snapshot.data!['contract'].note.image;
                    }
                    note?.addedDate = snapshot.data!['contract'].note.addedDate;
                      contractDetail?.note = note;
                  }
                  
                  
                   updateContract(
                        contract: contractDetail,
                        );
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
        initialDate: selectedStartDate ?? DateTime.now(),
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
        initialDate: selectedEndDate ?? DateTime.now(),
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
  Future updateContract({Contract? contract}) async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();

    await contracVM.updateContract(
      idToken: idToken,
      contractId: contract!.id!,
      noteId :contract.noteId!,
      name:contract.name!,
      startDate:contract.startDate!,
      endDate:contract.endDate!,
      scheduleTypeId:contract.scheduleTypeId!,
      amount:contract.amount!,
      accountId:contract.accountId!,
      comment:contract.note!.comments!,
      longitude:contract.note!.longitude,
      latitude:contract.note!.latitude,
      image:contract.note!.image,
      addedDate:contract.note!.addedDate,
    );
    Navigator.of(context).pop();
  }
  Future addNote({Note? note}) async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    await noteVM.createNote(
      idToken: idToken,
      contractId: num.parse(note!.contractId.toString()),
      addDate: DateTime.now().toIso8601String(),
      latitude: note.latitude,
      longitude: note.longitude,
      comments: note.comments,
      image: note.image
    );   
  }
}
