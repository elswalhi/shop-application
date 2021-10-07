import 'package:flutter/material.dart';
import 'package:flutter_shop/components/counter.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/types/product.dart';
import 'package:provider/provider.dart';

class product_view extends StatelessWidget {
  final Product product;

  const product_view({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartState>(builder: (context, cart, child) {
      return MaterialApp(
        theme: ThemeData(),
        darkTheme: ThemeData.light(),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_arrow_left),
            ),
            title: Text(product.title),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 350,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 45.0),
                            child: Image(
                              image: NetworkImage(product.image),
                              height: 150,
                              width: 150,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  product.title,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(product.price.toString() + ' €'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          product.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Counter(
                          value: cart.entries[product.id]?.quantity ?? 0,
                          onUpdate: (count) => cart.update(
                              CartEntry(id: product.id, quantity: count))),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ),
      );
    });
  }
}
