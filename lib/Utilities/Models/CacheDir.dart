class CacheDir {
  String key; //use file URL if available,some form of a primary key otherwise, or DBfile.id if using DBfile.
  String filePath;
  String updateTime;

  CacheDir({
    this.key,
    this.filePath,
    this.updateTime,
  });

  factory CacheDir.fromJson(Map<String, dynamic> json) {
    return CacheDir(
      key: json["key"],
      filePath: json["filepath"],
      updateTime: json["updatetime"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{
      "key": key,
      "filepath": filePath,
      "updatetime": updateTime,
    };
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheDir &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          filePath == other.filePath &&
          updateTime == other.updateTime;

  @override
  int get hashCode => key.hashCode ^ filePath.hashCode ^ updateTime.hashCode;

  @override
  String toString() {
    return 'CacheDir{url: $key, filePath: $filePath, updateTime: $updateTime}';
  }
}
