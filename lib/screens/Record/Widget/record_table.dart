import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_project/controllers/record_controller.dart';
import 'package:petcare_project/utils/constant.dart';

class RecordTable extends StatelessWidget {
  const RecordTable({
    Key? key,
    required this.size,
    required this.indexSelect,
  }) : super(key: key);

  final Size size;
  final String indexSelect;

  @override
  Widget build(BuildContext context) {
    final RecordController _recordController = Get.find<RecordController>();
    print('xxxxxxxxxxx: ${indexSelect.toString()}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
      child: Container(
        width: size.width,
        height: size.height * 0.45,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
              stream: _recordController
                  .getRecordByName(
                    indexSelect.toString(),
                  )
                  .asStream(),
              builder: (context, snapshot) {
                return DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        'รายการ',
                        style: GoogleFonts.mitr(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ค่าใช้จ่าย',
                        style: GoogleFonts.mitr(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'วันเวลา',
                        style: GoogleFonts.mitr(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                  rows: _recordController.recordDataId
                      .map(
                        (record) => DataRow(cells: [
                          DataCell(Text(
                            '${record['particular']}',
                            style: GoogleFonts.mitr(
                              fontSize: 14,
                            ),
                          )),
                          DataCell(Text(
                            '${record['pay']}',
                            style: GoogleFonts.mitr(
                              fontSize: 14,
                            ),
                          )),
                          DataCell(
                            Text(
                              '${record['date']}'.toString().substring(0, 10),
                              style: GoogleFonts.mitr(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ]),
                      )
                      .toList(),
                );
              }),
        ),
      ),
    );
  }
}
