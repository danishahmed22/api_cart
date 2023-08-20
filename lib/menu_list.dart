// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// class MenuListScreen extends StatefulWidget {
//   @override
//   _MenuListScreenState createState() => _MenuListScreenState();
// }
//
// class _MenuListScreenState extends State<MenuListScreen> {
//   List<dynamic> menuData = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     final response = await http.get(
//       Uri.parse('https://mumbaimillionaires.in/mmApi/api/show/menu-list?customer_id=1&hotel_id=2'),
//     );
//
//     if (response.statusCode == 200) {
//       setState(() {
//         menuData = json.decode(response.body)['data'];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Menu List'),
//       ),
//       body: ListView.builder(
//         itemCount: menuData.length,
//         itemBuilder: (context, index) {
//           final item = menuData[index];
//           return Card(
//             margin: EdgeInsets.all(8.0),
//             elevation: 2.0,
//             child: ListTile(
//               contentPadding: EdgeInsets.all(16.0),
//               leading: item['image'] != null
//                   ? Image.network(
//                 item['image'],
//               )
//                   : Container(width: 80, height: 80),
//               title: Text(item['name']),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(item['description']),
//                   Text(item['name']),
//                 ],
//               ),
//               trailing: Text(
//                 'Discounted Price: \$${item['discounted_price']}',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
