import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/constants/styles.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/reports/custom_liquid_indicator.dart';
import 'package:gpp_app/widgets/shadow_container.dart';
import 'package:intl/intl.dart';

class DailyReportCard extends StatefulWidget {
  final Future<DailyReport> dailyReport;
  DailyReportCard(this.dailyReport);

  @override
  State<StatefulWidget> createState() => _DailyReportCardState();
}

class _DailyReportCardState extends State<DailyReportCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: FutureBuilder(
        future: widget.dailyReport,
        builder: (BuildContext context, AsyncSnapshot<DailyReport> snapshot) {
          Widget child;

          // Future complete with data
          if (snapshot.hasData) {
            child = _getCardBody(context, snapshot.data);
            // Future complete with error
          } else if (snapshot.hasError) {
            DioError error = snapshot.error;
            if (error.response != null && error.response.statusCode == 404) {
              child = _getCardBody(context, null);
            } else {
              child = EmptyCard(
                text: '오류',
              );
            }
            // Future incomplete
          } else {
            child = WaitingCard();
          }

          return child;
        },
      ),
    );
  }
}

Widget _getCardBody(BuildContext context, DailyReport dailyReport) {
  DailyReportModel _model = DailyReportModel(dailyReport);
  return Container(
    padding: EdgeInsets.all(getBlockSizeHorizontal(5)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            height: getBlockSizeVertical(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _model.title,
                            style: Styles.accentTitle(),
                          ),
                        ],
                      ),
                      Text(
                        _model.dateString,
                        style: Styles.subtitle2(Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: getBlockSizeVertical(0.2),
                  width: getBlockSizeHorizontal(50),
                  color: Colors.grey,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.history,
                            color: Colors.grey,
                          ),
                          Text(' '),
                          Text(
                            _model.timeString,
                            style: Styles.subtitle2(Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          ),
                          Text(' '),
                          Text(
                            _model.hintString,
                            style: Styles.subtitle2(Colors.pink),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
            width: getBlockSizeHorizontal(18),
            height: getBlockSizeVertical(18),
            child: CustomLiquidIndicator(ratio: _model.ratio)),
      ],
    ),
  );
}

class DailyReportModel {
  final List<String> hintStringList = [
    '산책을 다녀오는 건 어떨까요?',
    '혼내면 안돼요! 더 격려해주세요.',
    '잘하고 있어요! 끝까지 으쌰으쌰!',
    '기특해요! 간식을 주는건 어떨까요?',
  ];
  DailyReportModel(DailyReport dailyReport) {
    dateString = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());
    if (dailyReport != null) {
      title =
          '${dailyReport.success.toString()}회 / ${dailyReport.count.toString()}회';
      timeString = '${dailyReport.lastModifiedDate}';
      ratio = dailyReport.ratio;
    } else {
      title = '배변 기록 없음';
      timeString = '--:--:--';
      ratio = -0.1; // disable
    }
    hintString = getHintString(ratio);
    // TEST
    assert(title != null);
    assert(dateString != null);
    assert(timeString != null);
    assert(hintString != null);
    assert(ratio != null);
  }
  String title;
  String dateString;
  String timeString;
  String hintString;
  double ratio;

  String getHintString(double ratio) {
    if (ratio < 0.0) {
      return hintStringList[0];
    } else if (ratio < 0.3) {
      return hintStringList[1];
    } else if (ratio < 0.6) {
      return hintStringList[2];
    } else {
      return hintStringList[3];
    }
  }
}
