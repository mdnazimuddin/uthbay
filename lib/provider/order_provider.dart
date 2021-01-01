import 'package:Uthbay/models/order.dart';
import 'package:Uthbay/models/order_model.dart';
import 'package:Uthbay/services/api_service.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  APIService _apiService;

  List<OrderModel> _orderList;
  List<OrderModel> get allOrders => _orderList;
  double get totalRecords => _orderList.length.toDouble();

  Order _order;
  Order get order => _order;

  OrderProvider() {
    resetStreams();
  }
  void resetStreams() {
    _apiService = APIService();
  }

  fetchOrders(String groceryId) async {
    List<OrderModel> orderList = await _apiService.getOrders(groceryId);

    if (_orderList == null) {
      _orderList = new List<OrderModel>();
    }

    if (orderList.length > 0) {
      _orderList = [];
      _orderList.addAll(orderList);
    }

    notifyListeners();
  }

  fetchOrder(int orderId) async {
    if (_order == null) {
      _order = new Order();
    }

    _order = await _apiService.getOrder(orderId);

    notifyListeners();
  }
}
