import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyClass(),
  ));
}

class MyClass extends StatefulWidget {
  const MyClass({Key? key}) : super(key: key);

  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  var phone = "";
  var msg = "";
  var code = "+91";
  List? mobileNumbers =[9542732466,7893841416,7013738809,9966987212];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("WhatsApp Direct"),
      //   backgroundColor: Colors.teal,
      // ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: CountryCodePicker(
                  onChanged: (val) {
                    code = val.toString();
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'IN',
                  favorite: ['+91', 'IN'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  phone = value;
                },
                decoration: InputDecoration(
                    fillColor: Colors.teal,
                    focusColor: Colors.teal,
                    hoverColor: Colors.teal,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Phone"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  msg = value;
                },
                decoration: InputDecoration(
                    fillColor: Colors.teal,
                    focusColor: Colors.teal,
                    hoverColor: Colors.teal,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Message"),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.teal,
                elevation: 5,
                child: MaterialButton(
                  child: const Text(
                    'Send',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // https://wa.me/1XXXXXXXXXX?text=I'm%20interested%20in%20your%20car%20for%20sale

                    var whatsappUrl =
                        "whatsapp://send?phone=${code + phone}" +
                            "&text=${Uri.encodeComponent(msg)}";
                    try {
                      launchUrlString(whatsappUrl);
                    } catch (e) {
                      //To handle error and display error message
                      // Helper.errorSnackBar(
                      //     context: context, message: "Unable to open whatsapp");
                    }
                  },
                  minWidth: 130,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
