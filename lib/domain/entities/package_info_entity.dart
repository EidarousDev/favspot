class PackageInfoEntity {
  final String packageName;
  final String appName;
  final String version;
  final String buildNumber;

  PackageInfoEntity(
      {required this.packageName,
      required this.appName,
      required this.version,
      required this.buildNumber});
}
