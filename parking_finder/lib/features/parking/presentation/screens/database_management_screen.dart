import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../../data/services/parking_database_service.dart';
import '../../data/services/excel_export_service.dart';

/// 데이터베이스 관리 화면
class DatabaseManagementScreen extends StatefulWidget {
  const DatabaseManagementScreen({Key? key}) : super(key: key);

  @override
  State<DatabaseManagementScreen> createState() => _DatabaseManagementScreenState();
}

class _DatabaseManagementScreenState extends State<DatabaseManagementScreen> {
  final Logger _logger = Logger();
  
  Map<String, dynamic>? _generalSyncInfo;
  Map<String, dynamic>? _attachedSyncInfo;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSyncInfo();
  }

  /// 동기화 정보 로드
  Future<void> _loadSyncInfo() async {
    if (kIsWeb) return; // 웹에서는 SQLite 지원하지 않음
    
    try {
      final generalInfo = await ParkingDatabaseService.getSyncInfo('general_parking_lots');
      final attachedInfo = await ParkingDatabaseService.getSyncInfo('attached_parking_lots');
      
      if (mounted) {
        setState(() {
          _generalSyncInfo = generalInfo;
          _attachedSyncInfo = attachedInfo;
        });
      }
    } catch (e) {
      _logger.e('동기화 정보 로드 실패: $e');
    }
  }

  /// 일반 주차장 데이터 다운로드
  Future<void> _downloadGeneralParkingData() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    
    // 진행률 다이얼로그 표시
    _showProgressDialog('일반 주차장 데이터를 다운로드하는 중...');
    
    try {
      await ParkingDatabaseService.downloadAndSaveGeneralParkingLots();
      
      // 다이얼로그 닫기
      if (mounted) Navigator.of(context).pop();
      
      // 성공 메시지
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('일반 주차장 데이터 다운로드가 완료되었습니다'),
            backgroundColor: Colors.green,
          ),
        );
      }
      
      // 동기화 정보 새로고침
      await _loadSyncInfo();
      
    } catch (e) {
      // 다이얼로그 닫기
      if (mounted) Navigator.of(context).pop();
      
      // 에러 메시지
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('일반 주차장 데이터 다운로드 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// 부설 주차장 데이터 다운로드
  Future<void> _downloadAttachedParkingData() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    
    _showProgressDialog('부설 주차장 데이터를 다운로드하는 중...');
    
    try {
      await ParkingDatabaseService.downloadAndSaveAttachedParkingLots();
      
      if (mounted) Navigator.of(context).pop();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('부설 주차장 데이터 다운로드가 완료되었습니다'),
            backgroundColor: Colors.green,
          ),
        );
      }
      
      await _loadSyncInfo();
      
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('부설 주차장 데이터 다운로드 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// 일반 주차장 엑셀 다운로드
  Future<void> _exportGeneralParkingToExcel() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    
    _showProgressDialog('일반 주차장 엑셀 파일을 생성하는 중...');
    
    try {
      final parkingLots = await ParkingDatabaseService.getGeneralParkingLots();
      
      if (parkingLots.isEmpty) {
        if (mounted) Navigator.of(context).pop();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('저장된 일반 주차장 데이터가 없습니다'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }
      
      final filePath = await ExcelExportService.exportAllDataToExcel(parkingLots, 'general');
      
      if (mounted) Navigator.of(context).pop();
      
      if (filePath != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('일반 주차장 엑셀 파일이 저장되었습니다\n$filePath'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('일반 주차장 엑셀 내보내기 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// 부설 주차장 엑셀 다운로드
  Future<void> _exportAttachedParkingToExcel() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    
    _showProgressDialog('부설 주차장 엑셀 파일을 생성하는 중...');
    
    try {
      final parkingLots = await ParkingDatabaseService.getAttachedParkingLots();
      
      if (parkingLots.isEmpty) {
        if (mounted) Navigator.of(context).pop();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('저장된 부설 주차장 데이터가 없습니다'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }
      
      final filePath = await ExcelExportService.exportAllDataToExcel(parkingLots, 'attached');
      
      if (mounted) Navigator.of(context).pop();
      
      if (filePath != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('부설 주차장 엑셀 파일이 저장되었습니다\n$filePath'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('부설 주차장 엑셀 내보내기 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// 진행률 다이얼로그 표시
  void _showProgressDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(message),
                const SizedBox(height: 8),
                const Text(
                  '잠시만 기다려주세요...',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 데이터 초기화 확인
  Future<void> _confirmClearData() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('데이터 초기화'),
        content: const Text('저장된 모든 주차장 데이터를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        await ParkingDatabaseService.clearAllData();
        await _loadSyncInfo();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('모든 데이터가 삭제되었습니다'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('데이터 삭제 실패: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('데이터베이스 관리'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.web, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  '웹에서는 지원하지 않는 기능입니다',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Text(
                  '이 기능은 모바일 앱에서만 사용할 수 있습니다.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터베이스 관리'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _confirmClearData,
            tooltip: '데이터 초기화',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadSyncInfo,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildInfoCard(),
            const SizedBox(height: 16),
            _buildGeneralParkingCard(),
            const SizedBox(height: 16),
            _buildAttachedParkingCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  '데이터베이스 관리',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '• 전체 주차장 데이터를 다운로드하여 로컬에 저장할 수 있습니다\n'
              '• 저장된 데이터는 엑셀 파일로 내보낼 수 있습니다\n'
              '• 파일은 /storage/emulated/0/parking_finder/ 폴더에 저장됩니다\n'
              '• 데이터 다운로드는 시간이 오래 걸릴 수 있습니다',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralParkingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_parking, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  '일반 주차장',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSyncInfoWidget(_generalSyncInfo),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _downloadGeneralParkingData,
                    icon: const Icon(Icons.download),
                    label: const Text('데이터 다운로드'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (_isLoading || _generalSyncInfo == null) 
                        ? null 
                        : _exportGeneralParkingToExcel,
                    icon: const Icon(Icons.file_download),
                    label: const Text('엑셀 다운로드'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachedParkingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.apartment, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  '부설 주차장',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSyncInfoWidget(_attachedSyncInfo),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _downloadAttachedParkingData,
                    icon: const Icon(Icons.download),
                    label: const Text('데이터 다운로드'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (_isLoading || _attachedSyncInfo == null) 
                        ? null 
                        : _exportAttachedParkingToExcel,
                    icon: const Icon(Icons.file_download),
                    label: const Text('엑셀 다운로드'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncInfoWidget(Map<String, dynamic>? syncInfo) {
    if (syncInfo == null) {
      return const Text(
        '저장된 데이터가 없습니다',
        style: TextStyle(color: Colors.grey),
      );
    }

    final totalRecords = syncInfo['total_records'] ?? 0;
    final lastSync = syncInfo['last_sync_at'] as String?;
    final status = syncInfo['status'] as String?;
    
    DateTime? syncDateTime;
    if (lastSync != null) {
      try {
        syncDateTime = DateTime.parse(lastSync);
      } catch (e) {
        // 파싱 실패 시 무시
      }
    }

    Color statusColor = Colors.grey;
    String statusText = '알 수 없음';
    
    switch (status) {
      case 'completed':
        statusColor = Colors.green;
        statusText = '완료';
        break;
      case 'failed':
        statusColor = Colors.red;
        statusText = '실패';
        break;
      case 'in_progress':
        statusColor = Colors.orange;
        statusText = '진행 중';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.circle, size: 8, color: statusColor),
            const SizedBox(width: 8),
            Text('상태: $statusText'),
          ],
        ),
        const SizedBox(height: 4),
        Text('저장된 데이터: ${totalRecords.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), 
          (Match m) => '${m[1]},'
        )}개'),
        if (syncDateTime != null) ...[
          const SizedBox(height: 4),
          Text(
            '마지막 동기화: ${syncDateTime.year}-${syncDateTime.month.toString().padLeft(2, '0')}-${syncDateTime.day.toString().padLeft(2, '0')} '
            '${syncDateTime.hour.toString().padLeft(2, '0')}:${syncDateTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}