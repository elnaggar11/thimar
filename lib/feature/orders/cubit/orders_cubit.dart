import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/enums.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersState());
}
