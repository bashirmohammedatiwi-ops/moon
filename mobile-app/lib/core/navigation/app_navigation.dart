import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/shell/main_shell.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// يفتح تبويباً في الشريط السفلي مع العودة للرئيسية.
void openMainTab(BuildContext context, ProviderContainer container, int index) {
  container.read(navIndexProvider.notifier).state = index;
  final router = GoRouter.of(context);
  if (router.state.uri.path != '/') {
    context.go('/');
  }
}

void openCartTab(BuildContext context, ProviderContainer container) =>
    openMainTab(context, container, 3);

void openSpotlightTab(BuildContext context, ProviderContainer container) =>
    openMainTab(context, container, 2);

void openOffersPage(BuildContext context) => context.push('/offers');

void openCategoriesTab(BuildContext context, ProviderContainer container) =>
    openMainTab(context, container, 1);

void openHomeTab(BuildContext context, ProviderContainer container) =>
    openMainTab(context, container, 0);

/// للاستخدام بدون BuildContext (مثل الإشعارات الفورية).
void openMainTabFromContainer(ProviderContainer container, int index) {
  container.read(navIndexProvider.notifier).state = index;
  final ctx = rootNavigatorKey.currentContext;
  if (ctx == null || !ctx.mounted) return;
  if (GoRouter.of(ctx).state.uri.path != '/') {
    ctx.go('/');
  }
}

void openCartFromContainer(ProviderContainer container) =>
    openMainTabFromContainer(container, 3);

void openSpotlightFromContainer(ProviderContainer container) =>
    openMainTabFromContainer(container, 2);

@Deprecated('Use openOffersPage')
void openOffersTab(BuildContext context, ProviderContainer container) =>
    openOffersPage(context);

@Deprecated('Use openSpotlightFromContainer')
void openOffersFromContainer(ProviderContainer container) =>
    openSpotlightFromContainer(container);
