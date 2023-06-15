import 'dart:convert';

import 'package:app_api/componants/global/text_field_custom.dart';
import 'package:app_api/services/api/User/get_byid.dart';
import 'package:flutter/material.dart';

class GetScreenID extends StatefulWidget {
  const GetScreenID({super.key});

  @override
  State<GetScreenID> createState() => _GetScreenIDState();
}

class _GetScreenIDState extends State<GetScreenID> {
  Map order = {};
  final TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
      appBar: AppBar(
        title: const Text('View Order'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
          child: TextFieldCustom(
              controller: idController,
              hint: "enter id",
              label: "ID",
              icon: Icons.view_agenda),
        ),
        Center(
            // _________________________ View order Button _________________________
            child: ElevatedButton.icon(
          icon: const Icon(Icons.pages_rounded),
          label: const Text("View Order",style: TextStyle(fontSize: Checkbox.width),),
          onPressed: () async {
            try {
              if (idController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter an ID')));
              } else {
                order =
                    json.decode((await getByID(id: idController.text)).body);
                if ((order["data"] as List).isEmpty) {
                  order = {};
                } else {
                  order = order["data"][0];
                }

                setState(() {});
              }
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("plase enter correct number")));
            }
          },
        )),
        Visibility(
            visible: order.isNotEmpty,
            child: SizedBox(
              width: 360,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text('${order["create_at"]}',
                            style: const TextStyle(
                                fontSize: Checkbox.width,
                                fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('ID: ${order["id"]}',
                          style: const TextStyle(
                              fontSize: Checkbox.width,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Text('Title: ',
                              style: TextStyle(
                                  fontSize: Checkbox.width,
                                  fontWeight: FontWeight.bold)),
                          Text('${order["title"]}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('Content:',
                          style: TextStyle(
                              fontSize: Checkbox.width,
                              fontWeight: FontWeight.bold)),
                      Text('${order["content"]}',
                          style: const TextStyle(
                              fontSize: Checkbox.width,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            )),
      ]),
    );
  }
}
