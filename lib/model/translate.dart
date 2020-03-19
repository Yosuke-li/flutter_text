class Content {
  String form;      //原文语言
  String to;        //译文语言
  String vender;    //来源平台
  String out;       //译文
  String ciba_use;
  int err_no;       //请求成功时为 0

  Content(
      {this.form, this.ciba_use, this.err_no, this.out, this.to, this.vender});

  Content.formJson(Map<String, dynamic> json) {
    form = json['form'];
    to = json['to'];
    ciba_use = json['ciba_use'];
    err_no = json['err_no'];
    vender = json['vender'];
    out = json['out'];
  }
}
