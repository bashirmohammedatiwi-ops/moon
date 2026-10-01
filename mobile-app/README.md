# قمر الزمان — تطبيق Flutter

متجر مستحضرات التجميل والعناية. يتصل بـ `http://187.127.88.146:3200/api/v1`.

**Bundle ID:** `com.qamaralzaman.app`

## المتطلبات

- Flutter SDK 3.9+
- Android Studio / Xcode (للنشر على المتاجر)

## التشغيل المحلي

```bash
cd mobile-app
flutter pub get
flutter run
```

للاتصال بخادم محلي:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3200/api/v1
```

## بناء الإصدار للمتاجر

### Android (Google Play)

```bash
flutter build appbundle --release
```

### iOS (App Store)

Bundle ID: `com.qamaralzaman.app` — Display name: قمر الزمان

## الهوية

فيروزي الشعار `#088898` — التفاصيل في `docs/design-system.md`.
