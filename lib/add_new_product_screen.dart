import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();

  final TextEditingController _codeTEController = TextEditingController();

  final TextEditingController _unitPriceTEController = TextEditingController();

  final TextEditingController _totalTEController = TextEditingController();

  final TextEditingController _quantityTEController = TextEditingController();

  final TextEditingController _imageTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addnewProductProgress= false;

  @override


  Future<void> createNewProductFromAPI() async {
    _addnewProductProgress=true;
    setState(() {});
    Map<String, dynamic> params = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalTEController.text.trim(),
      "UnitPrice": _unitPriceTEController.text.trim(),
    };
    Response response = await post(
        Uri.parse(
          'https://crud.teamrabbil.com/api/v1/CreateProduct',
        ),
        body: jsonEncode(params),
        headers: {'Content-type': 'application/json'});
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200){
      _unitPriceTEController.clear();
      _totalTEController.clear();
      _quantityTEController.clear();
      _nameTEController.clear();
      _codeTEController.clear();
      _imageTEController.clear();
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully added')));
      }
    }

    _addnewProductProgress=false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your product name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Product Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _codeTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your product code';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Product Code',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _unitPriceTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your unit price';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Product Unit Price',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your quantity';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Product Quantity',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _totalTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your total price';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Product Total Price',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _imageTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'enter your image';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Image',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 50,
                    child: Visibility(
                      visible: _addnewProductProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()){
                            createNewProductFromAPI();
                          }
                        },
                        child: const Text(
                          'Add New Item',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
