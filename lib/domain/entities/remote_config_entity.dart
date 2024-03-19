class RemoteConfigEntity {
  final String androidVersion;
  final String iOSVersion;
  final bool forceAndroidUpdate;
  final bool forceIOSUpdate;

  RemoteConfigEntity(
      {required this.androidVersion,
      required this.iOSVersion,
      required this.forceAndroidUpdate,
      required this.forceIOSUpdate});
}
