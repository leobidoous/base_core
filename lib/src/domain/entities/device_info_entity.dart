class DeviceInfoEntity {
  DeviceInfoEntity({
    this.id,
    this.data,
    this.name,
    this.model,
    this.serialNumber,
    this.systemVersion,
    this.localizedModel,
    this.isPhysicalDevice = false,
  });
  final String? id;
  final String? name;
  final String? model;
  final String? serialNumber;
  final bool isPhysicalDevice;
  final String? systemVersion;
  final String? localizedModel;
  final Map<String, dynamic>? data;
}
