import 'package:consumoapi/data/http/exceptions/not_found_exception.dart';
import 'package:consumoapi/data/models/product_model.dart';
import 'package:consumoapi/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductStore {
  final IProductRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProductModel>> state =
      ValueNotifier<List<ProductModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProductStore({required this.repository});

  Future getProducts() async {
    isLoading.value = true;

    try {
      final result = await repository.getProducts();

      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
