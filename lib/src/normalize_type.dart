String normalizeType(String? source) {
  return source?.replaceAll(RegExp(r'\s+'), '') ?? '';
}
