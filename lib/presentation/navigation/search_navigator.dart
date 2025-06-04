// lib/presentation/navigation/search_navigator.dart

import 'package:flutter/material.dart';
import 'package:yo_contrato_app/domain/modules/module_type.dart';

abstract class SearchNavigator {
  Future<void> navigateTo({
    required BuildContext context,
    required ModuleType module,
    required String dni,
  });
}
