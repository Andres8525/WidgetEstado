import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> products = [
    Product("Laptop", 1500),
    Product("Smartphone", 900),
    Product("Tablet", 600),
  ];

  List<Product> cart = [];

  double total = 0;

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
      total += product.price;
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      cart.remove(product);
      total -= product.price;
    });
  }

  int getQuantity(Product product) {
    int count = 0;
    for (var item in cart) {
      if (item.name == product.name) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart (${cart.length})"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return Card(
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                      "\$${product.price}  |  In cart: ${getQuantity(product)}",
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        addToCart(product);
                      },
                      child: const Text("Add"),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          const Text("Cart", style: TextStyle(fontSize: 20)),
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                var item = cart[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("\$${item.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      removeFromCart(item);
                    },
                  ),
                );
              },
            ),
          ),
          Text("Total: \$${total}", style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
