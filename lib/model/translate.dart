class Content {
  String form; //原文语言
  String to; //译文语言
  String vender; //来源平台
  String out; //译文
  String ciba_use;
  int err_no; //请求成功时为 0

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

class ContentE {
  String ph_en;
  String ph_am;
  String ph_en_mp3;
  String ph_am_mp3;
  String ph_tts_mp3;
  List<dynamic> word_mean;

  ContentE(
      {this.ph_en,
      this.ph_am,
      this.ph_en_mp3,
      this.ph_am_mp3,
      this.ph_tts_mp3,
      this.word_mean});

  ContentE.formJson(Map<String, dynamic> json) {
    ph_en = json['ph_en'];
    ph_am = json['ph_am'];
    ph_en_mp3 = json['ph_en_mp3'];
    ph_am_mp3 = json['ph_am_mp3'];
    ph_tts_mp3 = json['ph_tts_mp3'];
    word_mean = json['word_mean'];
  }
}
