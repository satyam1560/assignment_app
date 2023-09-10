part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product> products;
  final Failure failure;

  const ProductState({
    required this.status,
    required this.products,
    required this.failure,
  });

  factory ProductState.initial() {
    return const ProductState(
      status: ProductStatus.initial,
      products: [],
      failure: Failure(),
    );
  }

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    Failure? failure,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, products, failure];
}
