import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final double? rate;
  final int? count;

  const Rating({
    this.rate,
    this.count,
  });

  Rating copyWith({
    double? rate,
    int? count,
  }) {
    return Rating(
      rate: rate ?? this.rate,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'rate': rate,
      'count': count,
    };
  }

  factory Rating.fromJson(Map<String, dynamic> map) {
    return Rating(
      rate:
          map['rate'] != null ? double.tryParse(map['rate'].toString()) : null,
      count: map['count'] != null ? map['count'] as int : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [rate, count];
}
