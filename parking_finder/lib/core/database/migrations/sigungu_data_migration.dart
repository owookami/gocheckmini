import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';
import '../database_schema.dart';

/// sigungu.txt 파일 기반 지역 데이터 마이그레이션
/// 완전히 새로운 데이터베이스 구조로 재설계됨
class SigunguDataMigration {
  static const String _sigunguDataPath = 'scripts/sigungu.txt';

  /// 지역 데이터 마이그레이션 실행
  static Future<bool> migrate(DatabaseHelper dbHelper) async {
    try {
      print('🚀 sigungu.txt 기반 지역 데이터 마이그레이션 시작');

      // 기존 데이터 삭제
      await _clearExistingData(dbHelper);

      // sigungu.txt 파일 읽기 및 파싱
      final regionData = await _parseSigunguFile();

      if (regionData.isEmpty) {
        print('❌ sigungu.txt 파일에서 유효한 데이터를 찾을 수 없습니다.');
        return false;
      }

      print('📊 총 ${regionData.length}개의 지역 데이터 발견');

      // 배치 삽입 실행
      await _batchInsertRegions(dbHelper, regionData);

      // 삽입 결과 검증
      final insertedCount = await _verifyMigration(dbHelper);

      print('✅ 지역 데이터 마이그레이션 완료: ${insertedCount}개 삽입');
      return insertedCount > 0;
    } catch (e, stackTrace) {
      print('❌ 지역 데이터 마이그레이션 실패: $e');
      print('스택 트레이스: $stackTrace');
      return false;
    }
  }

  /// 기존 데이터 삭제
  static Future<void> _clearExistingData(DatabaseHelper dbHelper) async {
    final db = await dbHelper.database;
    await db.delete(DatabaseSchema.regionsTable);
    print('🗑️ 기존 지역 데이터 삭제 완료');
  }

  /// sigungu.txt 파일 파싱
  static Future<List<Map<String, dynamic>>> _parseSigunguFile() async {
    final regionData = <Map<String, dynamic>>[];

    try {
      // 프로젝트 루트에서 파일 읽기 시도
      final projectRoot = await _findProjectRoot();
      final sigunguFile = File(path.join(projectRoot, _sigunguDataPath));

      if (!await sigunguFile.exists()) {
        print('❌ sigungu.txt 파일을 찾을 수 없습니다: ${sigunguFile.path}');
        return regionData;
      }

      final lines = await sigunguFile.readAsLines();
      print('📄 sigungu.txt 파일 로드 완료: ${lines.length}줄');

      // 헤더 스킵 (첫 번째 줄)
      for (int i = 1; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;

        final parsedData = _parseRegionLine(line, i + 1);
        if (parsedData != null) {
          regionData.add(parsedData);
        }
      }

      print('✅ ${regionData.length}개의 지역 데이터 파싱 완료');
      return regionData;
    } catch (e) {
      print('❌ sigungu.txt 파일 파싱 실패: $e');
      return regionData;
    }
  }

  /// 프로젝트 루트 디렉토리 찾기
  static Future<String> _findProjectRoot() async {
    var current = Directory.current;

    // pubspec.yaml이 있는 디렉토리가 프로젝트 루트
    while (current.path != current.parent.path) {
      final pubspecFile = File(path.join(current.path, 'pubspec.yaml'));
      if (await pubspecFile.exists()) {
        // parking_finder 디렉토리인지 확인
        if (current.path.endsWith('parking_finder')) {
          return current.parent.path; // 상위 디렉토리 반환
        }
        return current.path;
      }
      current = current.parent;
    }

    // 기본값으로 현재 디렉토리의 상위 디렉토리 반환
    return Directory.current.parent.path;
  }

