import 'package:get/state_manager.dart';
import 'package:ocean_blue/models/orders.dart';

class OrderController extends GetxController {
  List<Orders> orders = [];

  void updateOrders(List<Orders> array) {
    orders = array;
    update();
  }
}
