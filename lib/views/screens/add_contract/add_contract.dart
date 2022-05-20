
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
import 'package:mime/mime.dart';

import '../../widgets/error_snackbar.dart';

class AddContractScreen extends StatefulWidget {
  const AddContractScreen({ Key? key }) : super(key: key);
 static String routeName = '/add_contract';
  @override
  State<AddContractScreen> createState() => _AddContractScreenState();
}

class _AddContractScreenState extends State<AddContractScreen> {
    final _formKey = GlobalKey<FormState>();
    DateTime selectedStartDate = DateTime.now();
     DateTime selectedEndDate = DateTime.now();    
    File? _image;
    final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
    final _nameController = TextEditingController();
    final _amountController = TextEditingController();
    final _cloudVM = CloudViewModel();
    final _contractVM = ContractViewModel();
    final _firebaseAuth = FirebaseAuth.instance;
    final _descriptionController = TextEditingController();
    String? _fileName;
   String dropdownValue = 'Daily';
  String? _base64Image;
  @override
  Widget build(BuildContext context) {
     return new Scaffold(
       appBar: AppBar(
         title: const Text('Create Contract'),
       ),
     body: Form(
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
                              hintText: 'Name',
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
                              hintText: 'Amount',                             
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
                                value: dropdownValue,
                                elevation: 4,
                                onChanged: (String? newValue) {
                                  setState(() => dropdownValue = newValue!);
                                },
                                items: [                                
                                  'Daily',
                                  'Weekly',
                                  'Monthly',
                                  'Demo',
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
                              DateFormat("EE dd, MMMM, yyyy")
                                  .format(selectedStartDate),
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
                              DateFormat("EE dd, MMMM, yyyy")
                                  .format(selectedEndDate),
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
                        ? const SizedBox.shrink()
                        : SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.28,
                            child: Image.file(_image!),
                          ),
                  ],
                ),              
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async{
                String? imageUrl;
                if (_base64Image != null) {
                  imageUrl = await uploadImage(base64: _base64Image!);
                }
                int scheduleFromDropDown = 0;
                if(dropdownValue == 'Daily'){
                  scheduleFromDropDown =1;
                }
                else if(dropdownValue == 'Weekly'){
                  scheduleFromDropDown =2 ;
                }
                else if(dropdownValue == 'Monthly'){
                  scheduleFromDropDown = 3;
                }
                else{
                  scheduleFromDropDown = 4;
                }
                final position =  _geolocatorPlatform.getCurrentPosition();
                
                
                if (await addContract(               
                  imageUrl: imageUrl,
                  scheduleType: scheduleFromDropDown,
                )) {
                  Navigator.of(context).pop();
                } else {
                  showErrorSnackbar(
                    context: context,
                    message: "Something went wrong! Please try again.",
                  );
                }
                
              },
              child: const Text('Submit'
              ,textAlign: TextAlign.center,
              ),    
            ),
          ),
        ],
        
      ),
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
  Future<bool> addContract({  
    String? imageUrl,
    int? scheduleType,
  }) async {
    var idToken = await _firebaseAuth.currentUser!.getIdToken();
    var uid = await _firebaseAuth.currentUser!.uid;
    int? amount = int.tryParse(_amountController.text);
    Contract inputContract = new Contract();
    Note note = new Note();
   if(imageUrl == null && _descriptionController.text.isEmpty){   
    Fluttertoast.showToast(
        msg: "Add success contract without note",  // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER,    // location
        timeInSecForIosWeb: 1,              // duration
    ); 
    inputContract.accountId = uid;
    inputContract.amount = amount;
    inputContract.startDate = selectedStartDate.toIso8601String();
    inputContract.endDate = selectedEndDate.toIso8601String();
    inputContract.name = _nameController.text;
    inputContract.scheduleTypeId = scheduleType;
    return await _contractVM.addContract(
     token: idToken,
     contract : inputContract,

    );
    
  } 
   Fluttertoast.showToast(
        msg: "Add success contract with note",  // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER,    // location
        timeInSecForIosWeb: 1,              // duration
    ); 
    inputContract.accountId = uid;
    inputContract.amount = amount;
    inputContract.startDate = selectedStartDate.toIso8601String();
    inputContract.endDate = selectedEndDate.toIso8601String();
    inputContract.name = _nameController.text;
    inputContract.scheduleTypeId = scheduleType;
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double longitude = position.longitude;
      double latitude = position.latitude;
      note.comments = _descriptionController.text;
      note.id =0;
      note.image = imageUrl;   
      note.addedDate = DateTime.now().toIso8601String();
      note.longitude =  longitude;
      note.latitude = latitude;
      inputContract.note = note;
    
    
    return await _contractVM.addContract(
     token: idToken,
     contract : inputContract,

    );
  
    
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