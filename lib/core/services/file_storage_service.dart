import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileStorageService {
  static Future<String> saveFile(String sourcePath, String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final attachmentsDir = Directory('${appDir.path}/attachments');

    if (!await attachmentsDir.exists()) {
      await attachmentsDir.create(recursive: true);
    }

    final extension = path.extension(fileName);
    final newFileName = '${DateTime.now().millisecondsSinceEpoch}$extension';
    final newPath = '${attachmentsDir.path}/$newFileName';

    await File(sourcePath).copy(newPath);
    return newPath;
  }

  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
