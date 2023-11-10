import 'package:entekaravendor/model/AddProductVariantModel.dart';
import 'package:entekaravendor/model/brand_model.dart';
import 'package:entekaravendor/model/productVarientModel.dart';
import 'package:entekaravendor/model/product_model.dart';
import 'package:entekaravendor/model/productdetails_model.dart';
import 'package:entekaravendor/model/updateproductitem_model.dart';
import 'package:entekaravendor/pages/add_product/data/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository = ProductRepository();
  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        ProductModel productList = await _productRepository.getProductDetails(
            event.vendorId, event.search);
        emit(ProductLoadedState(productList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<FetchProductVariant>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        ProductVarientModel? productList =
            await _productRepository.getProductVariant(event.productId);
        emit(ProductVariantLoadedState(productList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<AddProductVariant>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        AddProductVarientModel? productList =
            await _productRepository.addProductVariant(event.vendorId,
                event.productId, event.variantId, event.price, event.discount);
        emit(AddProductVariantLoadedState(productList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<FetchProductItem>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        ProductDetailsModel productItemList = await _productRepository
            .getProductItem(event.vendorId, event.search);
        emit(ProductVariantItemLoadedState(productItemList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<UpdateProductItem>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        UpdateProductItemModel? productList =
            await _productRepository.updateProductItem(
                event.vendorproduct_id,
                event.vendorId,
                event.productId,
                event.variantId,
                event.price,
                event.discount);
        emit(UpdateProductItemLoadedState(productList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<FetchBrand>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        BrandModel? brandList = await _productRepository.getBrandDetails();
        emit(BrandLoadedState(brandList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
