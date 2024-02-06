import 'dart:convert';

import 'package:crudapp/add_new_product_screen.dart';
import 'package:crudapp/edit_product_screen.dart';
import 'package:crudapp/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum popupmenuItem {
  edit,
  delete,
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  bool isProgress = false;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    isProgress = true;
    setState(() {});
    Response response =
        await get(Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct"));
    print(response.statusCode);
    print(response.body);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    print(decodedResponse['data'.length]);

    if (response.statusCode == 200 && decodedResponse['status'] == 'success')
      products.clear();
    for (var e in decodedResponse['data']) {
      // products.clear();
      products.add(Product.toJson(e));

      isProgress = false;
      setState(() {});
    }
  }
  Future<void> deleteProduct(String id) async {
    Response response = await get(Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/$id'),);
    final Map<String, dynamic> decodedResponse =jsonDecode(response.body);
    if(response.statusCode==200 && decodedResponse ['status']=='success'){
      getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud App'),
        actions: [
          IconButton(onPressed: (){
            getProducts();

          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getProducts();
        },
        child: Visibility(
          visible: isProgress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(products[index].Img),
                  ),
                  title: Text(products[index].productName),
                  subtitle: Wrap(
                    spacing: 16,
                    children: [
                      Text('Product Code: ${products[index].ProductCode}'),
                      Text('Unit Price: ${products[index].UnitPrice}'),
                      Text(
                          'Product Total Price: ${products[index].TotalPrice}'),
                      Text('Product Quantitiy: ${products[index].Qty}'),
                    ],
                  ),
                  trailing: PopupMenuButton<popupmenuItem>(
                      onSelected: (type) =>
                          onTapPopupMenuButton(type, products[index]),
                      itemBuilder: (context) => <PopupMenuEntry<popupmenuItem>>[
                            const PopupMenuItem(
                              value: popupmenuItem.edit,
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: popupmenuItem.delete,
                              child: Row(
                                children: [
                                  Icon(Icons.delete_forever_outlined),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text('delete'),
                                ],
                              ),
                            ),
                          ]),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddNewProductScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('add'),
      ),
    );
  }

  Future<void> onTapPopupMenuButton(popupmenuItem type, Product product) async {
    switch (type) {
      case popupmenuItem.edit:
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditNewProductScreen(
              product: product,
            ),
          ),
        );
        if(result != null && result == true){
          getProducts();
        }
        break;
      case popupmenuItem.delete:
        deleteProduct(product.id);
        break;
    }
  }
}
