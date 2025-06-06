import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
import 'package:todo_list_technical_test/core/services/file_storage_service.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_list_technical_test/presentation/screens/task/widgets/attachment_viewer.dart';

class AttachmentsField extends ConsumerStatefulWidget {
  final List<Attachment> attachments;
  final Function(List<Attachment>) onAttachmentsChanged;

  const AttachmentsField({
    super.key,
    required this.attachments,
    required this.onAttachmentsChanged,
  });

  @override
  ConsumerState<AttachmentsField> createState() => _AttachmentsFieldState();
}

class _AttachmentsFieldState extends ConsumerState<AttachmentsField> {
  final _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _recordingPath;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final savedPath =
          await FileStorageService.saveFile(image.path, image.name);
      final attachment = Attachment(
        id: const Uuid().v4(),
        path: savedPath,
        type: AttachmentType.image,
        name: image.name,
        createdAt: DateTime.now(),
      );

      widget.onAttachmentsChanged([...widget.attachments, attachment]);
    }
  }

  Future<void> _pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = result.files.first;
      final savedPath =
          await FileStorageService.saveFile(file.path!, file.name);
      final attachment = Attachment(
        id: const Uuid().v4(),
        path: savedPath,
        type: AttachmentType.pdf,
        name: file.name,
        createdAt: DateTime.now(),
      );

      widget.onAttachmentsChanged([...widget.attachments, attachment]);
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getTemporaryDirectory();
        _recordingPath =
            '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

        if (_recordingPath != null) {
          await _audioRecorder.start(
            const RecordConfig(),
            path: _recordingPath!,
          );
          setState(() => _isRecording = true);
        }
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _audioRecorder.stop();
      setState(() => _isRecording = false);

      if (_recordingPath != null) {
        final fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
        final savedPath =
            await FileStorageService.saveFile(_recordingPath!, fileName);
        final attachment = Attachment(
          id: const Uuid().v4(),
          path: savedPath,
          type: AttachmentType.audio,
          name: fileName,
          createdAt: DateTime.now(),
        );

        widget.onAttachmentsChanged([...widget.attachments, attachment]);
        _recordingPath = null;
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  void _removeAttachment(Attachment attachment) async {
    await FileStorageService.deleteFile(attachment.path);
    widget.onAttachmentsChanged(
      widget.attachments.where((a) => a.id != attachment.id).toList(),
    );
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Adjuntos', style: AppTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: _pickImage,
              tooltip: 'Agregar imagen',
            ),
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: _pickPDF,
              tooltip: 'Agregar PDF',
            ),
            IconButton(
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              onPressed: _isRecording ? _stopRecording : _startRecording,
              tooltip: _isRecording ? 'Detener grabación' : 'Grabar audio',
              color: _isRecording ? Colors.red : null,
            ),
          ],
        ),
        if (widget.attachments.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.attachments.map((attachment) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttachmentViewer(
                        attachment: attachment,
                      ),
                    ),
                  );
                },
                child: Chip(
                  label: Text(attachment.name),
                  avatar: Icon(
                    attachment.type == AttachmentType.image
                        ? Icons.image
                        : attachment.type == AttachmentType.pdf
                            ? Icons.picture_as_pdf
                            : Icons.audio_file,
                  ),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () => _removeAttachment(attachment),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
