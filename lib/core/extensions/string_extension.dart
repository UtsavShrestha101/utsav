extension StringX on String {
  String mediaType() {
    final fileExtension = toString().split(".").last;
    if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
      return "IMAGE";
    } else if (fileExtension == "svg") {
      return "SVG";
    } else if (fileExtension.contains("gif")) {
      return "GIF";
    } else if (['mp4', 'avi', 'mkv', 'mov'].contains(fileExtension)) {
      return "VIDEO";
    } else {
      return "";
    }
  }
}
