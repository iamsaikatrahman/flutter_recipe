import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meal/controller/api_data.dart';
import 'package:flutter_meal/views/filter_Search.dart';
import 'package:http/http.dart' as http;

class Filter extends StatefulWidget {
  const Filter({
    Key key,
    @required this.filterName,
    @required this.filterCardName,
    @required this.isCountry,
  }) : super(key: key);

  final String filterName;
  final String filterCardName;
  final bool isCountry;

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  Map filteralldatamap;
  List filteralldata;

  Future filtercategory() async {
    http.Response response;
    String url = ApiData.filterAllCategories + widget.filterName + "=list";

    response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        filteralldatamap = json.decode(response.body);
        filteralldata = filteralldatamap['meals'];
      });
    }
  }

  @override
  void initState() {
    filtercategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (filteralldatamap == null)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.filterCardName,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "ConcertOne",
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteralldata.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (widget.isCountry)
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FilterSearch(
                                    titelname: filteralldata[index]['strArea'],
                                    isforCountry: true,
                                  ),
                                ),
                              );
                            }
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FilterSearch(
                                    titelname: filteralldata[index]
                                        ['strCategory'],
                                    isforCountry: false,
                                  ),
                                ),
                              );
                            },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 1,
                              spreadRadius: -1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: (widget.isCountry)
                              ? Center(
                                  child: (filteralldata[index]['strArea'] == '')
                                      ? Container()
                                      : Text(
                                          filteralldata[index]['strArea'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "ConcertOne",
                                          ),
                                        ),
                                )
                              : Center(
                                  child: (filteralldata[index]['strCategory'] ==
                                          '')
                                      ? Container()
                                      : Text(
                                          filteralldata[index]['strCategory'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "ConcertOne",
                                          ),
                                        ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
