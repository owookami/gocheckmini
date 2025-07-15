import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import '../models/parking_lot_model.dart';
import 'parking_search_service.dart';
import '../../domain/entities/parking_lot.dart';

/// 전체 주차장 데이터 SQLite 관리 서비스
class ParkingDatabaseService {
  static final Logger _logger = Logger();
  static Database? _database;
  
  /// 데이터베이스 인스턴스 가져오기
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// 데이터베이스 초기화
  static Future<Database> _initDatabase() async {
    if (kIsWeb) {
      throw Exception('웹에서는 SQLite를 지원하지 않습니다');
    }

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'parking_finder.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
      onUpgrade: _upgradeDatabase,
    );
  }

  /// 테이블 생성
  static Future<void> _createTables(Database db, int version) async {
    // 일반 주차장 테이블
    await db.execute('''
      CREATE TABLE general_parking_lots (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        address TEXT,
        total_capacity INTEGER,
        available_spots INTEGER,
        latitude REAL,
        longitude REAL,
        operating_hours_start TEXT,
        operating_hours_end TEXT,
        fee_info TEXT,
        phone_number TEXT,
        management_agency TEXT,
        type TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');

    // 부설 주차장 테이블
    await db.execute('''
      CREATE TABLE attached_parking_lots (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        address TEXT,
        total_capacity INTEGER,
        available_spots INTEGER,
        latitude REAL,
        longitude REAL,
        operating_hours_start TEXT,
        operating_hours_end TEXT,
        fee_info TEXT,
        phone_number TEXT,
        management_agency TEXT,
        type TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');

    // 데이터 동기화 정보 테이블
    await db.execute('''
      CREATE TABLE sync_info (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        table_name TEXT UNIQUE,
        last_sync_at TEXT,
        total_records INTEGER,
        status TEXT
      )
    ''');

    _logger.i('데이터베이스 테이블 생성 완료');
  }

  /// 데이터베이스 업그레이드
  static Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    _logger.i('데이터베이스 업그레이드: $oldVersion -> $newVersion');
    // 필요시 마이그레이션 로직 추가
  }

  /// 전체 일반 주차장 데이터 다운로드 및 저장
  static Future<void> downloadAndSaveGeneralParkingLots() async {
    try {
      _logger.i('일반 주차장 전체 데이터 다운로드 시작');
      
      final db = await database;
      final parkingService = ParkingSearchService();
      
      // 기존 데이터 삭제
      await db.delete('general_parking_lots');
      
      int totalSaved = 0;
      
      // 모든 시군구 코드에 대해 검색 (임시로 주요 지역만)
      final majorRegions = [
        {'sigunguCd': '11110', 'bjdongCd': ''}, // 서울 종로구
        {'sigunguCd': '11140', 'bjdongCd': ''}, // 서울 중구
        {'sigunguCd': '11170', 'bjdongCd': ''}, // 서울 용산구
        {'sigunguCd': '11200', 'bjdongCd': ''}, // 서울 성동구
        {'sigunguCd': '11215', 'bjdongCd': ''}, // 서울 광진구
        // 더 많은 지역 코드 추가 가능
      ];
      
      for (final region in majorRegions) {
        try {
          _logger.d('일반 주차장 데이터 요청 중: ${region['sigunguCd']}');
          
          final parkingLots = await parkingService.searchParking(
            sigunguCode: region['sigunguCd']!,
            bjdongCode: region['bjdongCd']!,
            searchType: ParkingSearchType.general,
          );

          if (parkingLots.isNotEmpty) {
            // 배치 insert
            await _batchInsertGeneralParkingLots(db, parkingLots);
            totalSaved += parkingLots.length;
            
            _logger.d('일반 주차장 데이터 저장 진행: $totalSaved개 저장됨');
          }
          
          // API 호출 제한을 위한 잠시 대기
          await Future.delayed(const Duration(milliseconds: 1000));
        } catch (e) {
          _logger.w('지역 ${region['sigunguCd']} 데이터 수집 실패: $e');
          continue;
        }
      }

      // 동기화 정보 저장
      await _updateSyncInfo(db, 'general_parking_lots', totalSaved, 'completed');
      
      _logger.i('일반 주차장 전체 데이터 저장 완료: $totalSaved개');
    } catch (e, stackTrace) {
      _logger.e('일반 주차장 데이터 저장 실패: $e');
      _logger.e('스택 트레이스: $stackTrace');
      
      // 실패 정보 저장
      final db = await database;
      await _updateSyncInfo(db, 'general_parking_lots', 0, 'failed');
      rethrow;
    }
  }

  /// 전체 부설 주차장 데이터 다운로드 및 저장
  static Future<void> downloadAndSaveAttachedParkingLots() async {
    try {
      _logger.i('부설 주차장 전체 데이터 다운로드 시작');
      
      final db = await database;
      final parkingService = ParkingSearchService();
      
      // 기존 데이터 삭제
      await db.delete('attached_parking_lots');
      
      int totalSaved = 0;
      
      // 모든 시군구 코드에 대해 검색 (임시로 주요 지역만)
      final majorRegions = [
        {'sigunguCd': '11110', 'bjdongCd': ''}, // 서울 종로구
        {'sigunguCd': '11140', 'bjdongCd': ''}, // 서울 중구
        {'sigunguCd': '11170', 'bjdongCd': ''}, // 서울 용산구
        {'sigunguCd': '11200', 'bjdongCd': ''}, // 서울 성동구
        {'sigunguCd': '11215', 'bjdongCd': ''}, // 서울 광진구
      ];
      
      for (final region in majorRegions) {
        try {
          _logger.d('부설 주차장 데이터 요청 중: ${region['sigunguCd']}');
          
          final parkingLots = await parkingService.searchParking(
            sigunguCode: region['sigunguCd']!,
            bjdongCode: region['bjdongCd']!,
            searchType: ParkingSearchType.attached,
          );

          if (parkingLots.isNotEmpty) {
            // 배치 insert
            await _batchInsertAttachedParkingLots(db, parkingLots);
            totalSaved += parkingLots.length;
            
            _logger.d('부설 주차장 데이터 저장 진행: $totalSaved개 저장됨');
          }
          
          await Future.delayed(const Duration(milliseconds: 1000));
        } catch (e) {
          _logger.w('지역 ${region['sigunguCd']} 데이터 수집 실패: $e');
          continue;
        }
      }

      await _updateSyncInfo(db, 'attached_parking_lots', totalSaved, 'completed');
      _logger.i('부설 주차장 전체 데이터 저장 완료: $totalSaved개');
    } catch (e, stackTrace) {
      _logger.e('부설 주차장 데이터 저장 실패: $e');
      _logger.e('스택 트레이스: $stackTrace');
      
      final db = await database;
      await _updateSyncInfo(db, 'attached_parking_lots', 0, 'failed');
      rethrow;
    }
  }

  /// 일반 주차장 배치 삽입
  static Future<void> _batchInsertGeneralParkingLots(Database db, List<ParkingLotModel> parkingLots) async {
    final batch = db.batch();
    final now = DateTime.now().toIso8601String();
    
    for (final parking in parkingLots) {
      batch.insert('general_parking_lots', {
        'name': parking.name,
        'address': parking.address,
        'total_capacity': parking.totalCapacity,
        'available_spots': parking.availableSpots,
        'latitude': parking.latitude,
        'longitude': parking.longitude,
        'operating_hours_start': parking.operatingHoursStart,
        'operating_hours_end': parking.operatingHoursEnd,
        'fee_info': parking.feeInfo,
        'phone_number': parking.phoneNumber,
        'management_agency': parking.managementAgency,
        'type': parking.type.name,
        'created_at': now,
        'updated_at': now,
      });
    }
    
    await batch.commit(noResult: true);
  }

  /// 부설 주차장 배치 삽입
  static Future<void> _batchInsertAttachedParkingLots(Database db, List<ParkingLotModel> parkingLots) async {
    final batch = db.batch();
    final now = DateTime.now().toIso8601String();
    
    for (final parking in parkingLots) {
      batch.insert('attached_parking_lots', {
        'name': parking.name,
        'address': parking.address,
        'total_capacity': parking.totalCapacity,
        'available_spots': parking.availableSpots,
        'latitude': parking.latitude,
        'longitude': parking.longitude,
        'operating_hours_start': parking.operatingHoursStart,
        'operating_hours_end': parking.operatingHoursEnd,
        'fee_info': parking.feeInfo,
        'phone_number': parking.phoneNumber,
        'management_agency': parking.managementAgency,
        'type': parking.type.name,
        'created_at': now,
        'updated_at': now,
      });
    }
    
    await batch.commit(noResult: true);
  }

  /// 동기화 정보 업데이트
  static Future<void> _updateSyncInfo(Database db, String tableName, int totalRecords, String status) async {
    await db.insert(
      'sync_info',
      {
        'table_name': tableName,
        'last_sync_at': DateTime.now().toIso8601String(),
        'total_records': totalRecords,
        'status': status,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 저장된 일반 주차장 목록 가져오기
  static Future<List<ParkingLotModel>> getGeneralParkingLots({int? limit, int? offset}) async {
    final db = await database;
    
    String query = 'SELECT * FROM general_parking_lots ORDER BY id';
    if (limit != null) {
      query += ' LIMIT $limit';
      if (offset != null) {
        query += ' OFFSET $offset';
      }
    }
    
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return maps.map((map) => _mapToParkingLot(map)).toList();
  }

  /// 저장된 부설 주차장 목록 가져오기
  static Future<List<ParkingLotModel>> getAttachedParkingLots({int? limit, int? offset}) async {
    final db = await database;
    
    String query = 'SELECT * FROM attached_parking_lots ORDER BY id';
    if (limit != null) {
      query += ' LIMIT $limit';
      if (offset != null) {
        query += ' OFFSET $offset';
      }
    }
    
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return maps.map((map) => _mapToParkingLot(map)).toList();
  }

  /// 동기화 정보 가져오기
  static Future<Map<String, dynamic>?> getSyncInfo(String tableName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sync_info',
      where: 'table_name = ?',
      whereArgs: [tableName],
    );
    
    return maps.isNotEmpty ? maps.first : null;
  }

  /// 전체 동기화 정보 가져오기
  static Future<List<Map<String, dynamic>>> getAllSyncInfo() async {
    final db = await database;
    return await db.query('sync_info');
  }

  /// 데이터베이스 맵을 ParkingLotModel로 변환
  static ParkingLotModel _mapToParkingLot(Map<String, dynamic> map) {
    return ParkingLotModel(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      regionCode: 'DB_${map['id'] ?? ''}',
      totalCapacity: map['total_capacity'] ?? 0,
      availableSpots: map['available_spots'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      operatingHoursStart: map['operating_hours_start'],
      operatingHoursEnd: map['operating_hours_end'],
      feeInfo: map['fee_info'],
      phoneNumber: map['phone_number'],
      managementAgency: map['management_agency'],
      type: _parseType(map['type']),
    );
  }

  /// 문자열을 ParkingLotType으로 변환
  static ParkingLotType _parseType(String? typeString) {
    switch (typeString) {
      case 'general':
        return ParkingLotType.general;
      case 'attached':
        return ParkingLotType.attached;
      case 'structure':
        return ParkingLotType.structure;
      default:
        return ParkingLotType.general;
    }
  }

  /// 데이터베이스 초기화 (모든 데이터 삭제)
  static Future<void> clearAllData() async {
    final db = await database;
    await db.delete('general_parking_lots');
    await db.delete('attached_parking_lots');
    await db.delete('sync_info');
    _logger.i('모든 데이터베이스 데이터 삭제 완료');
  }

  /// 데이터베이스 연결 해제
  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}