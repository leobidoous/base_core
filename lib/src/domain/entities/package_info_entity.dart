class PackageInfoEntity {
  PackageInfoEntity({
    required this.name,
    required this.appName,
    required this.version,
    required this.buildNumber,
    required this.forceUpdate,
    required this.buildSignature,
  });
  final String name;
  final String appName;
  final String version;
  final int buildNumber;
  final bool forceUpdate;
  final String buildSignature;

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}
