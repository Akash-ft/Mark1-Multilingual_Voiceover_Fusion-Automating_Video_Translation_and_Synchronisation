enum MediaFormatType {
  video,
  image,
  audio,
}

enum TargetedSourceType {
  gallery,
  camara,
}

enum RecordingState {
  Start,
  Stop,
}

final Map<MediaFormatType, int> mediaFormatValues = {
  MediaFormatType.video: 1,
  MediaFormatType.image: 2,
  MediaFormatType.audio: 3,
};

final Map<TargetedSourceType, int> targetedSourceValues = {
  TargetedSourceType.gallery: 1,
  TargetedSourceType.camara: 2,
};

final Map<RecordingState, int> recordingStateValues = {
  RecordingState.Start: 1,
  RecordingState.Stop: 2,

};