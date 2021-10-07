import 'package:flutter/material.dart';
import 'package:flutter_shop/components/counter.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/favorites.dart';
import 'package:flutter_shop/routes/product_view.dart';
import 'package:flutter_shop/types/product.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoritesState = context.watch<FavoritesState>();

    return Consumer<CartState>(
      builder: (context, cart, child) => Card(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => product_view(
                          product: this.product,
                        )));
          },
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Material(
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white38,
                            child: IconButton(
                                onPressed: () =>
                                    favoritesState.toggle(product.id),
                                icon: favoritesState.ids.contains(product.id)
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red)
                                    : const Icon(Icons.favorite_border)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(product.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.caption),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              product.price.toString() + ' €',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.blueGrey,
                              ),
                            )
                          ],
                        ),
                      ])),
              Flexible(child: Container()),
              Counter(
                  value: cart.entries[product.id]?.quantity ?? 0,
                  onUpdate: (count) =>
                      cart.update(CartEntry(id: product.id, quantity: count))),
            ],
          ),
        ),
      ),
    );
  }
}
