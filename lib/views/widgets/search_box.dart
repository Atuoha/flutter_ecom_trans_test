import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color.dart';
import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    required this.searchText,
  }) : super(key: key);

  final TextEditingController searchText;

  void handleSearch() {
    print(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchText,
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: GestureDetector(
          onTap: () => handleSearch,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(AssetManager.search, color:greyFontColor),
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: greyShade),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: greyShade),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: greyShade),
        ),
      ),
    );
  }
}
