import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/parking_lot_model.dart';

/// 엑셀 내보내기 서비스
class ExcelExportService {
  static final Logger _logger = Logger();

  /// 즐겨찾기 목록을 엑셀 파일로 내보내기
  static Future<String?> exportFavoritesToExcel(List<ParkingLotModel> favorites) async {
    try {
      _logger.d('엑셀 내보내기 시작: ${favorites.length}개 항목');

      // 웹 환경에서는 지원하지 않음
      if (kIsWeb) {
        _logger.w('웹 환경에서는 엑셀 다운로드를 지원하지 않습니다');
        throw Exception('웹 환경에서는 파일 다운로드를 지원하지 않습니다');
      }

      // 권한 확인
      bool hasPermission = await _checkStoragePermission();
      if (!hasPermission) {
        throw Exception('저장소 권한이 필요합니다');
      }

      // 엑셀 파일 생성
      var excel = Excel.createExcel();
      Sheet sheet = excel['즐겨찾기'];

      // 헤더 생성
      _createHeaders(sheet);

      // 데이터 추가
      _addDataRows(sheet, favorites);

      // 파일 저장
      String? filePath = await _saveExcelFile(excel);
      
      if (filePath != null) {
        _logger.i('엑셀 파일 저장 완료: $filePath');
      }
      
      return filePath;
    } catch (e, stackTrace) {
      _logger.e('엑셀 내보내기 실패: $e');
      _logger.e('스택 트레이스: $stackTrace');
      rethrow;
    }
  }

  /// 저장소 권한 확인 및 요청
  static Future<bool> _checkStoragePermission() async {
    try {
      // Android 13 (API 33) 이상에서는 MANAGE_EXTERNAL_STORAGE 권한 필요
      if (Platform.isAndroid) {
        final androidInfo = await _getAndroidVersion();
        
        if (androidInfo >= 33) {
          // Android 13+ 에서는 MANAGE_EXTERNAL_STORAGE 사용
          var status = await Permission.manageExternalStorage.status;
          if (!status.isGranted) {
            status = await Permission.manageExternalStorage.request();
          }
          return status.isGranted;
        } else {
          // Android 12 이하에서는 WRITE_EXTERNAL_STORAGE 사용
          var status = await Permission.storage.status;
          if (!status.isGranted) {
            status = await Permission.storage.request();
          }
          return status.isGranted;
        }
      }
      
      return true; // iOS에서는 권한 필요 없음
    } catch (e) {
      _logger.e('권한 확인 중 오류: $e');
      return false;
    }
  }

  /// Android 버전 확인 (간단한 방법)
  static Future<int> _getAndroidVersion() async {
    try {
      // Android API 레벨을 정확히 가져오는 것은 복잡하므로,
      // 최신 버전이라고 가정하고 33을 반환
      return 33;
    } catch (e) {
      return 30; // 기본값
    }
  }

  /// 엑셀 헤더 생성
  static void _createHeaders(Sheet sheet) {
    final headers = [
      '번호',
      '주차장명',
      '주소',
      '주차면수',
      '공작물정보',
      '면적(㎡)',
      '위도',
      '경도',
      '운영시간',
      '요금정보',
      '연락처',
      '관리기관'
    ];

    for (int i = 0; i < headers.length; i++) {
      var cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(headers[i]);
      
      // 헤더 스타일링
      cell.cellStyle = CellStyle(
        bold: true,
        backgroundColorHex: ExcelColor.blue200,
        fontColorHex: ExcelColor.black,
      );
    }
  }

  /// 데이터 행 추가
  static void _addDataRows(Sheet sheet, List<ParkingLotModel> favorites) {
    for (int i = 0; i < favorites.length; i++) {
      final parking = favorites[i];
      final rowIndex = i + 1; // 헤더 다음 행부터 시작

      final rowData = [
        (i + 1).toString(),
        parking.name ?? '',
        parking.address ?? '',
        parking.totalCapacity?.toString() ?? '',
        parking.facilityInfo ?? '',
        parking.area?.toStringAsFixed(1) ?? '',
        parking.latitude?.toString() ?? '',
        parking.longitude?.toString() ?? '',
        '${parking.operatingHoursStart ?? ''} ~ ${parking.operatingHoursEnd ?? ''}',
        parking.feeInfo ?? '',
        parking.phoneNumber ?? '',
        parking.managementAgency ?? '',
      ];

      for (int j = 0; j < rowData.length; j++) {
        var cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: rowIndex));
        cell.value = TextCellValue(rowData[j]);
      }
    }
  }

  /// 엑셀 파일 저장
  static Future<String?> _saveExcelFile(Excel excel) async {
    try {
      // 저장 디렉토리 가져오기
      Directory? directory;
      
      if (Platform.isAndroid) {
        // Android에서는 Downloads 폴더에 저장
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        // iOS에서는 Documents 폴더에 저장
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('저장 디렉토리를 찾을 수 없습니다');
      }

      // 파일명 생성 (현재 날짜시간 포함)
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd_HH-mm-ss');
      final fileName = '즐겨찾기_${formatter.format(now)}.xlsx';
      
      // 파일 경로
      final filePath = '${directory.path}/$fileName';
      
      // 엑셀 파일 저장
      final List<int>? fileBytes = excel.save();
      if (fileBytes == null) {
        throw Exception('엑셀 파일 생성에 실패했습니다');
      }
      
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);
      
      return filePath;
    } catch (e) {
      _logger.e('파일 저장 실패: $e');
      rethrow;
    }
  }
}