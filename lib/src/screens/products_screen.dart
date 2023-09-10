import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/blocs/blocs.dart';
import '/src/core/core.dart';
import '/widgets/widgets.dart';
import 'product_details_screen.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _productBloc = serviceLocator<ProductBloc>();

  @override
  void initState() {
    _productBloc.add(const ProductFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Today\'s Deals',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/profile.png',
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        bloc: _productBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProductStatus.success:
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: GridView.builder(
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              product: state.products[index],
                            ),
                          ),
                        );
                      },
                      child: ProductTile(
                        product: state.products[index],
                      ),
                    );
                  },
                ),
              );
            case ProductStatus.failure:
            default:
              return Center(
                child: Text(
                  state.failure.statusMessage,
                ),
              );
          }
        },
      ),
    );
  }
}
