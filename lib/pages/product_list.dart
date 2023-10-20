import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/widgets/product_cart.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata'];
  late int selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = 0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final label = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = index;
                      });
                    },
                    child: Chip(
                      side: const BorderSide(
                          color: Color.fromRGBO(235, 237, 239, 1)),
                      backgroundColor: selectedFilter == index
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      label: Text(label),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.5,
                crossAxisCount:
                    size.width > 700 ? (size.width > 1400 ? 3 : 2) : 1,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailsPage(product: product);
                        },
                      ),
                    );
                  },
                  child: Productcard(
                    title: product['title'] as String,
                    price: product['price'] as double,
                    image: product['imageUrl'] as String,
                    backgroundColor: index.isEven
                        ? const Color.fromRGBO(216, 240, 253, 1)
                        : const Color.fromRGBO(245, 247, 249, 1),
                  ),
                );
              },
            ),
          ),

          //  This ListView builder can be replaced with the above GridView builder if Responsive UI is not needed

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: products.length,
          //     itemBuilder: (context, index) {
          //       final product = products[index];
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) {
          //                 return ProductDetailsPage(product: product);
          //               },
          //             ),
          //           );
          //         },
          //         child: Productcard(
          //           title: product['title'] as String,
          //           price: product['price'] as double,
          //           image: product['imageUrl'] as String,
          //           backgroundColor: index.isEven
          //               ? const Color.fromRGBO(216, 240, 253, 1)
          //               : const Color.fromRGBO(245, 247, 249, 1),
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
