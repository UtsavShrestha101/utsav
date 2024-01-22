import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'select_post_state.dart';

@injectable
class SelectPostCubit extends Cubit<SelectPostState> {
  final ImagePicker imagePicker;
  SelectPostCubit(this.imagePicker) : super(Initial());

  void pickImage() async {
    try {
      emit(MediaPickInProgress());
      final file = await imagePicker.pickMedia();
      if (file != null) {
        emit(MediaPicked(file));
      } else {
        emit(MediaPickedFailed('please select an image to continue'));
      }
    } on PlatformException catch (e) {
      emit(MediaPickedFailed(_mapInvalidImageError(e)));
    }
  }

  String _mapInvalidImageError(PlatformException error) {
    switch (error.code) {
      case 'invalid_source':
        return 'Invalid image source.';
      case 'invalid_image':
        return 'The selected image is corrupted or in an unsupported format.';
      case 'image_too_large':
        return 'The selected image is too large. Try selecting a smaller image.';
      default:
        return 'An error occurred while picking the image.';
    }
  }
}
