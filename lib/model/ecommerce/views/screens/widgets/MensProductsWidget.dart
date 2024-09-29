import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/ecommerce/views/screens/inner_screen.dart/product_detail_screen.dart';
import 'package:flutter/material.dart';

class MenProductsWidget extends StatelessWidget {
  const MenProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: 'Men Products')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 100,
              child: PageView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ProductDetailScreen();
                          }),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 90,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey),
                                color: Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x0f000000),
                                  )
                                ]),
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      productData['imageUrlLink'][0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      productData['productName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21),
                                    ),
                                    Text(
                                      '\Rs' +
                                          '' +
                                          productData['productPrice']
                                              .toString(),
                                      style: TextStyle(color: Colors.pink),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
        );
      },
    );
  }
}
