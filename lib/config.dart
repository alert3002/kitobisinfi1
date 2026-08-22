/// API-и умумӣ барои ҳамаи синфҳо: https://book.1week.tj/
const kApiBaseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'https://book.1week.tj',
);

/// `--dart-define=GRADE=5` агар гузошта шавад, ҳамин истифода мешавад.
const _gradeOverride = int.fromEnvironment('GRADE', defaultValue: 0);

/// Аз `flutter run --flavor sinf5` меояд.
const kFlavor = String.fromEnvironment(
  'FLUTTER_APP_FLAVOR',
  defaultValue: 'sinf1',
);

/// Кадом синф аст ин барнома (1–11). Ҳар flavor = як барномаи алоҳида.
int get kGrade {
  if (_gradeOverride >= 1 && _gradeOverride <= 11) return _gradeOverride;
  final match = RegExp(r'(\d+)').firstMatch(kFlavor);
  final n = int.tryParse(match?.group(1) ?? '1') ?? 1;
  if (n < 1) return 1;
  if (n > 11) return 11;
  return n;
}

String get kDefaultClassName => 'Синфи $kGrade';
String get kAppTitle => 'Китобҳо — Синфи $kGrade';

String get kAboutText =>
    'Барномаи «$kAppTitle» барои хонандагони синфи $kGrade-и '
    'муассисаҳои таҳсилоти умумии Ҷумҳурии Тоҷикистон пешбинӣ шудааст.\n\n'
    'Китобҳои дарсӣ аз сомонаи расмии Вазорати маориф ва илми '
    'Ҷумҳурии Тоҷикистон (maorif.tj) гирифта шудаанд ва танҳо бо мақсади '
    'таълимӣ пешниҳод мегарданд. Ҳар синф барномаи алоҳида дорад; '
    'китобҳо аз як админка ва як API гирифта мешаванд.\n\n'
    'Ҳуқуқи муаллифӣ ва ҳуқуқҳои вобаста ба он ба муаллифон, мураттибон '
    'ва нашриётҳои дахлдор тааллуқ дорад. Нусхабардорӣ, паҳн кардан ё '
    'истифодаи тиҷоратӣ бе иҷозати қонунӣ манъ аст.\n\n'
    'Пас аз насб шумо метавонед китобҳоро бе пайваст ба интернет '
    '(офлайн) истифода баред.\n\n'
    'Сиёсати махфият: $kPrivacyUrl';

const kPrivacyUrl = 'https://book.1week.tj/privacy/';

/// Рекламаи пурраэкран ҳар 3 соату 30 дақиқа як бор.
const kInterstitialInterval = Duration(hours: 3, minutes: 30);

const kAdKeywords = <String>[
  'education',
  'school',
  'textbook',
  'children',
  'kids learning',
];

const kTestAndroidAppId = 'ca-app-pub-3940256099942544~3347511713';
const kTestIosAppId = 'ca-app-pub-3940256099942544~1458002511';
const kTestBannerId = 'ca-app-pub-3940256099942544/6300978111';
const kTestInterstitialId = 'ca-app-pub-3940256099942544/1033173712';
const kTestIosBannerId = 'ca-app-pub-3940256099942544/2934735716';
const kTestIosInterstitialId = 'ca-app-pub-3940256099942544/4411468910';
