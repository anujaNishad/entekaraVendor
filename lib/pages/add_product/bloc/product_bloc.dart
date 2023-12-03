import 'package:entekaravendor/model/AddProductVariantModel.dart';
import 'package:entekaravendor/model/advertisement_model.dart';
import 'package:entekaravendor/model/delete_product_model.dart';
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
    on<FetchFilterProduct>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        ProductModel? productFilterList =
            await _productRepository.fetchFilterProduct(event.vendorId,
                event.search, event.categoryIds, event.brandIds);
        emit(ProductLoadedState(productFilterList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<FetchFilterProductVariant>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        ProductDetailsModel? productFilterList =
            await _productRepository.fetchFilterProductVariant(event.vendorId,
                event.search, event.categoryIds, event.brandIds);
        emit(ProductVariantItemLoadedState(productFilterList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<DeleteProductVariant>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        DeleteProductModel? productFilterList = await _productRepository
            .deleteProductVariantItem(event.productId, event.vendorId);
        emit(DeleteProductVariantLoadedState(productFilterList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<FetchAdvertisement>((event, emit) async {
      try {
        emit(ProductVariantLoadingState());
        List<AdvertisementModel> advList =
            await _productRepository.getAdvertisement();
        emit(AdvertisementLoadedState(advList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
