
import '../../../data/models/product_key.dart';
import '../../../data/models/product_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final Map<ProductKey, List<Product>> productsType ;

  ProductLoadedState({required this.productsType});
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState({required this.error});
}
