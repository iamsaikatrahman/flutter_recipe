import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_meal/controller/api_data.dart';
import 'package:flutter_meal/controller/recipe.dart';
import 'package:flutter_meal/widget/common_widget.dart';
import 'package:flutter_meal/widget/filter.dart';
import 'package:flutter_meal/widget/textsearch_widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  Map searchFilterMap;
  List allProductResults = [];
  List productResultList = [];
  Future productResultsLoaded;

  @override
  void initState() {
    searchFilterData();
    searchController.addListener(_onProductSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    isSearch = true;
    searchController.removeListener(_onProductSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productResultsLoaded = searchFilterData();
  }

  _onProductSearchChanged() {
    searchProductsResultsList();
  }

  searchProductsResultsList() {
    var showResult = [];
    if (searchController.text != "") {
      for (var productfromjson in allProductResults) {
        var productName = Recipe.fromJson(productfromjson).title.toLowerCase();
        if (productName.contains(searchController.text.toLowerCase())) {
          showResult.add(productfromjson);
        }
      }
    } else {
      showResult = List.from(allProductResults);
    }
    productResultList = showResult;
  }

  Future searchFilterData() async {
    http.Response response;
    String url = ApiData.searchfilter;
    response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        searchFilterMap = json.decode(response.body);

        allProductResults = searchFilterMap['meals'];
      });
      searchProductsResultsList();
      return "Complete";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF7FCFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      headerTitle("Search", false),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<dynamic>(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(35.0),
                                  topRight: const Radius.circular(35.0),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext bc) {
                                return Container(
                                  height: 600,
                                  padding: EdgeInsets.only(top: 20),
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(35.0),
                                      topRight: const Radius.circular(35.0),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            height: 5,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            children: [
                                              Filter(
                                                filterName: "c",
                                                filterCardName:
                                                    "Filter By Category",
                                                isCountry: false,
                                              ),
                                              SizedBox(height: 10),
                                              Filter(
                                                filterName: "a",
                                                filterCardName:
                                                    "Filter By Country",
                                                isCountry: true,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: filterButton(),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        isSearch = true;
                        searchController;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search your dish...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (isSearch)
                      ? (searchFilterMap == null)
                          ? Container()
                          : TextSearchWidget(
                              productResultList: productResultList,
                            )
                      : initialSearchScreen(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
