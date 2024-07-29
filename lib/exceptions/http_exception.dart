class HttpException implements Exception {
  const HttpException(this.msg);
  
  final String msg;

  @override
  String toString() {
    return msg;
  }
}
