import 'package:e_commerce/core/data/network/network_config.dart';

class EndPointProduct {
  static final String product = NetworkConfig.getFullApiRout('v2/product');

  static final String productbyCategory = NetworkConfig.getFullApiRout(
    'v2/product/byCategory',
  );
  static final String createProduct = NetworkConfig.getFullApiRout(
    'v2/user/product',
  );
}
