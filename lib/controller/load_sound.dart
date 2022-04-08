import 'package:youalarm/controller/sound.dart';
import 'package:youalarm/utils/files.dart';
import 'package:youalarm/utils/random_name.dart';
import 'package:youalarm/utils/youtube_extensions.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// Load the videos MP3 stream
Future<Sound> loadSound(String url) async {
  var yt = YoutubeExplode();

  // Load the video
  var video = await yt.videos.get(url);

  var streamInfo = await getStream(yt, url.videoIdFromUrl());

  yt.close();

  return Sound(
    duration: video.duration,
    title: video.title,
    yId: url.videoIdFromUrl(),
    thumbnail: video.thumbnails.highResUrl,
    streamInfo: streamInfo,
    author: video.author
  );
}

Future<AudioOnlyStreamInfo> getStream(YoutubeExplode yt, String id) async {
  var manifest = await yt.videos.streamsClient.getManifest(id);
  var streamInfo = manifest.audioOnly.withHighestBitrate();

  return streamInfo;
}

/// Save the stream to a File.
///
/// Returns file path.
Future<String> saveStream(AudioOnlyStreamInfo streamInfo) async {
  var yt = YoutubeExplode();

  // Get the actual stream
  var stream = yt.videos.streamsClient.get(streamInfo);

  var file = await createNewFile(randomName(5));
  var fileStream = file.openWrite();

  // Load the bytes
  await stream.pipe(fileStream);

  // Close file
  await fileStream.flush();
  await fileStream.close();

  // Close YT
  yt.close();

  return file.path;
}
