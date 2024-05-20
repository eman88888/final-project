import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart'; // Added for file saving paths

part 'convert_state.dart';

class ConvertCubit extends Cubit<ConvertState> {
  ConvertCubit() : super(ConvertInitial());
  static ConvertCubit get(context) => BlocProvider.of(context);
  String pdbData = '';
  String sdf2dData = '';

  Future<void> convertAndDownload(String convert) async {
    const String apiUrl = 'http://127.0.0.1:5000/convert';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': convert}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        sdf2dData = data['sdf2d'];
        emit(sdfsucsses());
        // ignore: avoid_print
        print('...........$sdf2dData');

        // Get the directory for saving files
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath = '${appDocDir.path}/molecule.sdf';

        // Save the SDF2D data to a file
        final File file = File(filePath);
        await file.writeAsString(sdf2dData);
        sdf2dData = 'Molecule data saved successfully';
        emit(sdfsucssessave());
      } else {
        // ignore: avoid_print
        print('Error: ${response.statusCode}');
        sdf2dData = 'Error: ${response.statusCode}';
        emit(sdffailed());
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      sdf2dData = 'Error: $e';
      emit(sdffailedsave());
    }
  }

  Future<void> convertAndDownloadpdb(String convert) async {
    const String apiUrl = 'http://127.0.0.1:5000/generate_pdb';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': convert}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        pdbData = data['pdb'];
        emit(pdbsucsess());
        
        // Get the directory for saving files
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath = '${appDocDir.path}/molecule.pdb';

        // Save the PDB data to a file
        final File file = File(filePath);
        await file.writeAsString(pdbData);
        pdbData = 'Molecule data saved to molecule.pdb';
        emit(pdbsucsesssave());
      } else {
        // ignore: avoid_print
        print('Error: ${response.statusCode}');
        pdbData = 'Error: ${response.statusCode}';
        emit(pdpfailed());
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      pdbData = 'Error: $e';
      emit(pdpfailedsave());
    }
  }

  PlatformFile? selectedFile;
  Future<void> uploadFile(BuildContext context) async {
    if (selectedFile == null) {
      // Handle case when no file is selected
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:5000/converttosmile'), // Update URL accordingly
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          selectedFile!.bytes!,
          filename: selectedFile!.name,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful conversion
        // For other platforms, show a SnackBar with download message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File downloaded successfully'),
          ),
        );
      } else {
        // Handle other status codes
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Handle errors
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }
}
