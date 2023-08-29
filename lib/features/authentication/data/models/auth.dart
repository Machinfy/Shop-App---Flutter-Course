class Auth {
  final String usedId;
  final String token;
  final DateTime expiryDate;
  final String tokenRefresher;

  Auth({
    required this.usedId,
    required this.token,
    required this.expiryDate,
    required this.tokenRefresher,
  });

  factory Auth.empty() {
    return Auth(
        usedId: '', token: '', expiryDate: DateTime.now(), tokenRefresher: '');
  }

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
        usedId: json['localId'],
        token: json['idToken'],
        expiryDate:
            DateTime.now().add(Duration(seconds: int.parse(json['expiresIn']))),
        tokenRefresher: json['refreshToken']);
  }
}
