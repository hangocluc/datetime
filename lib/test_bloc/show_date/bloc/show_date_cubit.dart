import 'package:date_time_picker/test_bloc/show_date/bloc/show_date_state.dart';

import '../../../base_cubit.dart';

class ShowDateCubit extends BaseCubit<ShowDateState> {
  ShowDateCubit() : super(ShowDateStateInitial());
  bool isCheck = false;
  List<String> listText = ["Ngày", "Tuần", "Tháng"];
  String textConten ='Ngày';

}
