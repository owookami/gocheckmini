import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;
import '../lib/core/database/database_helper.dart';
import '../lib/core/database/database_schema.dart';

void main() async {
  print('🚀 강제 데이터베이스 마이그레이션 시작');

  // FFI 초기화 (데스크톱 환경용)
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    // 1. 데이터베이스 초기화
    print('📂 데이터베이스 초기화 중...');
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;
    print('✅ 데이터베이스 연결 성공');

    // 2. 기존 데이터 삭제
    print('🗑️ 기존 지역 데이터 삭제 중...');
    await db.delete(DatabaseSchema.regionsTable);
    print('✅ 기존 데이터 삭제 완료');

    // 3. sigungu.txt 파일 읽기
    print('📖 sigungu.txt 파일 읽기 중...');
    final file = File('scripts/sigungu.txt');

    if (!await file.exists()) {
      print('❌ sigungu.txt 파일을 찾을 수 없습니다.');
      return;
    }

    final lines = await file.readAsLines();
    print('📄 총 ${lines.length}줄 읽음');

    // 4. 데이터 파싱 및 삽입
    print('🔄 데이터 파싱 및 삽입 중...');
    int insertedCount = 0;
    final batch = db.batch();

    for (int i = 1; i < lines.length; i++) {
      // 첫 줄은 헤더이므로 스킵
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      try {
        final parts = line.split(' ');
        if (parts.length >= 4) {
          final unifiedCode = int.parse(parts[0]);
          final sigunguCode = parts[1];
          final sigunguName = parts.skip(2).take(parts.length - 3).join(' ');
          final isAutonomousString = parts.last;

          // 시도 정보 파싱
          final regionInfo = _parseRegionInfo(sigunguName);

          final data = {
            'unified_code': unifiedCode,
            'sigungu_code': sigunguCode,
            'sigungu_name': sigunguName,
            'is_autonomous_district': isAutonomousString == '해당' ? 1 : 0,
            'province': regionInfo['province'],
            'city': regionInfo['city'],
            'district': regionInfo['district'],
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          };

          batch.insert(
            DatabaseSchema.regionsTable,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          insertedCount++;
        }
      } catch (e) {
        print('⚠️ 라인 파싱 오류 ($i): $line - $e');
        continue;
      }
    }

    // 배치 실행
    await batch.commit(noResult: true);
    print('✅ 데이터 삽입 완료: ${insertedCount}개');

    // 5. 결과 검증
    print('\n📊 마이그레이션 결과 검증:');
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable}',
    );
    final totalCount = countResult.first['count'] as int;
    print('  - 총 지역 수: $totalCount');

    // 주요 지역 확인
    final seoulCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable} WHERE province = ?',
      ['서울특별시'],
    );
    final seoulTotal = seoulCount.first['count'] as int;
    print('  - 서울특별시: $seoulTotal');

    final gyeonggiCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable} WHERE province = ?',
      ['경기도'],
    );
    final gyeonggiTotal = gyeonggiCount.first['count'] as int;
    print('  - 경기도: $gyeonggiTotal');

    // 6. 시도 목록 확인
    print('\n🗺️ 시도별 분포:');
    final provinces = await db.rawQuery(
      'SELECT province, COUNT(*) as count FROM ${DatabaseSchema.regionsTable} WHERE province IS NOT NULL GROUP BY province ORDER BY count DESC',
    );

    for (final province in provinces) {
      print('  - ${province['province']}: ${province['count']}개');
    }

    print('\n🎉 강제 마이그레이션 완료!');
  } catch (e, stackTrace) {
    print('❌ 마이그레이션 실패: $e');
    print('스택 트레이스: $stackTrace');
  }
}

/// 지역명에서 시도, 시, 구/군 정보 파싱
Map<String, String?> _parseRegionInfo(String sigunguName) {
  String? province;
  String? city;
  String? district;

  if (sigunguName.contains('서울특별시')) {
    province = '서울특별시';
    if (sigunguName.length > 5) {
      district = sigunguName.replaceAll('서울특별시 ', '');
    }
  } else if (sigunguName.contains('부산광역시')) {
    province = '부산광역시';
    if (sigunguName.length > 5) {
      district = sigunguName.replaceAll('부산광역시 ', '');
    }
  } else if (sigunguName.contains('대구광역시')) {
    province = '대구광역시';
    if (sigunguName.length > 5) {
      district = sigunguName.replaceAll('대구광역시 ', '');
    }
  } else if (sigunguName.contains('인천광역시')) {
    province = '인천광역시';
    if (sigunguName.length > 5) {
      district = sigunguName.replaceAll('인천광역시 ', '');
    }
  } else if (sigunguName.contains('광주광역시')) {
    province = '광주광역시';
    if (sigunguName.length > 5) {
      district = sigunguName.replaceAll('광주광역시 ', '');
    }
  } else if (sigunguName.contains('대전광역시')) {
    province = '대전광역시';
    if (sigunguName.length > 5) {
      district = sigunguName.replaceAll('대전광역시 ', '');
    }
  } else if (sigunguName.contains('울산광역시')) {
    province = '울산광역시';
    if (sigunguName.length > 5) {
      district = sigunguName.replaceAll('울산광역시 ', '');
    }
  } else if (sigunguName.contains('세종특별자치시')) {
    province = '세종특별자치시';
  } else if (sigunguName.contains('경기도')) {
    province = '경기도';
    final cityPart = sigunguName.replaceAll('경기도 ', '');
    if (cityPart.contains('시')) {
      city = cityPart;
    } else if (cityPart.contains('군')) {
      district = cityPart;
    }
  } else if (sigunguName.contains('충청북도')) {
    province = '충청북도';
    final cityPart = sigunguName.replaceAll('충청북도 ', '');
    if (cityPart.contains('시')) {
      city = cityPart;
    } else if (cityPart.contains('군')) {
      district = cityPart;
    }
  } else if (sigunguName.contains('충청남도')) {
    province = '충청남도';
    final cityPart = sigunguName.replaceAll('충청남도 ', '');
    if (cityPart.contains('시')) {
      city = cityPart;
    } else if (cityPart.contains('군')) {
      district = cityPart;
    }
  } else if (sigunguName.contains('전라북도')) {
    province = '전라북도';
    final cityPart = sigunguName.replaceAll('전라북도 ', '');
    if (cityPart.contains('시')) {
      city = cityPart;
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
    } else if (cityPart.contains('군')) {
      district = cityPart;
    }
  } else if (sigunguName.contains('경상남도')) {
    province = '경상남도';
    final cityPart = sigunguName.replaceAll('경상남도 ', '');
    if (cityPart.contains('시')) {
      city = cityPart;
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
