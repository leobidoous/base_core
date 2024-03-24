class PackageInfoEntity {
  PackageInfoEntity({
    required this.appName,
    required this.name,
    required this.version,
    required this.buildNumber,
    required this.buildSignature,
    required this.forceUpdate,
  });
  final String appName;
  final String name;
  final String version;
  final int buildNumber;
  final String buildSignature;
  final bool forceUpdate;


  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}
