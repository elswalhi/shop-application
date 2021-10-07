import 'package:flutter/material.dart';
import 'package:flutter_shop/components/counter.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/routes/product_view.dart';
import 'package:flutter_shop/types/product.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartState>(builder: (context, cart, child) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => product_view(
                        product: this.product,
                      )));
        },
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                maxLines: 1,
              ),
              Text(
                product.price.toString() + ' €',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          subtitle: Text(
            product.description,
            maxLines: 2,
          ),
          leading: Image.network(
            product.image,
            width: 50,
          ),
          trailing: Counter(
              value: cart.entries[product.id]?.quantity ?? 0,
              onUpdate: (count) =>
                  cart.update(CartEntry(id: product.id, quantity: count))),
        ),
      );
    });
  }
}
