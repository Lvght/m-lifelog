import 'package:http/http.dart' as http;

class GoogleAuthHelper extends http.BaseClient {
  final Map<String, String> _authHeaders;
  final _client = http.Client();

  GoogleAuthHelper(this._authHeaders);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_authHeaders));
  }
}
