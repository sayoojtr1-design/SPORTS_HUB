import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        controller: widget.controller,
        onChanged: (value){
          setState(() {
            widget.onChanged(value);
          });
        },
        decoration: InputDecoration(
          hintText: "Find your Products..",
          prefixIcon: Icon(Icons.search),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(onPressed: (){
            widget.controller.clear();
            widget.onChanged("products");
            setState(() {

            });
          }, icon: Icon(Icons.close))
              : null,
          filled:  true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}