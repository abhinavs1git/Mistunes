import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mistunes/models/song.dart';

class PlayListProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "As It Was",
        artistName: "Harry Styles",
        albumArtImagePath: "assets/images/asitwas.png",
        audioPath: "audio/asit.mp3"),
    Song(
        songName: "Daylight",
        artistName: "David Kushner",
        albumArtImagePath: "assets/images/Daylight.png",
        audioPath: "audio/Daylight.mp3"),
    Song(
        songName: "I Like Me Better",
        artistName: "Lauv",
        albumArtImagePath: "assets/images/better.png",
        audioPath: "audio/better.mp3"),
    Song(
        songName: "Everything black",
        artistName: "Unlike Pluto, Mike Taylor",
        albumArtImagePath: "assets/images/black.png",
        audioPath: "audio/black.mp3"),
    Song(
        songName: "Past Lives",
        artistName: "BØRNS",
        albumArtImagePath: "assets/images/past.png",
        audioPath: "audio/past.mp3"),
    Song(
        songName: "Colors",
        artistName: "Halsey",
        albumArtImagePath: "assets/images/colo.png",
        audioPath: 'audio/colo.mp3'),
    Song(
        songName: "A Sky Full of Stars",
        artistName: "Coldplay",
        albumArtImagePath: "assets/images/sky.png",
        audioPath: "audio/sky.mp3"),
    Song(
        songName: "8 Letters",
        artistName: "Why Don't We",
        albumArtImagePath: "assets/images/eight.png",
        audioPath: "audio/eight.mp3"),
    Song(
        songName: "Centuries",
        artistName: "Fall Out Boy",
        albumArtImagePath: "assets/images/cent.png",
        audioPath: 'audio/cent.mp3'),
    Song(
        songName: "Home",
        artistName: "MGK, X Ambassadors, Bebe Rexha",
        albumArtImagePath: "assets/images/homem.png",
        audioPath: "audio/homem.mp3"),
    Song(
        songName: "Stereo Hearts",
        artistName: "Gym Class Heroes, Adam Levine",
        albumArtImagePath: "assets/images/ster.png",
        audioPath: "audio/ster.mp3"),
    Song(
        songName: "Soldier, Poet, King",
        artistName: "The Oh Hellos",
        albumArtImagePath: "assets/images/poetking.png",
        audioPath: "audio/poetking.mp3")
  ];
  int? _currentSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlayListProvider() {
    listenToDuration();
  }
  bool _isPlaying = false;
  void play() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    // ignore: unnecessary_null_comparison
    if (_currentDuration != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
      play();
    }
  }

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newDuration) {
      _currentDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
