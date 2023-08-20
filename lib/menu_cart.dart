import 'dart:convert';
import 'package:api_assignment/billing_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MenuListScreen extends StatefulWidget {
  @override
  _MenuListScreenState createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  List<dynamic> menuData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://mumbaimillionaires.in/mmApi/api/show/menu-list?customer_id=1&hotel_id=2'),
    );

    if (response.statusCode == 200) {
      setState(() {
        menuData = json.decode(response.body)['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu List'),
      ),
      body: ListView.builder(
        itemCount: menuData.length,
        itemBuilder: (context, index) {
          final item = menuData[index];
          return MenuCard(item: item);
        },
      ),
    );
  }
}

class MenuCard extends StatefulWidget {
  final Map<String, dynamic> item;

  MenuCard({required this.item});

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int quantity = 1;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    setState(() {
      totalPrice = widget.item['discounted_price'] * quantity;
    });
  }

  void addToCart(BuildContext context) {
    print(quantity);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillingScreen(selectedItemData: {
          'name': widget.item['name'],
          'description': widget.item['description'],
          'hotel_name': widget.item['hotel_name'],
          'quantity': quantity,
          'discounted_price': widget.item['discounted_price'],
          'totalPrice': totalPrice,
          // Add more data as needed
        }),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(8.0),
        elevation: 2.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              child: Image.asset('lib/assets/images/top-view-food-frame-with-copy-space.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.0),
                    Text(widget.item['description']),
                    Text(widget.item['hotel_name']),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text('Price: '),
                        Text('\$${widget.item['original_price']} ', style: TextStyle(decoration: TextDecoration.lineThrough)),
                        Text('\$${widget.item['discounted_price']}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                            calculateTotalPrice();
                          });
                        }
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                          calculateTotalPrice();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () => addToCart(context),
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