  /// 지역 라인 파싱
  static Map<String, dynamic>? _parseRegionLine(String line, int lineNumber) {
    try {
      final parts = line.split(' ');

      if (parts.length < 4) {
        print('⚠️ 라인 $lineNumber: 필드 부족 - $line');
        return null;
      }

      final unifiedCode = int.parse(parts[0]);
      final sigunguCode = parts[1];
      final sigunguName = parts[2];
      final autonomousFlag = parts[3];

      // 지역명에서 도/시/구 추출
      final regionInfo = _extractRegionInfo(sigunguName);

      return {
        'unified_code': unifiedCode,
        'sigungu_code': sigunguCode,
        'sigungu_name': sigunguName,
        'is_autonomous_district': autonomousFlag == '해당' ? 1 : 0,
        'province': regionInfo['province'],
        'city': regionInfo['city'],
        'district': regionInfo['district'],
      };
    } catch (e) {
      print('⚠️ 라인 $lineNumber 파싱 오류: $line - $e');
      return null;
    }
  }

  /// 지역명에서 도/시/구 정보 추출
  static Map<String, String?> _extractRegionInfo(String sigunguName) {
    String? province;
    String? city;
    String? district;

    if (sigunguName.contains('서울특별시')) {
      province = '서울특별시';
      if (sigunguName.contains('구')) {
        district = sigunguName.replaceAll('서울특별시 ', '');
      }
    } else if (sigunguName.contains('부산광역시')) {
      province = '부산광역시';
      if (sigunguName.contains('구')) {
        district = sigunguName.replaceAll('부산광역시 ', '');
      } else if (sigunguName.contains('군')) {
        district = sigunguName.replaceAll('부산광역시 ', '');
      }
    } else if (sigunguName.contains('대구광역시')) {
      province = '대구광역시';
      if (sigunguName.contains('구')) {
        district = sigunguName.replaceAll('대구광역시 ', '');
      } else if (sigunguName.contains('군')) {
        district = sigunguName.replaceAll('대구광역시 ', '');
      }
    } else if (sigunguName.contains('인천광역시')) {
      province = '인천광역시';
      if (sigunguName.contains('구')) {
        district = sigunguName.replaceAll('인천광역시 ', '');
      } else if (sigunguName.contains('군')) {
        district = sigunguName.replaceAll('인천광역시 ', '');
      }
    } else if (sigunguName.contains('광주광역시')) {
      province = '광주광역시';
      if (sigunguName.contains('구')) {
        district = sigunguName.replaceAll('광주광역시 ', '');
      }
    } else if (sigunguName.contains('대전광역시')) {
      province = '대전광역시';
      if (sigunguName.contains('구')) {
        district = sigunguName.replaceAll('대전광역시 ', '');
      }
    } else if (sigunguName.contains('울산광역시')) {
      province = '울산광역시';
      if (sigunguName.contains('구')) {
        district = sigunguName.replaceAll('울산광역시 ', '');
      } else if (sigunguName.contains('군')) {
        district = sigunguName.replaceAll('울산광역시 ', '');
      }
    } else if (sigunguName.contains('세종특별자치시')) {
      province = '세종특별자치시';
    } else if (sigunguName.contains('경기도')) {
      province = '경기도';
      final cityPart = sigunguName.replaceAll('경기도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
        if (cityPart.contains(' ')) {
          final parts = cityPart.split(' ');
          city = parts[0];
          if (parts.length > 1) {
            district = parts[1];
          }
        }
      } else if (cityPart.contains('군')) {
        district = cityPart;
      }
    } else if (sigunguName.contains('충청북도')) {
      province = '충청북도';
      final cityPart = sigunguName.replaceAll('충청북도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
        if (cityPart.contains(' ')) {
          final parts = cityPart.split(' ');
          city = parts[0];
          if (parts.length > 1) {
            district = parts[1];
          }
        }
      } else if (cityPart.contains('군')) {
        district = cityPart;
      }
    } else if (sigunguName.contains('충청남도')) {
      province = '충청남도';
      final cityPart = sigunguName.replaceAll('충청남도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
        if (cityPart.contains(' ')) {
          final parts = cityPart.split(' ');
          city = parts[0];
          if (parts.length > 1) {
            district = parts[1];
          }
        }
      } else if (cityPart.contains('군')) {
        district = cityPart;
      }
    } else if (sigunguName.contains('전라북도')) {
      province = '전라북도';
      final cityPart = sigunguName.replaceAll('전라북도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
        if (cityPart.contains(' ')) {
          final parts = cityPart.split(' ');
          city = parts[0];
          if (parts.length > 1) {
            district = parts[1];
          }
        }
      } else if (cityPart.contains('군')) {
        district = cityPart;
      }
    } else if (sigunguName.contains('전라남도')) {
      province = '전라남도';
      final cityPart = sigunguName.replaceAll('전라남도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
      } else if (cityPart.contains('군')) {
        district = cityPart;
      }
    } else if (sigunguName.contains('경상북도')) {
      province = '경상북도';
      final cityPart = sigunguName.replaceAll('경상북도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
        if (cityPart.contains(' ')) {
          final parts = cityPart.split(' ');
          city = parts[0];
          if (parts.length > 1) {
            district = parts[1];
          }
        }
      } else if (cityPart.contains('군')) {
        district = cityPart;
      }
    } else if (sigunguName.contains('경상남도')) {
      province = '경상남도';
      final cityPart = sigunguName.replaceAll('경상남도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
        if (cityPart.contains(' ')) {
          final parts = cityPart.split(' ');
          city = parts[0];
          if (parts.length > 1) {
            district = parts[1];
          }
        }
      } else if (cityPart.contains('군')) {
        district = cityPart;
      }
    } else if (sigunguName.contains('제주특별자치도')) {
      province = '제주특별자치도';
      final cityPart = sigunguName.replaceAll('제주특별자치도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
      }
    } else if (sigunguName.contains('강원도')) {
      province = '강원도';
      final cityPart = sigunguName.replaceAll('강원도 ', '');
      if (cityPart.contains('시')) {
        city = cityPart;
      } else if (cityPart.contains('군')) {
        district = cityPart;
      }
    }

    return {'province': province, 'city': city, 'district': district};
  }

