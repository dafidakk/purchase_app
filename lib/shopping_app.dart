import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchase_app/utils/const.dart';
import 'package:purchase_app/utils/model.dart';
import 'package:purchase_app/utils/my_button.dart';
import 'package:purchase_app/utils/product_dialog.dart';

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  List<Item> itemList = [];
  int basketCount = 0;
  List basketList = [];
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();

  void showSnack(String title) {
    final snackbar = SnackBar(
        duration: Duration(seconds: 1, milliseconds: 500),
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ));
    scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }

  // update basket

  void updateBasketCount(title) {
    setState(() {
      basketCount += 1;
      basketList.add(title);
    });
    showSnack(title + " added to cart");
  }

  // save new item
  void saveNewItem() {
    setState(() {
      var _item = Item(
        itemName: itemNameController.text,
        itemPrice: itemPriceController.text,
      );
      itemList.add(_item);
      Navigator.of(context).pop();
    });
    itemNameController.clear();
    itemPriceController.clear();
  }

  // create item
  void createNewItem() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          itemName: itemNameController,
          itemPrice: itemPriceController,
          onSave: () {
            if (itemNameController.text.isEmpty ||
                itemPriceController.text.isEmpty) {
              HapticFeedback.vibrate();
              showSnack("Please fill all out the fields");
            } else {
              saveNewItem();
            }
          },
          onCancel: () {
            itemNameController.clear();
            itemPriceController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  // delete item
  void deleteItem(index, title) {
    setState(() {
      itemList.removeAt(index);
      // if the items in the cart delete from there also
      if (basketList.contains(title)) {
        basketCount -= 1;
        showSnack(title + " deleted from items and cart");
      } else {
        showSnack(title + " deleted from items");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Items",
          style: shopStyle(30, Colors.white, FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              basketCount.toString(),
              style: shopStyle(30),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: showWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: createNewItem,
      ),
    );
  }

  showWidget() {
    if (itemList.isEmpty) {
      return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          body: Center(
            child: Text(
              "No Items",
              style: shopStyle(25, Colors.black45, FontWeight.w700),
            ),
          ),
        ),
      );
    } else {
      return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          body: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  child: Dismissible(
                    key: Key(itemList[index].itemName),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) =>
                        deleteItem(index, itemList[index].itemName),
                    child: ListTile(
                      title: Text(
                        itemList[index].itemName,
                        style: shopStyle(17, Colors.black, FontWeight.bold),
                      ),
                      subtitle: Text(itemList[index].itemPrice + ".0 TL"),
                      trailing: MyElevatedButton(
                        text: "Add",
                        onPressed: () {
                          updateBasketCount(itemList[index].itemName);
                        },
                      ),
                    ),
                    background: Container(
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
