
import 'package:crudapp/add_new_product_screen.dart';
import 'package:crudapp/edit_product_screen.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud App'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1573164574472-797cdf4a583a?q=80&w=1469&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ),
              title: const Text('Product Name'),
              subtitle: const Wrap(
                spacing: 16,
                children: [
                  Text('Product Code'),
                  Text('Product Unit Price'),
                  Text('Product Total Price'),
                  Text('Product Quantitiy'),
                ],
              ),
              trailing: PopupMenuButton<popupmenuItem>(
                  onSelected: onTapPopupMenuButton,

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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewProductScreen()),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('add'),),
    );
  }

  void onTapPopupMenuButton(popupmenuItem type){
    switch(type){
      case popupmenuItem.edit:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditNewProductScreen()));
        break;
      case popupmenuItem.delete:
    }
  }
}
