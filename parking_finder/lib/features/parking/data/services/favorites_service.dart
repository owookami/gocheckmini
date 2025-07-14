import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import '../models/parking_lot_model.dart';

/// 즐겨찾기 주차장 관리 서비스
class FavoritesService {
  static const String _favoritesKey = 'favorite_parking_lots';
  static final Logger _logger = Logger();

  static FavoritesService? _instance;
  static FavoritesService get instance {
    _instance ??= FavoritesService._internal();
    final currentInstance = _instance;
    if (currentInstance != null) {
      return currentInstance;
    }
    throw StateError('FavoritesService initialization failed');
  }

  FavoritesService._internal();

  /// 즐겨찾기 목록 가져오기
  Future<List<ParkingLotModel>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

      final favorites =
          favoritesJson
              .map((jsonStr) {
                try {
                  final json = jsonDecode(jsonStr) as Map<String, dynamic>;
                  return ParkingLotModel.fromJson(json);
                } catch (e) {
                  _logger.e('즐겨찾기 파싱 오류: $e');
                  return null;
                }
              })
              .whereType<ParkingLotModel>()
              .toList();

      _logger.d('즐겨찾기 로드: ${favorites.length}개');
      return favorites;
    } catch (e) {
      _logger.e('즐겨찾기 로드 실패: $e');
      return [];
    }
  }

  /// 즐겨찾기 ID 목록 가져오기 (빠른 확인용)
  Future<Set<String>> getFavoriteIds() async {
    try {
      final favorites = await getFavorites();
      return favorites.map((parking) => _generateParkingId(parking)).toSet();
    } catch (e) {
      _logger.e('즐겨찾기 ID 로드 실패: $e');
      return <String>{};
    }
  }

  /// 즐겨찾기 추가
  Future<bool> addFavorite(ParkingLotModel parkingLot) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavorites();

      // 중복 확인
      final parkingId = _generateParkingId(parkingLot);
      if (favorites.any((fav) => _generateParkingId(fav) == parkingId)) {
        _logger.w('이미 즐겨찾기에 있음: ${parkingLot.name}');
        return false;
      }

      // 추가
      favorites.add(parkingLot);

      // 저장
      final favoritesJson =
          favorites.map((parking) => jsonEncode(parking.toJson())).toList();

      await prefs.setStringList(_favoritesKey, favoritesJson);
      _logger.d('즐겨찾기 추가: ${parkingLot.name}');
      return true;
    } catch (e) {
      _logger.e('즐겨찾기 추가 실패: $e');
      return false;
    }
  }

  /// 즐겨찾기 제거
  Future<bool> removeFavorite(ParkingLotModel parkingLot) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavorites();

      // 제거
      final parkingId = _generateParkingId(parkingLot);
      final beforeCount = favorites.length;
      favorites.removeWhere((fav) => _generateParkingId(fav) == parkingId);

      if (favorites.length == beforeCount) {
        _logger.w('즐겨찾기에 없음: ${parkingLot.name}');
        return false;
      }

      // 저장
      final favoritesJson =
          favorites.map((parking) => jsonEncode(parking.toJson())).toList();

      await prefs.setStringList(_favoritesKey, favoritesJson);
      _logger.d('즐겨찾기 제거: ${parkingLot.name}');
      return true;
    } catch (e) {
      _logger.e('즐겨찾기 제거 실패: $e');
      return false;
    }
  }

  /// 즐겨찾기 토글 (있으면 제거, 없으면 추가)
  Future<bool> toggleFavorite(ParkingLotModel parkingLot) async {
    final favoriteIds = await getFavoriteIds();
    final parkingId = _generateParkingId(parkingLot);

    if (favoriteIds.contains(parkingId)) {
      return await removeFavorite(parkingLot);
    } else {
      return await addFavorite(parkingLot);
    }
  }

  /// 즐겨찾기 여부 확인
  Future<bool> isFavorite(ParkingLotModel parkingLot) async {
    final favoriteIds = await getFavoriteIds();
    final parkingId = _generateParkingId(parkingLot);
    return favoriteIds.contains(parkingId);
  }

  /// 즐겨찾기 전체 삭제
  Future<void> clearAllFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favoritesKey);
      _logger.d('즐겨찾기 전체 삭제');
    } catch (e) {
      _logger.e('즐겨찾기 전체 삭제 실패: $e');
    }
  }

  /// 주차장 고유 ID 생성 (이름 + 주소 기반)
  String _generateParkingId(ParkingLotModel parkingLot) {
    final name = parkingLot.name ?? '';
    final address = parkingLot.address ?? '';
    final lat = parkingLot.latitude?.toStringAsFixed(6) ?? '';
    final lng = parkingLot.longitude?.toStringAsFixed(6) ?? '';

    // 이름 + 주소 + 좌표로 고유성 확보
    return '$name|$address|$lat|$lng'.hashCode.toString();
  }
}
