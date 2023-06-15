import 'dart:convert';

import 'package:app_api/componants/home_screen/card_orders.dart';
import 'package:app_api/componants/global/text_field_custom.dart';
import 'package:app_api/services/api/User/create_order.dart';
import 'package:app_api/services/api/User/get_orders.dart';
import 'package:app_api/services/extention/navigator/push_ext.dart';
import 'package:app_api/views/get_id_screen.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:app_api/views/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List listOrders = [];
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    _test();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.pushAndRemove(view: const LoginScreen());
          },
        ),
        title: const Text('My Orders'),
        actions: [
          IconButton(
              onPressed: () {
                context.push(view: const GetScreenID());
              },
              icon: const Icon(Icons.list_alt_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFieldCustom(
              hint: "Title",
              label: "Title",
              controller: titleController,
              icon: Icons.read_more,
            ),
            TextFieldCustom(
                minLines: 3,
                maxLines: 10,
                hint: "content",
                label: "content",
                controller: contentController,
                icon: Icons.content_copy),
            //-------------- Add Order Button ---------------
            Center(
                child: ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline),
              label: const Text(
                "Add Order",
                style: TextStyle(fontSize: Checkbox.width),
              ),
              onPressed: () async {
                isloading = false;
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  await createOrder(context: context, body: {
                    "title": titleController.text,
                    "content": contentController.text
                  });
                  setState(() {});
                  _test();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter Order Detailes')));
                }
              },
            )),
            const SizedBox(
              height: 18,
            ),
            //-------------- display orders ---------------
            if (!isloading) ...[
              const CircularProgressIndicator(),
            ] else ...[
              Expanded(
                child: ListView(children: [
                  for (var item in listOrders)
                    InkWell(
                        onTap: () {
                          context.push(view: OrderScreen(order: item));
                        },
                        child: CardOrders(order: item)),
                ]),
              )
            ]
          ],
        ),
      ),
    );
  }

  _test() async {
    if ((await getOrders()).statusCode == 200) {
      listOrders = json.decode((await getOrders()).body)["data"];
      isloading = true;
      setState(() {});
    } else {
      final box = GetStorage();
      box.remove("token");
      if (context.mounted) {
        context.pushAndRemove(view: const LoginScreen());
      }
    }
  }
}
