import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worker_manager/worker_manager.dart';

import '../Conveyors/RequestHelper.dart';
import '../Models/DBFile.dart';
import 'Conveyor.dart';

class DBFileConveyor extends Conveyor<DBFile> {
  static DBFileConveyor instance;

  static DBFileConveyor getInstance() {
    return instance = instance ?? DBFileConveyor();
  }

  @override
  DBFile createObject(Map<String, dynamic> input) {
    return DBFile.fromJson(input);
  }

  @override
  String getBlueprintName() {
    return 'dbfile';
  }

  Future<File> download(String masterID, String code) async {
    List<DBFile> businessCardImageFileList = await DBFileConveyor.getInstance()
        .sendGet(queries: {"code": code, "masterid": masterID});
    DBFile actualFile = businessCardImageFileList.first;
    //The body of this will be the file
    Response response = await Conveyor.sendRequestIsolateBare(this, [
      HttpMethod.GET,
      '/load',
      await RequestHelper.getAuthHeader(),
      null,
      {"masterid": masterID, "code": code},
      <String, dynamic>{},
      null
    ]);

    Directory thingything = await getApplicationDocumentsDirectory();
    String thingpath = thingything.path;
    Directory direcc = Directory(thingpath + "/assets/$masterID");
    direcc.createSync(recursive: true);

    File file = new File("${direcc.path}/$code.${actualFile.filetype}");
    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }

  ///If [masterID] isn't specified, the backend will use the user's own guid by getting it from the auth token
  ///Also files need to have a name and an extension to work, at least for now
  ///TODO turn this into a DBFile return
  ///TODO make the file not rely on a filename and use mime type instead
  Future sendUploadSingle(File file, String masterid) async {
    String bluePrintName = getBlueprintName();
    Map<String, dynamic> headers = await RequestHelper.getAuthHeader();
    String code = "PICTURE";
    List<String> arg2list = [bluePrintName,code, masterid];
    Directory thingything = await getApplicationDocumentsDirectory();
    String thingpath = thingything.path;
    Directory direcc = Directory(thingpath + "/assets");
    direcc.createSync(recursive: true);
    file.writeAsBytesSync(file.readAsBytesSync());
    await Executor().execute(fun3: sendRequestt, arg1: file, arg2: arg2list, arg3: headers);
  }

  static Future<dynamic> sendRequestt(File file, List<String> arglist, Map<String, dynamic> headers) async {
    Map<String, String> params = {"code": arglist[1], "masterid": arglist[2]};
    MultipartFile fileToSend = await MultipartFile.fromPath("file", file.path);
    String urlString = Conveyor.serverUrl + arglist[0] + "/load" + "?" + Conveyor.argsToString(params);
    Uri url = Uri.parse(urlString);
    MultipartRequest request = MultipartRequest("POST", url);
    request.headers.addAll(headers);
    request.files.add(fileToSend);
    StreamedResponse response = await request.send();
    print("statuscode"+ response.statusCode.toString());
    return (response.statusCode == 201);
  }
}
