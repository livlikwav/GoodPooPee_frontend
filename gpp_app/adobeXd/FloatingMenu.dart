import 'package:flutter/material.dart';
import '../lib/TrainReport.dart';
import '../lib/Settings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloatingMenu extends StatelessWidget {
  FloatingMenu({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2699fb),
      body: Stack(
        children: <Widget>[
          // Adobe XD layer: 'Menu' (group)
          Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(34.0, 365.3),
                child:
                    // Adobe XD layer: 'menu' (group)
                    Stack(
                  children: <Widget>[
                    // Adobe XD layer: '내 푸피캠 확인하기' (group)
                    Stack(
                      children: <Widget>[
                        Transform.translate(
                          offset: Offset(39.0, -27.3),
                          child: SizedBox(
                            width: 152.0,
                            child: Text(
                              '내 푸피캠 확인하기',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 17,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                height: 2.823529411764706,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(0.0, 32.0),
                      child:
                          // Adobe XD layer: '배변 기록 확인하기' (group)
                          Stack(
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(39.0, 20.7),
                            child: SizedBox(
                              width: 152.0,
                              child: Text(
                                '배변 기록 확인하기',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 17,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  height: 2.823529411764706,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, 32.0),
                      child:
                          // Adobe XD layer: '클리커 훈련하기' (group)
                          Stack(
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(51.0, 68.7),
                            child: SizedBox(
                              width: 128.0,
                              child: Text(
                                '클리커 훈련하기',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 17,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  height: 2.823529411764706,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, -11.0),
                      child:
                          // Adobe XD layer: '배변훈련 리포트' (group)
                          Stack(
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(51.0, 164.7),
                            child: SizedBox(
                              width: 128.0,
                              child: Text(
                                '배변훈련 리포트',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 17,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  height: 2.823529411764706,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, -53.0),
                      child:
                          // Adobe XD layer: '기기 및 환경설정' (group)
                          Stack(
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(48.0, 308.7),
                            child: SizedBox(
                              width: 134.0,
                              child: Text(
                                '기기 및 환경설정',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 17,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  height: 2.823529411764706,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Adobe XD layer: 'Profile' (group)
              Stack(
                children: <Widget>[
                  Container(
                    width: 298.0,
                    height: 132.0,
                    decoration: BoxDecoration(
                      color: const Color(0xffbce0fd),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0.0, 13.0),
                    child: Stack(
                      children: <Widget>[
                        Transform.translate(
                          offset: Offset(129.0, 19.84),
                          child:
                              // Adobe XD layer: 'avatar' (group)
                              Stack(
                            children: <Widget>[
                              Transform.translate(
                                offset: Offset(0.0, 0.16),
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(20.0, 20.0)),
                                    color: const Color(0xff2699fb),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(12.5, 11.26),
                                child: SvgPicture.string(
                                  _svg_5ebdci,
                                  allowDrawingOutsideViewBox: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(117.0, 67.98),
                          child:
                              // Adobe XD layer: 'name' (group)
                              Stack(
                            children: <Widget>[
                              Transform.translate(
                                offset: Offset(0.0, -2.98),
                                child: Text(
                                  'User_ID',
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 17,
                                    color: const Color(0xff2699fb),
                                    fontWeight: FontWeight.w700,
                                    height: 1.411764705882353,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(2.0, 113.0),
                child:
                    // Adobe XD layer: '반려견' (group)
                    Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(106.0, 168.0),
                      child:
                          // Adobe XD layer: 'name' (group)
                          Stack(
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(15.0, -5.0),
                            child: SizedBox(
                              width: 52.0,
                              child: Text(
                                '포동이',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 17,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  height: 1.411764705882353,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(-27.0, 10.0),
                            child: SizedBox(
                              width: 136.0,
                              child: Text(
                                '요크셔테리어, 수컷, 7살',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 12,
                                  color: const Color(0xffffffff),
                                  height: 2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(113.0, 84.0),
                      child: SvgPicture.string(
                        _svg_xx9l7i,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(101.0, 26.0),
                      child: Text(
                        '우리집 굿푸피',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 17,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 2.823529411764706,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(19.5, 406.5),
            child: SvgPicture.string(
              _svg_guq5vk,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(34.0, 360.3),
            child:
                // Adobe XD layer: '기기 및 환경설정' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(81.0, 308.7),
                  child: SizedBox(
                    width: 68.0,
                    child: Text(
                      '로그아웃',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        height: 2.823529411764706,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_5ebdci =
    '<svg viewBox="12.5 11.3 15.0 15.0" ><path transform="translate(12.5, 11.26)" d="M 0 15 L 0 13.12521362304688 C 0 11.06228637695312 3.374957799911499 9.374755859375 7.5 9.374755859375 C 11.62504100799561 9.374755859375 15 11.06228637695312 15 13.12521362304688 L 15 15 L 0 15 Z M 3.749578237533569 3.750457763671875 C 3.749578237533569 1.6790771484375 5.428619384765625 0 7.5 0 C 9.570536613464355 0 11.24957847595215 1.6790771484375 11.24957847595215 3.750457763671875 C 11.24957847595215 5.8209228515625 9.570536613464355 7.500030517578125 7.5 7.500030517578125 C 5.428619384765625 7.500030517578125 3.749578237533569 5.8209228515625 3.749578237533569 3.750457763671875 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xx9l7i =
    '<svg viewBox="113.0 84.0 68.0 67.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="960.0" height="640.0"><image xlink:href="null" x="0" y="0" width="960.0" height="640.0" /></pattern></defs><path transform="translate(113.0, 84.0)" d="M 34 0 C 52.77767944335938 0 68 14.99846076965332 68 33.5 C 68 52.00154113769531 52.77767944335938 67 34 67 C 15.22231864929199 67 0 52.00154113769531 0 33.5 C 0 14.99846076965332 15.22231864929199 0 34 0 Z" fill="url(#image)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_guq5vk =
    '<svg viewBox="19.5 406.5 260.0 203.0" ><path transform="translate(19.5, 406.5)" d="M 0 0 L 260 0" fill="none" stroke="#ffffff" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(19.5, 609.5)" d="M 0 0 L 260 0" fill="none" stroke="#ffffff" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
