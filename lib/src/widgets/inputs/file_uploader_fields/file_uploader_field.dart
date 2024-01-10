import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/riverpod_globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

// Create a Riverpod provider to hold the list of uploaded files

class FileUploaderField extends ConsumerStatefulWidget {
  const FileUploaderField({Key? key, this.onFileUploaded = _defaultFunction}) :
        super(key: key);
  final void Function(File) onFileUploaded;

  static void _defaultFunction(file) {
    // This is the default empty function.
    // It does nothing.
  }

  @override
  ConsumerState<FileUploaderField> createState() => _FileUploaderFieldState();
}

class _FileUploaderFieldState extends ConsumerState<FileUploaderField> {
  final bool _loading = false;
  double _uploadProgress = 0.0;

  Future<void> _chooseFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        // Add the uploaded file name to the provider
        ref.read(uploadedFilesProvider).add(result.files.single.name);

        // Start uploading the file
        await _uploadFile(result.files.single.path!);
      }
    } catch (e) {
      // Handle any potential errors when picking the file
    }
  }

  Future<void> _uploadFile(String filePath) async {
    // Simulate file upload process (you should implement your upload logic here)
    for (int i = 0; i <= 90; i += 10) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _uploadProgress = i / 100;
      });
    }
    try {
      // Get the directory where we can store app-specific files
      final directory = await getApplicationDocumentsDirectory();

      // Create a File instance for the selected file
      final selectedFile = File(filePath);

      // Create a new file path in the app's data directory
      final String newFilePath = '${directory.path}/${selectedFile.uri.pathSegments.last}';

      // Copy the file to the new location
      final newFile = await selectedFile.copy(newFilePath);
      widget.onFileUploaded(newFile);

      // Update the state to reflect the file has been saved
      setState(() {
        _uploadProgress = 1; // Assuming the file is saved, set progress to 100%
        // You may also want to update other states or notify the user
      });
    } catch (e) {
      // Handle errors (e.g., file not found, no permission, etc.)
      if (kDebugMode) {
        print("Error saving file: $e");
      }
    }
  }

  void _deleteFile(BuildContext context, String fileName) {
    // Remove the file from the provider
    ref.read(uploadedFilesProvider).remove(fileName);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> uploadedFiles = ref.watch(uploadedFilesProvider);
    final borderColor =
        uploadedFiles.isNotEmpty ? AppColors.primary20 : AppColors.grayscale20;

    final fileWidgets = uploadedFiles.map((fileName) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            const Icon(
              Icons.file_copy_outlined,
              color: AppColors.primary30,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                fileName,
                style: AppFonts.body1(color: AppColors.grayscale90),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            if (_loading)
              Expanded(
                child: LinearProgressIndicator(
                  value: _uploadProgress,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary30,
                  ),
                  backgroundColor: AppColors.grayscale10,
                ),
              ),
            IconButton(
              onPressed: () => _deleteFile(context, fileName),
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.error100,
              ),
            ),
          ],
        ),
      );
    }).toList();

    final uploadButton = ElevatedButton(
      onPressed: _loading ? null : () => _chooseFile(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.grayscale0,
        elevation: 0,
        padding: const EdgeInsets.all(0),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(16),
            color: borderColor,
            strokeWidth: 1,
            dashPattern: const [12, 12],
            child: SizedBox(
              width: constraints.maxWidth,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: uploadedFiles.isNotEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.primary20,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Upload File. PDF, Jpeg, PNG",
                            style: AppFonts.body1(color: AppColors.primary20),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.grayscale50,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Upload File. PDF, Jpeg, PNG",
                            style: AppFonts.body1(color: AppColors.grayscale50),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );

    return Column(
      children: [
        uploadButton,
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: uploadedFiles.length,
            itemBuilder: (context, index) {
              return fileWidgets[index];
            },
          ),
        ),
      ],
    );
  }
}
