import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product_key.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState());

  ProductRepository blogRepository = ProductRepository();

  void fetchBlogs() async {
    emit(ProductLoadingState());
    try {
      List<Product> blogs = await blogRepository.fetchPosts();

      Map<ProductKey, List<Product>> productsType = {};
      for (var blog in blogs) {
        ProductKey pk = ProductKey(
            title: blog.category!.name.toString(),
            img: blog.category!.image.toString(),
            id: blog.category!.id!.toInt());

        if (productsType.containsKey(pk)) {
          productsType[pk]!.add(blog);
        } else {
          productsType[pk] = [blog];
        }
      }

      emit(ProductLoadedState(productsType: productsType));
    } catch (e) {
      emit(ProductErrorState(error: 'Error: $e'));
    }
  }
}
