import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '/src/constants/api_endpoints.dart';
import '/src/models/failure.dart';
import '/src/models/product.dart';
import '/src/repositories/product_repository.dart';

class ProductDatasource extends ProductRepository {
  final Dio _dio;

  ProductDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final List<Product> products = [];

      final response = await _dio.get(ApiEndPoints.getProducts);

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;

        for (var element in data) {
          products.add(Product.fromJson(element));
        }
        return Right(products);
      } else {
        return Left(
          Failure(
            statusCode: response.statusCode,
            statusMessage:
                response.statusMessage ?? 'Error in gettnig products',
          ),
        );
      }
    } on DioException catch (e) {
      throw Failure(
        statusCode: e.response?.statusCode,
        statusMessage: e.response?.statusMessage ?? 'Error in gettnig products',
      );
    }
  }
}
