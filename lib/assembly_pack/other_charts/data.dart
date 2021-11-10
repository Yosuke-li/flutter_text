class ChartsData {
  String date;
  double profit;
  double totalProfit;

  ChartsData({this.date, this.profit, this.totalProfit});

  String toString() {
    return 'ChartsData[date=$date, profit=$profit, totalProfit=$totalProfit]';
  }

  ChartsData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    profit = json['profit'];
    totalProfit = json['totalProfit'];
  }

  static List<ChartsData> listFromJson(List<dynamic> json) {
    return json == null
        ? <ChartsData>[]
        : json.map((e) => ChartsData.fromJson(e)).toList();
  }
}

 Map<String, List<Map<String, dynamic>>> profit = {
  'data': [{
    'date': '2021-05-10',
    'profit': 580.0000,
    'totalProfit': 580.0000
  }, {
    'date': '2021-05-11',
    'profit': 200.0000,
    'totalProfit': 780.0000
  }, {
    'date': '2021-05-12',
    'profit': 4295.0000,
    'totalProfit': 5075.0000
  }, {
    'date': '2021-05-18',
    'profit': 1270.0000,
    'totalProfit': 6345.0000
  }, {
    'date': '2021-05-19',
    'profit': -1110.0000,
    'totalProfit': 5235.0000
  }, {
    'date': '2021-05-20',
    'profit': 700.0000,
    'totalProfit': 5935.0000
  }, {
    'date': '2021-05-21',
    'profit': 2950.0000,
    'totalProfit': 8885.0000
  }, {
    'date': '2021-05-25',
    'profit': 975.0000,
    'totalProfit': 9860.0000
  }, {
    'date': '2021-05-26',
    'profit': 3745.0000,
    'totalProfit': 13605.0000
  }, {
    'date': '2021-05-27',
    'profit': 135.0000,
    'totalProfit': 13740.0000
  }, {
    'date': '2021-05-28',
    'profit': 1050.0000,
    'totalProfit': 14790.0000
  }, {
    'date': '2021-05-31',
    'profit': 200.0000,
    'totalProfit': 14990.0000
  }, {
    'date': '2021-06-02',
    'profit': -2500.0000,
    'totalProfit': 12490.0000
  }, {
    'date': '2021-06-10',
    'profit': 1530.0000,
    'totalProfit': 14020.0000
  }, {
    'date': '2021-06-15',
    'profit': 2085.0000,
    'totalProfit': 16105.0000
  }, {
    'date': '2021-06-16',
    'profit': 830.0000,
    'totalProfit': 16935.0000
  }, {
    'date': '2021-06-17',
    'profit': -1355.0000,
    'totalProfit': 15580.0000
  }, {
    'date': '2021-06-18',
    'profit': 1000.0000,
    'totalProfit': 16580.0000
  }, {
    'date': '2021-06-21',
    'profit': 170.0000,
    'totalProfit': 16750.0000
  }, {
    'date': '2021-06-22',
    'profit': 500.0000,
    'totalProfit': 17250.0000
  }, {
    'date': '2021-06-24',
    'profit': 420.0000,
    'totalProfit': 17670.0000
  }, {
    'date': '2021-06-25',
    'profit': 10.0000,
    'totalProfit': 17680.0000
  }, {
    'date': '2021-06-28',
    'profit': -955.0000,
    'totalProfit': 16725.0000
  }, {
    'date': '2021-06-29',
    'profit': -40.0000,
    'totalProfit': 16685.0000
  }, {
    'date': '2021-06-30',
    'profit': -3670.0000,
    'totalProfit': 13015.0000
  }],
};