import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/spotlight_item.dart';
import '../../data/services/api_service.dart' show apiServiceProvider;

final spotlightFeedProvider = FutureProvider.autoDispose<List<SpotlightItem>>((ref) async {
  return ref.read(apiServiceProvider).getSpotlight();
});
