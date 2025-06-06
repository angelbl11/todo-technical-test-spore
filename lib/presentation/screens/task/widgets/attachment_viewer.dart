import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:todo_list_technical_test/presentation/providers/todo.dart';
import 'package:todo_list_technical_test/core/theme/app_theme.dart';

class AttachmentViewer extends StatefulWidget {
  final Attachment attachment;

  const AttachmentViewer({
    super.key,
    required this.attachment,
  });

  @override
  State<AttachmentViewer> createState() => _AttachmentViewerState();
}

class _AttachmentViewerState extends State<AttachmentViewer> {
  final _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkFile();
  }

  Future<void> _checkFile() async {
    try {
      final file = File(widget.attachment.path);
      if (!await file.exists()) {
        setState(() {
          _error = 'El archivo no existe';
          _isLoading = false;
        });
        return;
      }
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _error = 'Error al acceder al archivo: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        setState(() => _isPlaying = false);
      } else {
        await _audioPlayer.setFilePath(widget.attachment.path);
        await _audioPlayer.play();
        setState(() => _isPlaying = true);
      }
    } catch (e) {
      if (!mounted) return;
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error al reproducir el audio: $e')),
      );
    }
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            _error ?? 'Error desconocido',
            style: AppTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.attachment.name)),
        body: _buildLoading(),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.attachment.name)),
        body: _buildError(),
      );
    }

    switch (widget.attachment.type) {
      case AttachmentType.image:
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.attachment.name),
          ),
          body: PhotoView(
            imageProvider: FileImage(File(widget.attachment.path)),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            errorBuilder: (context, error, stackTrace) => _buildError(),
          ),
        );
      case AttachmentType.pdf:
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.attachment.name),
          ),
          body: SfPdfViewer.file(
            File(widget.attachment.path),
            enableDoubleTapZooming: true,
            enableTextSelection: true,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            enableDocumentLinkAnnotation: true,
          ),
        );
      case AttachmentType.audio:
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.attachment.name),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 64,
                  onPressed: _playAudio,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.attachment.name,
                  style: AppTheme.titleMedium,
                ),
              ],
            ),
          ),
        );
    }
  }
}
