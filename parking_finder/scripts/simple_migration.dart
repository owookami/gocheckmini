import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;

void main() async {
  print('🚀 간단한 데이터베이스 마이그레이션 시작');

  // FFI 초기화
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    // 데이터베이스 파일 경로
    final dbPath = path.join('assets', 'data', 'parking_finder.db');

    // 디렉토리 생성
    final dir = Directory(path.dirname(dbPath));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    // 기존 데이터베이스 삭제
    final dbFile = File(dbPath);
    if (await dbFile.exists()) {
      await dbFile.delete();
      print('🗑️ 기존 데이터베이스 삭제');
    }

    // 데이터베이스 열기
    final db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        // regions 테이블 생성
        await db.execute('''
          CREATE TABLE regions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            unified_code INTEGER,
            sigungu_code TEXT NOT NULL,
            sigungu_name TEXT NOT NULL,
            is_autonomous_district INTEGER DEFAULT 0,
            province TEXT,
            city TEXT,
            created_at TEXT,
            updated_at TEXT
          )
        ''');
        print('✅ regions 테이블 생성 완료');
      },
    );

    // sigungu.txt 파일 읽기
    print('📖 sigungu.txt 파일 읽기 중...');
    final file = File('scripts/sigungu.txt');
    final lines = await file.readAsLines();
    print('✅ 파일 읽기 완료: ${lines.length}줄');

    // 데이터 파싱 및 삽입
    int insertedCount = 0;
    int id = 1;

    await db.transaction((txn) async {
      for (int i = 0; i < lines.length; i++) {
        final line = lines[i].trim();

        // 헤더나 빈 줄 건너뛰기
        if (line.isEmpty ||
            line.startsWith('통합분류코드') ||
            line.contains('국토교통부')) {
          continue;
        }

        try {
          // 공백으로 구분된 데이터 파싱
          final parts = line.split(RegExp(r'\s+'));

          if (parts.length >= 4) {
            final unifiedCode = int.tryParse(parts[0]) ?? 0;
            final sigunguCode = parts[1];
            final sigunguName = parts[2];
            final autonomousDistrict = parts[3];

            // 시도와 시/군/구 분리
            String province = '';
            String city = '';

            if (sigunguName.contains('서울특별시')) {
              province = '서울특별시';
              city = sigunguName.replaceAll('서울특별시', '').trim();
            } else if (sigunguName.contains('부산광역시')) {
              province = '부산광역시';
              city = sigunguName.replaceAll('부산광역시', '').trim();
            } else if (sigunguName.contains('대구광역시')) {
              province = '대구광역시';
              city = sigunguName.replaceAll('대구광역시', '').trim();
            } else if (sigunguName.contains('인천광역시')) {
              province = '인천광역시';
              city = sigunguName.replaceAll('인천광역시', '').trim();
            } else if (sigunguName.contains('광주광역시')) {
              province = '광주광역시';
              city = sigunguName.replaceAll('광주광역시', '').trim();
            } else if (sigunguName.contains('대전광역시')) {
              province = '대전광역시';
              city = sigunguName.replaceAll('대전광역시', '').trim();
            } else if (sigunguName.contains('울산광역시')) {
              province = '울산광역시';
              city = sigunguName.replaceAll('울산광역시', '').trim();
            } else if (sigunguName.contains('세종특별자치시')) {
              province = '세종특별자치시';
              city = sigunguName.replaceAll('세종특별자치시', '').trim();
            } else if (sigunguName.contains('경기도')) {
              province = '경기도';
              city = sigunguName.replaceAll('경기도', '').trim();
            } else if (sigunguName.contains('강원')) {
              province = '강원특별자치도';
              city = sigunguName.replaceAll('강원', '').trim();
            } else if (sigunguName.contains('충청북도')) {
              province = '충청북도';
              city = sigunguName.replaceAll('충청북도', '').trim();
            } else if (sigunguName.contains('충청남도')) {
              province = '충청남도';
              city = sigunguName.replaceAll('충청남도', '').trim();
            } else if (sigunguName.contains('전북특별자치도')) {
              province = '전북특별자치도';
              city = sigunguName.replaceAll('전북특별자치도', '').trim();
            } else if (sigunguName.contains('전라남도')) {
              province = '전라남도';
              city = sigunguName.replaceAll('전라남도', '').trim();
            } else if (sigunguName.contains('경상북도')) {
              province = '경상북도';
              city = sigunguName.replaceAll('경상북도', '').trim();
            } else if (sigunguName.contains('경상남도')) {
              province = '경상남도';
              city = sigunguName.replaceAll('경상남도', '').trim();
            } else if (sigunguName.contains('제주특별자치도')) {
              province = '제주특별자치도';
              city = sigunguName.replaceAll('제주특별자치도', '').trim();
            } else {
              // 시도명이 포함되지 않은 경우 시군구코드로 유추
              if (sigunguCode.startsWith('11')) {
                province = '서울특별시';
                city = sigunguName;
              } else if (sigunguCode.startsWith('26')) {
                province = '부산광역시';
                city = sigunguName;
              } else if (sigunguCode.startsWith('27')) {
                province = '대구광역시';
                city = sigunguName;
              } else if (sigunguCode.startsWith('28')) {
                province = '인천광역시';
                city = sigunguName;
              } else if (sigunguCode.startsWith('29')) {
                province = '광주광역시';
                city = sigunguName;
              } else if (sigunguCode.startsWith('30')) {
                province = '대전광역시';
                city = sigunguName;
              } else if (sigunguCode.startsWith('31')) {
                province = '울산광역시';
                city = sigunguName;
              } else if (sigunguCode.startsWith('36')) {
                province = '세종특별자치시';
                city = sigunguName;
              } else if (sigunguCode.startsWith('41')) {
                province = '경기도';
                city = sigunguName;
              } else if (sigunguCode.startsWith('42')) {
                province = '강원특별자치도';
                city = sigunguName;
              } else if (sigunguCode.startsWith('43')) {
                province = '충청북도';
                city = sigunguName;
              } else if (sigunguCode.startsWith('44')) {
                province = '충청남도';
                city = sigunguName;
              } else if (sigunguCode.startsWith('45')) {
                province = '전북특별자치도';
                city = sigunguName;
              } else if (sigunguCode.startsWith('46')) {
                province = '전라남도';
                city = sigunguName;
              } else if (sigunguCode.startsWith('47')) {
                province = '경상북도';
                city = sigunguName;
              } else if (sigunguCode.startsWith('48')) {
                province = '경상남도';
                city = sigunguName;
              } else if (sigunguCode.startsWith('50')) {
                province = '제주특별자치도';
                city = sigunguName;
              } else {
                province = '기타';
                city = sigunguName;
              }
            }

            // 빈 city는 province 이름 사용
            if (city.isEmpty) {
              city = province;
            }

            await txn.insert('regions', {
              'id': id++,
              'unified_code': unifiedCode,
              'sigungu_code': sigunguCode,
              'sigungu_name': sigunguName,
              'is_autonomous_district': autonomousDistrict == '해당' ? 1 : 0,
              'province': province,
              'city': city,
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            });

            insertedCount++;
          }
        } catch (e) {
          print('라인 파싱 실패 (${i + 1}번째 줄): $line - $e');
        }
      }
    });

    // 결과 확인
    final count = await db.rawQuery('SELECT COUNT(*) as count FROM regions');
    final totalCount = count.first['count'] as int;

    print('✅ 데이터 삽입 완료: $insertedCount개');
    print('✅ 총 레코드 수: $totalCount개');

    // 시도별 통계
    final provinces = await db.rawQuery('''
      SELECT province, COUNT(*) as count 
      FROM regions 
      GROUP BY province 
      ORDER BY count DESC
    ''');

    print('\n📊 시도별 통계:');
    for (final row in provinces) {
      print('  ${row['province']}: ${row['count']}개');
    }

    await db.close();
    print('\n🎉 마이그레이션 완료! 데이터베이스 파일: $dbPath');
  } catch (e, stackTrace) {
    print('❌ 마이그레이션 실패: $e');
    print('스택 트레이스: $stackTrace');
  }
}
