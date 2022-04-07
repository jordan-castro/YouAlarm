typedef YoutubeExtensions = dynamic;

extension YoutubeHelp on String {
  /// Takes in a ID and returns a URL to the video
  String createYoutubeUrl<String>() {
    return "https://www.youtube.com/watch?v=$this" as String;
  }

  /// Get the video id from a URL
  String videoIdFromUrl<String>() {
    if (contains("youtube.com")) {
      return split("v=")[1].split("&")[0] as String;
    } else if (contains("youtu.be")) {
      return split("youtu.be/")[1] as String;
    } else {
      return this as String;
    }
  }
}