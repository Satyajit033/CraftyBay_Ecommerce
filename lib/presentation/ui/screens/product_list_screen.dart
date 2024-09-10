import 'package:ecommerce_1/data/models/product_model.dart';
import 'package:ecommerce_1/presentation/state_holders/product_list_controller.dart';
import 'package:ecommerce_1/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductListScreen extends StatefulWidget {
  final int ? categoryId;
  final ProductModel ? productModel;

  const ProductListScreen({super.key, this.categoryId, this.productModel});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.categoryId!=null){
        Get.find<ProductListController>().getProductsByCategory(widget.categoryId!);
      }else if(widget.productModel!=null){
        Get.find<ProductListController>().setProducts(widget.productModel!);
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Product List",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        shadowColor: Colors.white54,        //leading: B(child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,), // Different icon for back button
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<ProductListController>(
        builder: (productListController) {
          if(productListController.getProductListInProgress){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(productListController.productModel.data?.isEmpty ?? true){
            return const Center(
              child: Text("Empty List",style: TextStyle(
                fontSize: 22
              ),),
            );
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: GridView.builder(
              itemCount: productListController.productModel.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 8
                ),
                itemBuilder: (context, index) {
                  return  FittedBox(
                      child: ProductCard(
                        product: productListController.productModel.data![index],
                      )
                  );
                }),
          );
        }
      ),
    );
  }
}
