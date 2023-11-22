import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/table_example/table_utils/interface.dart';
import 'package:flutter_text/model/order.dart';
import 'package:self_utils/utils/datetime_utils.dart';
import 'package:self_utils/widget/management/widget/common_form.dart';

class OrderApi implements TableApi<Order> {
  @override
  List<Order> allKey = [];

  @override
  List<Order> getData() {
    List<Order> res = [];
    for (int i = 0; i < 20; i++) {
      Order order = Order(
          'order',
          'code',
          'account',
          'business',
          'productCode',
          'exchangeCode',
          'futureCode',
          'hedgeSchemeCode',
          'lots',
          'material',
          'partner',
          100,
          'side',
          'finishLots',
          'ingLots',
          'unLots',
          'contractCode',
          'codeName',
          'partnerAlias',
          1672391920391);
      order.price = Random().nextInt(10000);
      order.code = '${order.code}$i';
      order.time = order.time.toInt() + Random().nextInt(10000);
      res.add(order);
    }
    return res;
  }

  @override
  void onListener(msgContent) {
    // TODO: implement onListener
  }

  @override
  List<FormColumn<Order>> setColumns() {
    return [
      FormColumn<Order>(
        key: const Key('订单'),
        comparator: (v, a, b) {
          if (v == 1) {
            return a.code.compareTo(b.code);
          } else {
            return b.code.compareTo(a.code);
          }
        },
        getGroupKey: (v) {
          return v.code;
        },
        title: const Text(
          '订单',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        width: 180,
        builder: (_, v) => Container(
          child: Text(
            v.code,
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          '完成时间',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        getGroupKey: (v) {
          return DateTimeHelper.millDatetimeFormat(
              v.time.toInt(), 'yyyy-MM-dd HH:mm:ss:SS');
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.time.compareTo(b.time);
          } else {
            return b.time.compareTo(a.time);
          }
        },
        width: 200,
        builder: (_, v) => Container(
          child: Text(
            DateTimeHelper.millDatetimeFormat(
                    v.time.toInt(), 'yyyy-MM-dd HH:mm:ss:SS') ??
                '',
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          '约定',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        getGroupKey: (v) {
          return v.futureCode;
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.futureCode.compareTo(b.futureCode);
          } else {
            return b.futureCode.compareTo(a.futureCode);
          }
        },
        width: 100,
        builder: (_, v) => Container(
          child: Text(
            v.futureCode,
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          '指向',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        width: 60,
        getGroupKey: (v) {
          return v.side;
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.side.compareTo(b.side);
          } else {
            return b.side.compareTo(a.side);
          }
        },
        builder: (_, v) => Container(
          child: Text(
            v.side,
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          '价格',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        getGroupKey: (v) {
          return '${v.price}';
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.price.compareTo(b.price);
          } else {
            return b.price.compareTo(a.price);
          }
        },
        builder: (_, v) => Container(
          child: Text(
            '${v.price}',
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          '成交量',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        getGroupKey: (v) {
          return '${v.lots}';
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.lots.compareTo(b.lots);
          } else {
            return b.lots.compareTo(a.lots);
          }
        },
        builder: (_, v) => Container(
          child: Text(
            '${v.lots}',
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          '账号',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        width: 150,
        getGroupKey: (v) {
          return v.account;
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.account.compareTo(b.account);
          } else {
            return b.account.compareTo(a.account);
          }
        },
        builder: (_, v) => Container(
          child: Text(
            v.account,
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          '伙伴',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        getGroupKey: (v) {
          return v.partner;
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.partner.compareTo(b.partner);
          } else {
            return b.partner.compareTo(a.partner);
          }
        },
        builder: (_, v) => Container(
          child: Text(
            v.partner,
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          '订单名称',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        getGroupKey: (v) {
          return v.codeName;
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.codeName.compareTo(b.codeName);
          } else {
            return b.codeName.compareTo(a.codeName);
          }
        },
        builder: (_, v) => Container(
          child: Text(
            v.codeName,
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      FormColumn<Order>(
        title: const Text(
          'ccn',
          style: TextStyle(
            fontSize: 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
        getGroupKey: (v) {
          return v.contractCode;
        },
        comparator: (v, a, b) {
          if (v == 1) {
            return a.contractCode.compareTo(b.contractCode);
          } else {
            return b.contractCode.compareTo(a.contractCode);
          }
        },
        builder: (_, v) => Container(
          child: Text(
            v.contractCode,
            style: const TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    ];
  }
}
