import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ProgressService {
  ProgressService._();
  static final instance = ProgressService._();

  static const _lastBookKey = 'last_book_id';
  static const _lastInterstitialKey = 'last_interstitial_at';
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int pageFor(String bookId) => _prefs?.getInt('page_$bookId') ?? 1;

  Future<void> savePage(String bookId, int page) async {
    final prefs = _prefs;
    if (prefs == null) return;
    await prefs.setInt('page_$bookId', page);
    await prefs.setString(_lastBookKey, bookId);
  }

  String? get lastBookId => _prefs?.getString(_lastBookKey);

  DateTime? get lastInterstitialAt {
    final raw = _prefs?.getInt(_lastInterstitialKey);
    if (raw == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(raw);
  }

  Future<void> markInterstitialShown([DateTime? at]) async {
    await _prefs?.setInt(
      _lastInterstitialKey,
      (at ?? DateTime.now()).millisecondsSinceEpoch,
    );
  }

  int get lastSeenNoticeId => _prefs?.getInt('last_seen_notice_id') ?? 0;

  Future<void> markNoticesSeen(int maxId) async {
    final current = lastSeenNoticeId;
    if (maxId > current) {
      await _prefs?.setInt('last_seen_notice_id', maxId);
    }
  }

  int get dismissedUpdateCode => _prefs?.getInt('dismissed_update_code') ?? 0;

  Future<void> dismissUpdate(int versionCode) async {
    await _prefs?.setInt('dismissed_update_code', versionCode);
  }

  String? get catalogCache => _prefs?.getString('catalog_cache_v1_$kGrade');

  Future<void> saveCatalogCache(String json) async {
    await _prefs?.setString('catalog_cache_v1_$kGrade', json);
  }
}
