import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

void main() async {
  // desktop용 FFI 초기화
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    print('🔧 누락된 테이블 수정 시작...');

    // 데이터베이스 경로 확인
    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, 'parking_finder.db');

    print('📍 데이터베이스 경로: $dbPath');

    final dbFile = File(dbPath);
    if (!await dbFile.exists()) {
      print('❌ 데이터베이스 파일이 존재하지 않습니다!');
      return;
    }

    final db = await openDatabase(dbPath);

    // 1. bjdongs 테이블이 존재하는지 확인
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table'",
    );
    final tableNames = tables.map((table) => table['name'] as String).toList();
    print('📋 기존 테이블: $tableNames');

    if (!tableNames.contains('bjdongs')) {
      print('🔨 bjdongs 테이블 생성 중...');

      // bjdongs 테이블 생성
      await db.execute('''
        CREATE TABLE bjdongs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          sigungu_code TEXT NOT NULL,
          bjdong_name TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          FOREIGN KEY (sigungu_code) REFERENCES regions (sigungu_code)
        );
      ''');

      // 인덱스 생성
      await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_bjdongs_sigungu_code ON bjdongs(sigungu_code);',
      );

      print('✅ bjdongs 테이블 생성 완료');
    } else {
      print('ℹ️ bjdongs 테이블이 이미 존재합니다');
    }

    // 2. bjdongs 테이블에 데이터가 있는지 확인
    final bjdongCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM bjdongs',
    );
    final currentCount = bjdongCount.first['count'] as int;
    print('📊 현재 bjdongs 레코드 수: $currentCount개');

    if (currentCount == 0) {
      print('📥 bjdongs 데이터 생성 중...');

      // 기존 regions 테이블에서 시군구 목록 가져오기
      final regions = await db.query('regions');
      print('🏛️ 처리할 지역 수: ${regions.length}개');

      await db.transaction((txn) async {
        int id = 1;

        for (final region in regions) {
          final sigunguCode = region['sigungu_code'] as String;
          final sigunguName = region['sigungu_name'] as String;
          final province = region['province'] as String;

          // 각 시군구에 대해 기본 읍면동 생성
          List<String> defaultBjdongs = [];

          if (province == '서울특별시' && sigunguName != '서울특별시') {
            // 서울 각 구에 대한 기본 동
            defaultBjdongs = _getSeoulDefaultBjdongs(sigunguName);
          } else if (sigunguName.endsWith('시') ||
              sigunguName.endsWith('군') ||
              sigunguName.endsWith('구')) {
            // 일반 시군구에 대한 기본 읍면동
            defaultBjdongs = _getDefaultBjdongs(sigunguName);
          }

          for (final bjdong in defaultBjdongs) {
            await txn.insert('bjdongs', {
              'id': id++,
              'sigungu_code': sigunguCode,
              'bjdong_name': bjdong,
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            });
          }
        }
      });

      final newCount = await db.rawQuery(
        'SELECT COUNT(*) as count FROM bjdongs',
      );
      final totalCount = newCount.first['count'] as int;
      print('✅ bjdongs 데이터 생성 완료: $totalCount개');
    }

    // 3. 테스트: 서울 종로구 읍면동 확인
    print('\n🔍 테스트: 서울 종로구 읍면동 확인');
    final jongnoTest = await db.query(
      'bjdongs',
      where: 'sigungu_code = ?',
      whereArgs: ['11110'],
      limit: 5,
    );

    for (final row in jongnoTest) {
      print('  ${row['bjdong_name']}');
    }

    await db.close();
    print('\n✅ 테이블 수정 완료');
  } catch (e) {
    print('❌ 테이블 수정 실패: $e');
  }
}

/// 서울 각 구의 기본 동 목록
List<String> _getSeoulDefaultBjdongs(String sigunguName) {
  switch (sigunguName) {
    case '종로구':
      return [
        '청운효자동',
        '사직동',
        '삼청동',
        '부암동',
        '평창동',
        '무악동',
        '교남동',
        '가회동',
        '종로1.2.3.4가동',
        '종로5.6가동',
        '이화동',
        '혜화동',
        '명륜3가동',
        '창신1동',
        '창신2동',
        '창신3동',
        '숭인1동',
        '숭인2동',
      ];
    case '중구':
      return [
        '소공동',
        '회현동',
        '명동',
        '필동',
        '장충동',
        '광희동',
        '을지로동',
        '신당동',
        '다산동',
        '약수동',
        '청구동',
        '신당5동',
        '동화동',
        '황학동',
        '중림동',
      ];
    case '용산구':
      return [
        '후암동',
        '용산2가동',
        '남영동',
        '청파동',
        '원효로1동',
        '원효로2동',
        '효창동',
        '용문동',
        '한강로동',
        '이촌1동',
        '이촌2동',
        '이태원1동',
        '이태원2동',
        '한남동',
        '보광동',
        '서빙고동',
      ];
    case '성동구':
      return [
        '왕십리제2동',
        '왕십리도선동',
        '마장동',
        '사근동',
        '행당1동',
        '행당2동',
        '응봉동',
        '금호1가동',
        '금호2.3가동',
        '금호4가동',
        '옥수동',
        '성수1가제1동',
        '성수1가제2동',
        '성수2가1동',
        '성수2가3동',
        '송정동',
        '용답동',
      ];
    default:
      return ['${sigunguName}동'];
  }
}

/// 일반 시군구의 기본 읍면동 목록
List<String> _getDefaultBjdongs(String sigunguName) {
  if (sigunguName.endsWith('시')) {
    return [
      '${sigunguName.replaceAll('시', '')}동',
      '중앙동',
      '북동',
      '남동',
      '동부동',
      '서부동',
    ];
  } else if (sigunguName.endsWith('군')) {
    return [
      '${sigunguName.replaceAll('군', '')}읍',
      '중앙면',
      '북면',
      '남면',
      '동면',
      '서면',
    ];
  } else if (sigunguName.endsWith('구')) {
    return ['${sigunguName.replaceAll('구', '')}동', '중앙동', '제1동', '제2동', '제3동'];
  }
  return ['중앙동'];
}
