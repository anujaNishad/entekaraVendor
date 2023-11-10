part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {
  final int vendorId;
  final String search;
  const FetchProduct(this.vendorId, this.search);
}

class FetchProductVariant extends ProductEvent {
  final int productId;
  const FetchProductVariant(this.productId);
}

class AddProductVariant extends ProductEvent {
  final int vendorId;
  final int productId;
  final int variantId;
  final dynamic price;
  final dynamic discount;
  const AddProductVariant(
      this.vendorId, this.productId, this.variantId, this.price, this.discount);
}

class FetchProductItem extends ProductEvent {
  final int vendorId;
  final String search;
  const FetchProductItem(this.vendorId, this.search);
}

class UpdateProductItem extends ProductEvent {
  final int vendorproduct_id;
  final int vendorId;
  final int productId;
  final int variantId;
  final dynamic price;
  final dynamic discount;
  const UpdateProductItem(this.vendorproduct_id, this.vendorId, this.productId,
      this.variantId, this.price, this.discount);
}

class FetchBrand extends ProductEvent {
  const FetchBrand();
}
