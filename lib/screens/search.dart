import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final FocusNode _searchFocusNode;
  final TextEditingController _searchController;

  SearchWidget(this._searchFocusNode, this._searchController, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(24.0),
      ),
      margin: EdgeInsets.only(bottom: 10),
      height: 50.0,
      width: 300,
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.black,
        ),
        child: LimitedBox(
          maxHeight: 30,
          child: TextField(
            
            controller: _searchController,
            focusNode: _searchFocusNode,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 13.0,
                fontFamily: "Roboto",
                //color: darkText.withOpacity(darkText.opacity * 0.5)
              ),
              prefixIcon: Icon(Icons.search),
              suffixIcon: _searchFocusNode.hasFocus
                  ? IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _searchFocusNode.unfocus();
                        _searchController.clear();
                      })
                  : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue)),
              contentPadding: EdgeInsets.all(20),
            ),
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: "Roboto",
              //color: darkText.withOpacity(darkText.opacity),
            ),
          ),
        ),
      ),
    );
  }
}
