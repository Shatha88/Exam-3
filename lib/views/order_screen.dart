import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.order});

  final Map order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
      appBar: AppBar(
        title: Text(
          order['title'],
          style: const TextStyle(
              fontSize: Checkbox.width, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(order["create_at"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Checkbox.width)),
                      ),
                      Container(height: 16),
                      Text('ID: ${order["id"]}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: Checkbox.width)),
                      Container(height: 5),
                      Text('Title: ${order["title"]}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Checkbox.width)),
                      Container(height: 10),
                      Text('Content: ${order["content"]}',
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                              fontSize: Checkbox.width))
                    ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
