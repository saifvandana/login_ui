// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import '../common/theme_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class UploadData extends StatefulWidget {
  const UploadData({Key? key}) : super(key: key);

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  Key _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String description = '';
  String title = '',
      name = '',
      phone = '',
      email = '',
      price = '',
      category = '',
      about = '',
      process = '',
      state = '',
      location = '',
      region = '',
      postalCode = '',
      adress = '';

  TextEditingController _name = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();

  List<Asset> images = [];

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 70,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Post".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(25, 60, 25, 10),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('POST INFO'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Category *',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: width,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _title,
                        decoration: ThemeHelper().textInputDecoration(
                            'Title *'.tr, 'Enter the title of your post'.tr),
                      ),
                      //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: MarkdownTextInput(
                        (String value) => setState(() => description = value),
                        description,
                        label: 'Description',
                        actions: MarkdownType.values,
                        controller: _about,
                      ),
                      //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        TextField(
                          controller: _price,
                          inputFormatters: <TextInputFormatter>[
                            CurrencyTextInputFormatter(
                                decimalDigits: 0, symbol: 'TL')
                          ],
                        ),
                      ],
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    Text('LOCATION INFO'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Location *',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: width,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _region,
                        decoration: ThemeHelper()
                            .textInputDecoration("Region".tr, "".tr),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: _postalCode,
                        decoration: ThemeHelper()
                            .textInputDecoration("Postal Code".tr, "".tr),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: _address,
                        decoration: ThemeHelper()
                            .textInputDecoration("Address".tr, "".tr),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 30.0),
                    Text('SELLER INFO'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _name,
                        decoration:
                            ThemeHelper().textInputDecoration("Name".tr, "".tr),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: _phone,
                        decoration: ThemeHelper()
                            .textInputDecoration("Phone".tr, "".tr),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 15.0),
                    FormField<bool>(
                      builder: (state) {
                        return Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                    value: checkboxValue,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue = value!;
                                        state.didChange(value);
                                      });
                                    }),
                                Text(
                                  "Show phone number in post".tr,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.errorText ?? '',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: _email,
                        decoration: ThemeHelper().textInputDecoration(
                            "E-mail address".tr, "Enter your email".tr),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 15.0),
                    FormField<bool>(
                      builder: (state) {
                        return Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                    value: checkboxValue,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue = value!;
                                        state.didChange(value);
                                      });
                                    }),
                                Text(
                                  "Show email adress in post".tr,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.errorText ?? '',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        child: Column(
                      children: [
                        Text(
                          'PHOTOS',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'A post can have at most 10 photos',
                          style: TextStyle(fontSize: 15),
                        ),
                        //Flexible(child: buildGridView()),
                        Container(
                          height: 250,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: buildGridView(),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 235, 235),
                            borderRadius: BorderRadius.circular(5) ),
                        ),
                        RaisedButton(
                            child: Text(
                              'Upload Photos',
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: loadAssets),
                      ],
                    )),
                    SizedBox(height: 40.0),
                    Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            "UPLOAD".tr,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
