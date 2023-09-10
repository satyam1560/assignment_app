import 'package:dartz/dartz.dart';

import '/src/models/models.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
