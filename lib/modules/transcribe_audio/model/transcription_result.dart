class TranscriptionResult {
  final String transcript;
  final double confidence;
  final List<WordData> words;

  TranscriptionResult({
    required this.transcript,
    required this.confidence,
    required this.words,
  });

  // Factory method to create TranscriptionResult from JSON
  factory TranscriptionResult.fromJson(Map<String, dynamic> json) {
    var wordsList = json['words'] as List<dynamic>? ?? [];
    List<WordData> words =
    wordsList.map((word) => WordData.fromJson(word)).toList();

    return TranscriptionResult(
      transcript: json['transcript'] ?? '',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      words: words,
    );
  }

  // Convert TranscriptionResult to JSON
  Map<String, dynamic> toJson() {
    return {
      'transcript': transcript,
      'confidence': confidence,
      'words': words.map((word) => word.toJson()).toList(),
    };
  }
}

class WordData {
  final String word;
  final double start;
  final double end;
  final double confidence;

  WordData({
    required this.word,
    required this.start,
    required this.end,
    required this.confidence,
  });

  // Factory method to create WordData from JSON
  factory WordData.fromJson(Map<String, dynamic> json) {
    return WordData(
      word: json['word'] ?? '',
      start: (json['start'] as num?)?.toDouble() ?? 0.0,
      end: (json['end'] as num?)?.toDouble() ?? 0.0,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Convert WordData to JSON
  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'start': start,
      'end': end,
      'confidence': confidence,
    };
  }
}
