import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lift_u_tech_internshala/presentation/screens/product_page.dart';

import '../../data/models/product_key.dart';
import '../../data/models/product_model.dart';
import '../../logic/cubits/blog_cubit/product_cubit.dart';
import '../../logic/cubits/blog_cubit/product_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductInitialState || state is ProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductLoadedState) {
              final products = state.productsType;
              return buildBlogView(products);
            }
            if (state is ProductErrorState) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
            return const Center(
              child: Text(
                "Nothing Here",
              ),
            );
          },
        ),
      ),
    );
  }

  ListView buildBlogView(Map<ProductKey, List<Product>> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final key = products.keys.elementAt(index);
        final value = products[key];
        return GestureDetector(
          onTap: (){
            Navigator.push (
              context,
              MaterialPageRoute (
                builder: (BuildContext context) =>  ProductPage(product: value, title: key.title),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.blueGrey,
              color: const Color(0xff2B2B2B),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      key.img,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        key.title,
                        style:const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Total Available Products in this category : ${value!.length}',
                        style:const  TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )

        );
      },
    );
  }
}
