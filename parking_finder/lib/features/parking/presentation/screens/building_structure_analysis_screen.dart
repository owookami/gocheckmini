import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../providers/building_analysis_providers.dart';

/// 건축물 구조 분석 화면
class BuildingStructureAnalysisScreen extends ConsumerStatefulWidget {
  const BuildingStructureAnalysisScreen({super.key});

  @override
  ConsumerState<BuildingStructureAnalysisScreen> createState() =>
      _BuildingStructureAnalysisScreenState();
}

class _BuildingStructureAnalysisScreenState
    extends ConsumerState<BuildingStructureAnalysisScreen> {
  final TextEditingController _addressController = TextEditingController();
  final Logger _logger = Logger();
  String? _lastSearchedAddress;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _performAnalysis() {
    final address = _addressController.text.trim();
    if (address.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('주소를 입력해주세요.')));
      return;
    }

    setState(() {
      _lastSearchedAddress = address;
    });

    _logger.i('건축물 구조 분석 시작: $address');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('건축물 구조 분석'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchCard(),
            const SizedBox(height: 24),
            if (_lastSearchedAddress != null) _buildResultSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '건축물 주소 검색',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: '건축물 주소',
                hintText: '예: 서울특별시 강남구 테헤란로 123',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              onSubmitted: (_) => _performAnalysis(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _performAnalysis,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('구조 분석 시작'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    final analysisAsync = ref.watch(
      analyzeBuildingStructureProvider(_lastSearchedAddress!),
    );

    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.analytics, color: Colors.orange),
                  const SizedBox(width: 8),
                  const Text(
                    '분석 결과',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: analysisAsync.when(
                  data: (result) => _buildAnalysisResult(result),
                  loading:
                      () => const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('건축물 정보를 분석하고 있습니다...'),
                          ],
                        ),
                      ),
                  error: (error, stack) => _buildErrorResult(error.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisResult(dynamic result) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: const Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 48),
                SizedBox(height: 8),
                Text(
                  '분석 완료',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '건축물 구조 분석이 완료되었습니다.\n상세 결과는 개발 진행 중입니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '분석 예상 항목:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('• 건축 년도 분석\n• 층수 및 면적 정보\n• 구조 형식 확인\n• 철골데크 적용 가능성'),
        ],
      ),
    );
  }

  Widget _buildErrorResult(String error) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        children: [
          const Icon(Icons.error, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          const Text(
            '분석 실패',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '건축물 정보를 가져올 수 없습니다:\n$error',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _lastSearchedAddress = null;
              });
            },
            child: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }
}
