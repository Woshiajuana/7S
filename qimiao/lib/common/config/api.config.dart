

class Api {

  static final Api _api = Api._internal();

  factory Api () {
    return _api;
  }

  Api._internal();

  // 登录
  String get doUserLogin {
    return 'https://ddapi.doujiusm.com/v1.0/user/login';
  }

  // 授权登录
  String get doAuthLogin {
    return 'app/auth/login';
  }

  // 商品首页推荐
  String get reqReqHotRecommend {
    return 'app/goods/recommend-goods';
  }

  // 商品列表
  String get reqGoodsList {
    return 'app/goods/list';
  }

  // 商品详情
  String get reqGoodsDetails {
    return 'app/goods/query';
  }

  // 商品状态是否购买
  String get reqGoodsStatus {
    return 'app/goods/check-goods';
  }

  // 商品下单
  String get doOrderCreate {
    return 'app/trade/order/create';
  }

  // 商品订单列表
  String get reqOrderList {
    return 'app/trade/order/list';
  }

  // 商品订单详情
  String get reqOrderDetails {
    return 'app/trade/order/query';
  }

  // 商品订单删除
  String get doOrderDelete {
    return 'app/trade/order/delete';
  }

  // 用户信息
  String get reqUserInfo {
    return 'app/user/info';
  }

  // 地址列表
  String get reqAddressList {
    return 'app/address/list';
  }

  // 收货地址修改
  String get doAddressUpdate {
    return 'app/address/update';
  }

  // 收货地址新增
  String get doAddressAdd {
    return 'app/address/add';
  }

  // 收货地址详情
  String get reqAddressDetails {
    return 'app/address/query';
  }

  // 收货地址删除
  String get doAddressDelete {
    return 'app/address/delete';
  }

  // 收货地址设为默认
  String get doAddressSetDefault {
    return 'app/address/set-default';
  }
  
}