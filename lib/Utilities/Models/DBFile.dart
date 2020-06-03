class DBFile {
  int id;
  String code;
  String guid;
  String masterid;
  String filename;
  String filetype;

  DBFile({
    this.id,
    this.code,
    this.guid,
    this.masterid,
    this.filename,
    this.filetype,
  });

  factory DBFile.fromJson(Map<String, dynamic> json) => DBFile(
        id: json["id"],
        code: json["code"],
        guid: json["guid"],
        masterid: json["masterid"],
        filename: json["filename"],
        filetype: json["filetype"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "guid": guid,
        "masterid": masterid,
        "filename": filename,
        "filetype": filetype,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBFile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          guid == other.guid &&
          masterid == other.masterid &&
          filename == other.filename &&
          filetype == other.filetype;

  @override
  int get hashCode =>
      id.hashCode ^
      code.hashCode ^
      guid.hashCode ^
      masterid.hashCode ^
      filename.hashCode ^
      filetype.hashCode;

  @override
  String toString() {
    return 'DBFile{id: $id, code: $code, guid: $guid, masterid: $masterid, filename: $filename, filetype: $filetype}';
  }
}
