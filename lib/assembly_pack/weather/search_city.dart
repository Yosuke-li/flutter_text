import 'package:flutter/material.dart';
import 'package:flutter_text/api/weather.dart';
import 'package:self_utils/global/store.dart';
import 'package:flutter_text/model/weather.dart';

void main() => runApp(SearchCity());

class SearchCity extends StatefulWidget {
  @override
  SearchCityState createState() => SearchCityState();
}

class SearchCityState extends State<SearchCity> {
  TextEditingController _controller = new TextEditingController();
  bool hasData = false;
  List<Basic>? cityList;

  void setCity(String val) {
    Navigator.of(context).pop(val);
    LocateStorage.setString('lastCity', val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: _searchWidget(context),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: cityList != null
            ? ListView(
                children: cityList?.map((item) {
                  return InkWell(
                    onTap: () {
                      setCity(item.cid??'');
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      child: Text(
                          '${item.adminArea} -- ${item.parentCity} -- ${item.location}'),
                    ),
                  );
                }).toList() ?? [],
              )
            : const Center(
                child: Text('暂无数据'),
              ),
      ),
    );
  }

  Widget _searchWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _controller,
              onChanged: (String val) async {
                cityList = await WeatherApi().searchCity(val);
                setState(() {
                  hasData = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
