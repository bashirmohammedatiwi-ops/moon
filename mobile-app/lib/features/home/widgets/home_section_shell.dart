import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/locale_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../data/models/home_section.dart';
import '../home_link.dart';
import 'home_theme.dart';

bool homeSectionShowsTitle(HomeSection section) => section.showTitle;

/// غلاف موحّد للأقسام — بسيط، أنيق، بدون تعقيد.
class HomeSectionShell extends ConsumerWidget {
  final HomeSection section;
  final bool compactTop;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? headerTrailing;
  final bool? showTitle;
  final bool elevated;
  final bool wrapCard;
  final String? overline;
  final Widget child;

  const HomeSectionShell({
    super.key,
    required this.section,
    required this.child,
    this.compactTop = false,
    this.actionLabel,
    this.onAction,
    this.headerTrailing,
    this.showTitle,
    this.elevated = false,
    this.wrapCard = false,
    this.overline,
  });

  bool get _showTitle => showTitle ?? homeSectionShowsTitle(section);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageCodeProvider);
    final title = section.titleForLang(lang);
    final subtitle = section.subtitleForLang(lang);
    final cmsBg = parseHexColor(section.backgroundColor);

    Widget body = child;
    if (wrapCard) {
      body = Padding(
        padding: const EdgeInsets.symmetric(horizontal: HomeTheme.paddingH),
        child: DecoratedBox(
          decoration: HomeTheme.sectionSurface(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(HomeTheme.cardRadius),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: child,
            ),
          ),
        ),
      );
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_showTitle && (title?.isNotEmpty ?? false))
          HomeSectionHeader(
            title: title!,
            subtitle: subtitle,
            headerImageUrl: section.headerImageUrl,
            actionLabel: actionLabel,
            onAction: onAction,
            trailing: headerTrailing,
            compact: compactTop,
            overline: overline,
          )
        else if ((actionLabel != null && onAction != null) || headerTrailing != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(HomeTheme.paddingH, 2, HomeTheme.paddingH, 8),
            child: Row(
              children: [
                if (headerTrailing != null) headerTrailing!,
                const Spacer(),
                if (actionLabel != null && onAction != null)
                  HomeViewAllLink(label: actionLabel!, onTap: onAction!),
              ],
            ),
          ),
        body,
      ],
    );

    if (elevated) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: HomeTheme.paddingH),
        child: DecoratedBox(
          decoration: HomeTheme.sectionSurface(tint: cmsBg ?? HomeTheme.surface),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(HomeTheme.cardRadius),
            child: content,
          ),
        ),
      );
    }

    if (cmsBg != null) {
      return ColoredBox(color: cmsBg, child: content);
    }

    return content;
  }
}

/// عنوان قسم — خط وردي + نص واضح.
class HomeSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? headerImageUrl;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? trailing;
  final bool compact;
  final String? overline;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.headerImageUrl,
    this.actionLabel,
    this.onAction,
    this.trailing,
    this.compact = false,
    this.overline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        HomeTheme.paddingH,
        compact ? 2 : 6,
        HomeTheme.paddingH,
        10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: compact ? 28 : 36,
            margin: const EdgeInsetsDirectional.only(end: 12, top: 2),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(99),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.28),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          if (headerImageUrl != null && headerImageUrl!.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AppNetworkImage(
                url: headerImageUrl!,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (overline != null && overline!.isNotEmpty) ...[
                  Text(overline!, style: HomeTheme.overline),
                  const SizedBox(height: 2),
                ],
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: compact ? 14 : 16,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: HomeTheme.sectionTitle(size: compact ? 17 : 19),
                      ),
                    ),
                  ],
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: HomeTheme.body(size: 12)),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
          if (actionLabel != null && onAction != null)
            HomeViewAllLink(label: actionLabel!, onTap: onAction!),
        ],
      ),
    );
  }
}
