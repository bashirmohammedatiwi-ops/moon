import '../../core/l10n/localized_text.dart' as l10n;
import '../../core/utils/json.dart';
import 'media.dart';

class SpotlightItem {
  final String id;
  final String? title;
  final String? titleEn;
  final String? subtitle;
  final String? subtitleEn;
  final String? badge;
  final String? badgeEn;
  final String? ctaLabel;
  final String? ctaLabelEn;
  final String? linkType;
  final String? linkValue;
  final String? link;
  final AppMedia? image;

  const SpotlightItem({
    required this.id,
    this.title,
    this.titleEn,
    this.subtitle,
    this.subtitleEn,
    this.badge,
    this.badgeEn,
    this.ctaLabel,
    this.ctaLabelEn,
    this.linkType,
    this.linkValue,
    this.link,
    this.image,
  });

  factory SpotlightItem.fromJson(Map<String, dynamic> json) => SpotlightItem(
        id: asString(json['id']),
        title: json['title']?.toString(),
        titleEn: json['titleEn']?.toString(),
        subtitle: json['subtitle']?.toString(),
        subtitleEn: json['subtitleEn']?.toString(),
        badge: json['badge']?.toString(),
        badgeEn: json['badgeEn']?.toString(),
        ctaLabel: json['ctaLabel']?.toString(),
        ctaLabelEn: json['ctaLabelEn']?.toString(),
        linkType: json['linkType']?.toString(),
        linkValue: (json['linkValue'] ?? json['target'])?.toString(),
        link: json['link']?.toString(),
        image: json['image'] is Map ? AppMedia.fromJson(asMap(json['image'])) : null,
      );

  String get imageUrl {
    if (image?.hero.isNotEmpty == true) return image!.hero;
    if (image?.full.isNotEmpty == true) return image!.full;
    return '';
  }

  String? titleForLang(String lang) {
    final val = l10n.localizedText(
      languageCode: lang,
      ar: title,
      en: titleEn,
      fallback: '',
    );
    return val.trim().isEmpty ? null : val;
  }

  String? subtitleForLang(String lang) {
    final val = l10n.localizedText(
      languageCode: lang,
      ar: subtitle,
      en: subtitleEn,
      fallback: '',
    );
    return val.trim().isEmpty ? null : val;
  }

  String? badgeForLang(String lang) {
    final val = l10n.localizedText(
      languageCode: lang,
      ar: badge,
      en: badgeEn,
      fallback: '',
    );
    return val.trim().isEmpty ? null : val;
  }

  String? ctaForLang(String lang) {
    final val = l10n.localizedText(
      languageCode: lang,
      ar: ctaLabel,
      en: ctaLabelEn,
      fallback: '',
    );
    return val.trim().isEmpty ? null : val;
  }
}
