import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:lec8/model/student.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  Student myStudent = Student();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(title: Text('Error')),
                body: Center(
                  child: Text('${snapshot.error}'),
                ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: Text('แบบฟอร์มบันทึกข้อมูล')),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ชื่อ', style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator:
                                RequiredValidator(errorText: 'กรุณาป้อนชื่อ'),
                            onSaved: (value) {
                              myStudent.fname = value;
                            },
                          ),
                          SizedBox(height: 15),
                          Text('นามสกุล', style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนนามสกุล'),
                            onSaved: (value) {
                              myStudent.lname = value;
                            },
                          ),
                          SizedBox(height: 15),
                          Text('อีเมล', style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'กรุณาป้อนอีเมล'),
                              EmailValidator(errorText: 'อีเมลไม่ถูกต้อง'),
                            ]),
                            onSaved: (value) {
                              myStudent.email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 15),
                          Text('อุณหภูมิ', style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนอุณหภูมิ'),
                            onSaved: (value) {
                              myStudent.temp = value;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                child: Text('บันทึก'),
                                style: ElevatedButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 20)),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    await _studentCollection.add({
                                      'fname': myStudent.fname,
                                      'lname': myStudent.lname,
                                      'email': myStudent.email,
                                      'temp': myStudent.temp
                                    });
                                    formKey.currentState?.reset();
                                  }
                                }),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
