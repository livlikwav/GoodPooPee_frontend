import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/constants/styles.dart';
import 'package:gpp_app/models/json/daily_report.dart';
import 'package:gpp_app/widgets/empty_card.dart';
import 'package:gpp_app/screens/report/components/waiting_card.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/reports/custom_liquid_indicator.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class DailyReportCard extends StatefulWidget {
  final Future<DailyReport> dailyReport;
  DailyReportCard(this.dailyReport);

  @override
  State<StatefulWidget> createState() => _DailyReportCardState();
}

class _DailyReportCardState extends State<DailyReportCard> {
  // Avoid crush of layout whenever screen re-build
  double _boxRadius;
  @override
  void initState() {
    _boxRadius = getBlockSizeHorizontal(5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_boxRadius),
        color: AppColors.backgroundColor,
      ),
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 3,
              offset: Offset(2, 2),
            ),
          ],
          color: Colors.white,
        ),
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
                        style: Styles.subtitle(Colors.black),
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
                            style: Styles.subtitle(Colors.grey),
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
                            style: Styles.subtitle(Colors.pink),
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
  DailyReportModel(DailyReport dailyReport) {
    dateString = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());
    if (dailyReport != null) {
      title =
          '${dailyReport.success.toString()}회 / ${dailyReport.count.toString()}회';
      timeString = '${dailyReport.lastModifiedDate}';
      hintString = '아직 준비가 안됐어요.';
      ratio = dailyReport.ratio;
    } else {
      title = '배변 기록 없음';
      timeString = '--:--:--';
      hintString = '산책을 다녀오는 건 어떨까요?';
      ratio = -0.1; // disable
    }
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
}
