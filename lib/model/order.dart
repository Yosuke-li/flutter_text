import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends Object {
  @JsonKey(name: 'e')
  String type;

  @JsonKey(name: 'c')

  ///业务单编码
  String code;

  @JsonKey(name: 'f')

  /// 标的期货合约
  String futureCode;

  @JsonKey(name: 'b')

  /// 现货业务
  String business;

  @JsonKey(name: 'h')

  /// 套保策略方案编码
  String hedgeSchemeCode;

  @JsonKey(name: 'p')

  /// 价格
  num price;

  @JsonKey(name: 'a')

  /// 账户
  String account;

  @JsonKey(name: 'P')

  /// 伙伴
  String partner;

  @JsonKey(name: 'Pa')

  /// 贸易伙伴
  String partnerAlias;

  @JsonKey(name: 's')

  /// 方向
  String side;

  @JsonKey(name: 'q')

  /// 点价手数
  String lots;

  @JsonKey(name: 'E')

  /// 品种唯一编码,
  String exchangeCode;

  @JsonKey(name: 'm')

  /// 现货物料
  String material;

  @JsonKey(name: 'C')

  /// 品种编码
  String productCode;

  @JsonKey(name: 'F')

  /// 已完成点价手数
  String finishLots;

  @JsonKey(name: 'w')

  /// 未点价手数
  String unLots;

  @JsonKey(name: 'u')

  /// 点价中手数
  String ingLots;

  /// 业务单名称
  @JsonKey(name: 'sc')
  String codeName;

  /// 合同号
  @JsonKey(name: 'sC')
  String contractCode;

  /// 时间
  @JsonKey(name: 't')
  num time;

  Order(
      this.type,
      this.code,
      this.account,
      this.business,
      this.productCode,
      this.exchangeCode,
      this.futureCode,
      this.hedgeSchemeCode,
      this.lots,
      this.material,
      this.partner,
      this.price,
      this.side,
      this.finishLots,
      this.ingLots,
      this.unLots, this.contractCode, this.codeName, this.partnerAlias, this.time );

  factory Order.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