  /// 배치 삽입 실행
  static Future<void> _batchInsertRegions(
    DatabaseHelper dbHelper,
    List<Map<String, dynamic>> regionData,
  ) async {
    final db = await dbHelper.database;
    final batch = db.batch();

    // 배치 크기 설정 (1000개씩 처리)
    const batchSize = 1000;
    int processedCount = 0;

    for (int i = 0; i < regionData.length; i += batchSize) {
      final endIndex =
          (i + batchSize < regionData.length)
              ? i + batchSize
              : regionData.length;

      final batchData = regionData.sublist(i, endIndex);

      for (final data in batchData) {
        batch.insert(
          DatabaseSchema.regionsTable,
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
      processedCount += batchData.length;

      print('📝 배치 처리 중... ${processedCount}/${regionData.length}');
    }

    print('✅ 모든 지역 데이터 배치 삽입 완료: ${processedCount}개');
  }

  /// 마이그레이션 결과 검증
  static Future<int> _verifyMigration(DatabaseHelper dbHelper) async {
    final db = await dbHelper.database;

    // 총 개수 확인
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable}',
    );
    final totalCount = countResult.first['count'] as int;

    // 주요 지역 데이터 확인
    final seoulCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable} WHERE province = ?',
      ['서울특별시'],
    );
    final seoulTotal = seoulCount.first['count'] as int;

    final gyeonggiCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable} WHERE province = ?',
      ['경기도'],
    );
    final gyeonggiTotal = gyeonggiCount.first['count'] as int;

    print('📊 마이그레이션 검증 결과:');
    print('   - 총 지역 수: $totalCount');
    print('   - 서울특별시: $seoulTotal');
    print('   - 경기도: $gyeonggiTotal');

    return totalCount;
  }

  /// 특정 지역 검색
  static Future<Map<String, dynamic>?> findRegionByCode(
    DatabaseHelper dbHelper,
    String sigunguCode,
  ) async {
    final db = await dbHelper.database;
    final results = await db.query(
      DatabaseSchema.regionsTable,
      where: 'sigungu_code = ?',
      whereArgs: [sigunguCode],
      limit: 1,
    );

    return results.isNotEmpty ? results.first : null;
  }

  /// 도/시별 지역 목록 조회
  static Future<List<Map<String, dynamic>>> getRegionsByProvince(
    DatabaseHelper dbHelper,
    String province,
  ) async {
    final db = await dbHelper.database;
    return await db.query(
      DatabaseSchema.regionsTable,
      where: 'province = ?',
      whereArgs: [province],
      orderBy: 'sigungu_name',
    );
  }
}
