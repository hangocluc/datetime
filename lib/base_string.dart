import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'form_edit.dart';

class HomePage extends StatefulWidget {
  final Function(String) onChanged;

  const HomePage({Key? key, required this.onChanged}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isCheck = false;
  List<String> listText = ["Ngày", "Tuần", "Tháng"];
  String textConten = '';
  GlobalKey globalKey = GlobalKey();
  double x = 0.0;
  double y = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textConten = listText[0];
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
          width: 72,
          height: 32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: const Color(0xffE2E8F0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 6, child: FormEdit(textConten)),
              Expanded(
                  flex: 4,
                  child: isCheck
                      ? IconButton(
                          icon: SvgPicture.asset('asset/image/ic_next.svg'),
                          onPressed: () {},
                        )
                      : IconButton(
                          onPressed: () {
                            _showMyDialog(getposition());
                            // setState(() {
                            //   isCheck = !isCheck;
                            //   getposition();
                            // });
                            setState(() {
                              isCheck = true;
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

  // Widget viewList() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(6), color: Colors.red),
  //     width: 100,
  //     height: 150,
  //     child: ListView.builder(
  //         itemCount: listText.length,
  //         itemBuilder: (context, index) {
  //           return GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 textConten = listText[index];
  //               });
  //             },
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                     padding: const EdgeInsets.all(8),
  //                     child: Text(
  //                       listText[index],
  //                       style: const TextStyle(fontSize: 14),
  //                     )),
  //                 Container(
  //                   width: 100,
  //                   height: 1,
  //                   color: Colors.black,
  //                 )
  //               ],
  //             ),
  //           );
  //         }),
  //   );
  // }

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
              isCheck = false;
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
                                    textConten = listText[index];
                                  });
                                  Navigator.pop(context);
                                  isCheck = false;
                                  widget.onChanged(textConten);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(listText[index])),
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
