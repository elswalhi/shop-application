import 'package:flutter/material.dart';
import 'package:flutter_shop/components/product_tile.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/components/counter.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartState>();
    var products = context.watch<ProductsState>();

    return Scaffold(
        appBar: AppBar(title: const Text('Car'), actions: [
          IconButton(
            onPressed: cart.count > 0 ? cart.clear : null,
            icon: const Icon(Icons.delete),
          )
        ]),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: cart.count > 0
                    ? products.products != null
                        ? ListView(
                            children: cart.entries.values
                                .map((entry) => ProductTile(
                                    product: products.products!.firstWhere(
                                        (product) => product.id == entry.id)))
                                .toList(),
                          )
                        : const Center(child: CircularProgressIndicator())
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Cart is empty'),
                            ElevatedButton(
                                child: const Text('Add Products'),
                                onPressed: () =>
                                    Navigator.of(context).maybePop()),
                          ],
                        ),
                      ),
              ),
            ),
            Container(
                height: 150,
                color: Colors.blue,
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'ToTal : ',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '123le',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        width: 150,
                        height: 50,
                        child: const Center(
                          child: Text(
                            'buy now',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
