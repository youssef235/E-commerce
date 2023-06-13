import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:florida_app_store/screens/products_list.dart';
import 'package:flutter/material.dart';
import 'package:florida_app_store/Constants/constants.dart';
import 'package:florida_app_store/Constants/size_config.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final List<String> items = [
    'Shirts',
    'Pants',
    'Shoes',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.87,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Select Category',
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, bottom: 8.0),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
            if (value == "Shirts") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ProductsList('SHIRT', "", '', '', '', '', 0, '', '')));
            } else if (value == "Pants") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ProductsList('PANTS', "", '', '', '', '', 0, '', '')));
            } else if (value == "Shoes") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ProductsList('SHOES', "", '', '', '', '', 0, '', '')));
            }
          },
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: 200,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for a Category...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return (item.value
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()));
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    );
  }
}
