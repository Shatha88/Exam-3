class ApiALl with AuthEndpoint, ConstApi, UserEndpoint {}

mixin ConstApi {
  String url = "0.0.0.0:8080";
}

mixin AuthEndpoint {
  String createAccount = "/auth/create";
  String loginAccount = "/auth/login";
}

mixin UserEndpoint {
  String createOrder = "/user/create_order";
  String readAll = '/user/get_orders';
  String readID = '/user/read_order/';
}
