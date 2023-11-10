part of 'product_bloc.dart';

abstract class ProductState {
  ProductState();
}

class ProductInitial extends ProductState {}

class ProductLoadedState extends ProductState {
  ProductModel? productList;
  ProductLoadedState(this.productList);
}

class ProductVariantLoadedState extends ProductState {
  ProductVarientModel? productVariantList;
  ProductVariantLoadedState(this.productVariantList);
}

class ErrorState extends ProductState {
  String error;
  ErrorState(this.error);
}

class ProductVariantLoadingState extends ProductState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddProductVariantLoadedState extends ProductState {
  AddProductVarientModel? productVariantList;
  AddProductVariantLoadedState(this.productVariantList);
}

class ProductVariantItemLoadedState extends ProductState {
  ProductDetailsModel? productItemList;
  ProductVariantItemLoadedState(this.productItemList);
}

class UpdateProductItemLoadedState extends ProductState {
  UpdateProductItemModel? productItemList;
  UpdateProductItemLoadedState(this.productItemList);
}

class BrandLoadedState extends ProductState {
  BrandModel? brandData;
  BrandLoadedState(this.brandData);
}
