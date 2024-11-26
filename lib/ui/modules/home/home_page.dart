import 'package:consumoapi/data/http/http_client.dart';
import 'package:consumoapi/data/repositories/product_repository.dart';
import 'package:consumoapi/ui/modules/home/stores/product_store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductStore productStore = ProductStore(
    repository: ProductRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    productStore.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consumindo uma API',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: AnimatedBuilder(
          animation: Listenable.merge([
            productStore.isLoading,
            productStore.state,
            productStore.erro,
          ]),
          builder: (context, child) {
            if (productStore.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (productStore.erro.value.isNotEmpty) {
              return Center(
                child: Text(
                  productStore.erro.value,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (productStore.state.value.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum item na lista',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 32,
                ),
                itemCount: productStore.state.value.length,
                itemBuilder: (_, index) {
                  final item = productStore.state.value[index];
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          item.thumbnail,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'R\$ ${item.price}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              item.description,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
