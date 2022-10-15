abstract class RequestService {

  Future httpGet(String token, String url);

  Future httpPost(String token, String url, String body);

  Future httpPostForLogin(String token, String url, String body);

  Future httpUpdate(String token, String url, String body);

  Future httpDelete(String token, String url, String body);
}