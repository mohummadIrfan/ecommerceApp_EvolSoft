import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/bottomNavbarScreen/category_screen.dart';
import 'package:flutter/material.dart';

class CategoeryText extends StatefulWidget {
  const CategoeryText({super.key});

  @override
  State<CategoeryText> createState() => _CategoeryTextState();
}

class _CategoeryTextState extends State<CategoeryText> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('Categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading Categories");
              }

              return Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final categoryData = snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ActionChip(
                                    onPressed: () {},
                                    backgroundColor: Colors.pink.shade900,
                                    label: Center(
                                        child: Text(
                                      categoryData['categoryName']
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ))),
                              );
                            })),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CategoryScreen();
                            }),
                          );
                        },
                        icon: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
