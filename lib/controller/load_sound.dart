import 'package:youalarm/controller/sound.dart';
import 'package:youalarm/utils/youtube_extensions.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// Load the videos MP3 stream
Future<Sound> loadSoud(String url) async {
  var yt = YoutubeExplode();

  // Load the video
  var video = await yt.videos.get(url);

  // Get the data
  var title = video.title;
  var duration = video.duration;
  var thumbnail = video.thumbnails.standardResUrl;

  var streamInfo = await getStream(yt, url.videoIdFromUrl());

  return Sound(
    duration: duration,
    title: title,
    yId: url.videoIdFromUrl(),
    thumbnail: thumbnail,
    streamInfo: streamInfo,
  );
}

Future<AudioOnlyStreamInfo> getStream(YoutubeExplode yt, String id) async {
  var manifest = await yt.videos.streamsClient.getManifest(id);
  var streamInfo = manifest.audioOnly.withHighestBitrate();

  return streamInfo;
}
