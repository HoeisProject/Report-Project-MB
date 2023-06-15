// import 'package:image_picker/image_picker.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'image_picker_utility.g.dart';

// @Riverpod(keepAlive: true)
// ImagePickerUtility imagePickerUtility(ImagePickerUtilityRef ref) {
//   return ImagePickerUtility(ImagePicker());
// }

// class ImagePickerUtility {
//   final ImagePicker _picker;

//   ImagePickerUtility(this._picker);

//   Future<XFile?> camera() async {
//     final image = await _picker.pickImage(source: ImageSource.camera);
//     return image;
//   }
//   Future<XFile?> gallery async () { _picker.pickImage(source: ImageSource.gallery);}

// }
