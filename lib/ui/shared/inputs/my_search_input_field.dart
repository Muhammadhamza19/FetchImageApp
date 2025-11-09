import 'package:flutter/material.dart';
import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/ui/shared/inputs/my_input_box.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';

class MySearchInputField extends StatefulWidget {
  final Function(String)? onProductSelected; // Callback function
  final Future<List<String>> Function(String query)? fetchProducts;
  final String? labelText;
  final Color? labelColor;
  final IconData? icons;
  final Function(String)? onClickIcon;
  final TextEditingController? searchController;

  const MySearchInputField({
    super.key,
    this.onProductSelected,
    this.fetchProducts,
    this.labelText,
    this.labelColor,
    this.onClickIcon,
    this.icons,
    this.searchController,
  });

  @override
  MySearchInputFieldState createState() => MySearchInputFieldState();
}

class MySearchInputFieldState extends State<MySearchInputField> {
  List<String> filteredProducts = [];
  bool isDropdownOpen = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.searchController?.addListener(_fetchAndFilterProducts);
  }

  Future<void> _fetchAndFilterProducts() async {
    final query = widget.searchController?.text ?? "";

    if (query.isNotEmpty) {
      setState(() => isLoading = true);

      // Fetch the products based on the query
      filteredProducts = await widget.fetchProducts?.call(query) ?? [];

      setState(() {
        isDropdownOpen = filteredProducts.isNotEmpty;
        isLoading = false;
      });
    } else {
      // Clear the list and close the dropdown when input is empty
      setState(() {
        filteredProducts = [];
        isDropdownOpen = false;
      });
    }
  }

  void _selectProduct(String product) {
    widget.searchController?.text = product;
    setState(() => isDropdownOpen = false);
    FocusScope.of(context).unfocus();
    widget.onProductSelected?.call(product);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyInputBox(
          controller: widget.searchController,
          borderLabel: widget.labelText ?? "",
          icon: widget.icons ?? Icons.search,
          borderColor: widget.labelColor ?? primaryColor,
          labelColor: widget.labelColor ?? primaryColor,
          iconColor: widget.labelColor ?? primaryColor,
        ),
        if (isDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: MyText(filteredProducts[index]),
                          onTap: () => _selectProduct(filteredProducts[index]),
                        );
                      },
                    ),
                  ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    widget.searchController?.removeListener(_fetchAndFilterProducts);
    widget.searchController?.dispose();
    super.dispose();
  }
}
