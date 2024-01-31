import 'package:flutter/material.dart';

class EditNewProductScreen extends StatefulWidget {
  const EditNewProductScreen({super.key});

  @override
  State<EditNewProductScreen> createState() => _EditNewProductScreenState();
}

class _EditNewProductScreenState extends State<EditNewProductScreen> {
  final TextEditingController _nameTEController =TextEditingController();

  final TextEditingController _codeTEController =TextEditingController();

  final TextEditingController _unitPriceTEController =TextEditingController();

  final TextEditingController _totalTEController =TextEditingController();

  final TextEditingController _quantityTEController =TextEditingController();

  final TextEditingController _imageTEController =TextEditingController();

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

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
                  validator: (String?value){
                    if(value?.trim().isEmpty ?? true){
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
                  validator: (String?value){
                    if(value?.trim().isEmpty??true){
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
                  validator: (String?value){
                    if(value?.trim().isEmpty ?? true){
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
                  validator: (String?value){
                    if(value?.trim().isEmpty ?? true){
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
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
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
                  validator: (String?value){
                    if(value?.trim().isEmpty ?? true){
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)
                        )
                      ),
                  onPressed: () {
                        if(_formKey.currentState!.validate());
                  },
                  child: const Text('Update',style: TextStyle(fontSize: 18),),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
