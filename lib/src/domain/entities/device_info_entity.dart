class DeviceInfoEntity {
  DeviceInfoEntity({
    this.id,
    this.isPhysicalDevice = false,
    this.model,
    this.name,
    this.systemVersion,
    this.localizedModel,
  });
  final String? id;
  final bool isPhysicalDevice;
  final String? model;
  final String? name;
  final String? systemVersion;
  final String? localizedModel;
}
