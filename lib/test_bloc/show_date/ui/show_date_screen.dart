import 'package:date_time_picker/test_bloc/show_date/bloc/show_date_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../form_edit.dart';

class ShowDateScreen extends StatefulWidget {
  final Function(String) onChanged;
  final ShowDateCubit showDateCubit;

  const ShowDateScreen(
      {Key? key, required this.onChanged, required this.showDateCubit})
      : super(key: key);

  @override
  _ShowDateScreenState createState() => _ShowDateScreenState();
}

class _ShowDateScreenState extends State<ShowDateScreen> {
  GlobalKey globalKey = GlobalKey();
  double x = 0.0;
  double y = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Offset getposition() {
    RenderBox box = globalKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //thi

    setState(() {
      x = position.dx;
      y = position.dy;
    });
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          key: globalKey,
          width: 190,
          height: 32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: const Color(0xffE2E8F0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 7, child: FormEdit(widget.showDateCubit.textConten)),
              Expanded(
                  flex: 4,
                  child: widget.showDateCubit.isCheck
                      ? RotatedBox(
                          quarterTurns: 2,
                          child: IconButton(
                            icon: SvgPicture.asset(
                                'asset/image/ic_dropdown_down.svg'),
                            onPressed: () {},
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            _showMyDialog(getposition());
                            setState(() {
                              widget.showDateCubit.isCheck = true;
                            });
                          },
                          icon: SvgPicture.asset(
                              'asset/image/ic_dropdown_down.svg'),
                        )),
            ],
          ),
        ),
        // Container(
        //     padding: const EdgeInsets.only(top: 8),
        //     child: isCheck ? viewList() : Container())
      ],
    );
  }

  _showMyDialog(Offset position) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent, // user must tap button!
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              widget.showDateCubit.isCheck = false;
            });
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned(
                    top: position.dy + 10,
                    right: 10,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(
                              width: 1, color: const Color(0xffE2E8F0))),
                      child: Column(
                        children: List.generate(
                            3,
                            (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.showDateCubit.textConten =
                                        widget.showDateCubit.listText[index];
                                  });
                                  Navigator.pop(context);
                                  widget.showDateCubit.isCheck = false;
                                  widget.onChanged(
                                      widget.showDateCubit.textConten);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(widget
                                            .showDateCubit.listText[index])),
                                    index == 2
                                        ? Container()
                                        : Container(
                                            height: 1,
                                            color: const Color(0xffE2E8F0),
                                          )
                                  ],
                                ))),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
