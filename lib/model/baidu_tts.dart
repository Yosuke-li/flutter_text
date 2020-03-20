class Token {
  String access_token;
  String session_key;
  String scope;
  String refresh_token;
  String session_secret;
  int exprires_in;

  Token(
      {this.access_token,
      this.exprires_in,
      this.refresh_token,
      this.scope,
      this.session_key,
      this.session_secret});

  Token.formJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    exprires_in = json['exprires_in'];
    refresh_token = json['refresh_token'];
    scope = json['scope'];
    session_secret = json['session_secret'];
    session_key = json['session_key'];
  }
}
