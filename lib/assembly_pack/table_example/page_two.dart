import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/model/order.dart';
import 'package:self_utils/widget/management/widget/common_form.dart';

import 'table_utils/interface.dart';
import 'table_utils/order_api.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  List<Order> values = [];
  List<FormColumn<Order>> columns = [];

  late TableApi<Order> api;

  @override
  void initState() {
    init();
    initColumns();
    super.initState();
    _onListener();
  }

  void initColumns({List<FormColumn<Order>>? value}) {
    if (value == null || value.isEmpty) {
      columns = api.setColumns();
    } else {
      columns = value;
    }
    setState(() {});
  }

  void init() {
    api = OrderApi();
    values = api.getData();
    setState(() {});
  }

  /// todo 消息监听
  void _onListener() {

  }

  @override
  Widget build(BuildContext context) {
    return GroupCommonForm<Order>(
      canDrag: true,
      titleColor: Setting.tableBarColor,
      height: 300,
      onDragTitleFunc: (List<FormColumn<Order>> columns) {
        initColumns(value: columns);
      },
      columns: columns,
      values: values,
    );
  }
}
