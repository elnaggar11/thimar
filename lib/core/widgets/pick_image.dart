import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thimar/core/utils/extensions.dart';

import '../../gen/locale_keys.g.dart';

class PickImage extends StatefulWidget {
  final String title;
  final bool allowFiles, allowMedia;
  const PickImage({
    required this.title,
    super.key,
    this.allowMedia = true,
    this.allowFiles = false,
  });

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: context.scaffoldBackgroundColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title, style: context.semiboldText),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.allowMedia)
              _buildOption(
                icon: CupertinoIcons.camera,
                label: LocaleKeys.camera.tr(),
                onTap: () => _pickAndReturn(ImageSource.camera),
              ),
            if (widget.allowMedia)
              _buildOption(
                icon: CupertinoIcons.photo,
                label: LocaleKeys.gallery.tr(),
                onTap: () => _pickAndReturn(ImageSource.gallery),
              ),
            if (widget.allowFiles)
              _buildOption(
                icon: CupertinoIcons.folder,
                label: LocaleKeys.attachments.tr(),
                onTap: _pickFile,
              ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    ),
  );

  Widget _buildOption({
    required IconData icon,
    required String label,
    required Function() onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Column(
      spacing: 8.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).hoverColor.withValues(alpha: 0.2),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 28.w),
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );

  Future<void> _pickAndReturn(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(source: source);
      if (file != null) {
        final fileInfo = await _getFileInfo(file.path);
        // final fileModel = FileModel.fromFileInfo(fileInfo);
        if (mounted) {
          // Navigator.pop(context, fileModel);
        }
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
      }
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        final fileInfo = await _getFileInfo(result.files.single.path!);
        // final fileModel = FileModel.fromFileInfo(fileInfo);
        if (mounted) {
          // Navigator.pop(context, fileModel);
        }
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
      }
    }
  }

  Future<Map<String, dynamic>> _getFileInfo(String path) async {
    final file = File(path);
    final stat = await file.stat();
    final sizeInKB = stat.size / 1024;
    final extension = path.split('.').last.toLowerCase();

    return {
      'file': file,
      'path': path,
      'name': path.split('/').last,
      'size': stat.size,
      'sizeKB': sizeInKB.toStringAsFixed(2),
      'extension': extension,
      'mimeType': _getMimeType(extension),
    };
  }

  String _getMimeType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return 'application/octet-stream';
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
