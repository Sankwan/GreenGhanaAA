import 'package:dio/dio.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';

var dio = Dio();

getImages(List result) async {
  var response = await dio.get('https://fakestoreapi.com/products');
  var data = response.data;
  // logger.d(response.data);
  result = data;
}
