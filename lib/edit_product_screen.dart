import 'dart:convert';

import 'package:crudapp/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EditNewProductScreen extends StatefulWidget {
  const EditNewProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<EditNewProductScreen> createState() => _EditNewProductScreenState();
}

class _EditNewProductScreenState extends State<EditNewProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();

  final TextEditingController _codeTEController = TextEditingController();

  final TextEditingController _unitPriceTEController = TextEditingController();

  final TextEditingController _totalTEController = TextEditingController();

  final TextEditingController _quantityTEController = TextEditingController();

  final TextEditingController _imageTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateInProgress= false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName;
    _codeTEController.text = widget.product.ProductCode;
    _unitPriceTEController.text = widget.product.UnitPrice;
    _totalTEController.text = widget.product.TotalPrice;
    _imageTEController.text = widget.product.Img;
    _quantityTEController.text = widget.product.Qty;
  }

  Future<void> updateProduct() async {
    _updateInProgress=true;
    setState(() {});
    Response response = await post(
      Uri.parse(
          'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "Img": _imageTEController.text.trim(),
          "ProductCode": _codeTEController.text.trim(),
          "ProductName": _nameTEController.text.trim(),
          "Qty": _quantityTEController.text.trim(),
          "TotalPrice": _totalTEController.text.trim(),
          "UnitPrice": _unitPriceTEController.text.trim(),
        },
      ),
    );
    if(response.statusCode == 200){
      final decodedBody=jsonDecode(response.body);
      if(decodedBody['status']=='success'){
        _nameTEController.clear();
        _unitPriceTEController.clear();
        _codeTEController.clear();
        _imageTEController.clear();
        _quantityTEController.clear();
        _totalTEController.clear();
        _unitPriceTEController.clear();
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Request successfully'),),);
          Navigator.pop(context,true);
        }
    }else{
        _updateInProgress=true;
        setState(() {});
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Request Fail..!'),),);
        }
      }
    }else{
      _updateInProgress=true;
      setState(() {});
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request Fail..!'),),);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates Product'),
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
                      visible: _updateInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),),),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateProduct();
                          }
                        },
                        child: const Text(
                          'Update',
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
