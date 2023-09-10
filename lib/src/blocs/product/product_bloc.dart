import 'package:assignment_app/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/datasource/product_datasource.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductDatasource _productDatasource;

  ProductBloc({required ProductDatasource productDatasource})
      : _productDatasource = productDatasource,
        super(ProductState.initial()) {
    on<ProductFetched>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));

      final response = await _productDatasource.getProducts();

      response.fold(
        (failure) => emit(state.copyWith(
          status: ProductStatus.failure,
          failure: failure,
        )),
        (products) => emit(
          state.copyWith(
            status: ProductStatus.success,
            products: products,
          ),
        ),
      );
    });
  }
}
