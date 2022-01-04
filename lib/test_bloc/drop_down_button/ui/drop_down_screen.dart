import 'dart:developer';

import 'package:date_time_picker/test_bloc/drop_down_button/bloc/drop_down_button_cubit.dart';
import 'package:date_time_picker/test_bloc/show_date/bloc/show_date_cubit.dart';
import 'package:date_time_picker/test_bloc/show_date/ui/show_date_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../base_string.dart';

class DropDownButton extends StatefulWidget {
  final DropDownCubit dropDownCubit;

  const DropDownButton({Key? key, required this.dropDownCubit})
      : super(key: key);

  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  void initState() {
    widget.dropDownCubit.getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE2E8F0).withOpacity(0.2),
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xff7966FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: GestureDetector(
                onTap: () {
                  widget.dropDownCubit.ontoDay();
                },
                child: const Text(
                  "Hôm nay",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff7966FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.dropDownCubit.checkToOptionBackDay(
                          widget.dropDownCubit.changeOption);
                    },
                    child: SvgPicture.asset('asset/image/ic_back.svg'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  StreamBuilder<Object>(
                      stream: widget.dropDownCubit.textDateTimeStream,
                      builder: (context, snapshot) {
                        return Text('${snapshot.data}');
                      }),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.dropDownCubit
                          .checkToOption(widget.dropDownCubit.changeOption);
                    },
                    child: SvgPicture.asset('asset/image/ic_next.svg'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: ShowDateScreen(
                onChanged: (value) {
                  widget.dropDownCubit.changeOption = value;
                },
                showDateCubit: ShowDateCubit(),
              )),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
