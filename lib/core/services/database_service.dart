import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:injectable/injectable.dart';
import 'package:saro/core/models/credentials.dart';
import 'package:saro/core/models/dark_mode.dart';
import 'package:saro/core/models/spotify_detail.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
import 'package:saro/core/models/user.dart';

@singleton
class LocalDatabaseService {
  final FlutterSecureStorage _secureStorage;

  LocalDatabaseService(this._secureStorage);

  late Box<Credentials> _credentialsBox;
  late Box<User> _userBox;
  late Box<bool> _isUserConnectedToSpotify;
  late Box<AppThemeState> _appThemeStateBox;
  late Box<SpotifyDetail> _spotifyDetailBox;

  @PostConstruct(preResolve: true)
  Future<void> initialize() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openBoxes();
  }

  // **************************************************************************
  // Open box here
  // **************************************************************************
  Future<void> _openBoxes() async {
    _credentialsBox = await _openEncryptedBox('credentialsBox');
    _userBox = await Hive.openBox('user');
    _isUserConnectedToSpotify = await Hive.openBox("spotifyAuthStateBox");
    _appThemeStateBox = await Hive.openBox("app_theme_state_box");
    _spotifyDetailBox = await Hive.openBox('spotifyDetailBox');
  }

  // **************************************************************************
  // Register Adapter
  // **************************************************************************
  void _registerAdapters() {
    Hive.registerAdapter(CredentialsAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(CreditCardAdapter());
    Hive.registerAdapter(AppThemeStateAdapter());

    // spotify track adaptars
    Hive.registerAdapter(SpotifySearchedTrackAdapter());
    Hive.registerAdapter(ArtistAdapter());

    // spotify detail adaptars
    Hive.registerAdapter(SpotifyDetailAdapter());
    Hive.registerAdapter(FollowersAdapter());
    Hive.registerAdapter(ImageAdapter());
  }

  // **************************************************************************
  // Helper Functions
  // **************************************************************************

  Future<Uint8List> _getOrCreateEncryptionKey() async {
    const hiveEncryptionKey = 'hiveEncryptionKey';
    var encryptionKey = await _secureStorage.read(key: hiveEncryptionKey);
    if (encryptionKey == null) {
      final key = Hive.generateSecureKey();
      await _secureStorage.write(
          key: hiveEncryptionKey, value: base64UrlEncode(key));
      encryptionKey = await _secureStorage.read(key: hiveEncryptionKey);
    }

    return base64Url.decode(encryptionKey!);
  }

  Future<Box<E>> _openEncryptedBox<E>(String name) async {
    final encryptionKey = await _getOrCreateEncryptionKey();

    return Hive.openBox<E>(name,
        encryptionCipher: HiveAesCipher(encryptionKey));
  }

  // **************************************************************************
  // Database Functions
  // **************************************************************************

  Future<void> setCredentials(Credentials credentials) =>
      _credentialsBox.put('userCredentials', credentials);

  Credentials? get credentials => _credentialsBox.get('userCredentials');

  Future<void> setCurrentUser(User currentUser) =>
      _userBox.put('currentUser', currentUser);

  User? get currentUser => _userBox.get('currentUser');

  Future<void> clearCredentials() async {
    _credentialsBox.clear();
    _isUserConnectedToSpotify.clear();
     clearSpotifyData();
  }

  Future<void> setSpotifyAuthState(bool newAuthState) =>
      _isUserConnectedToSpotify.put('spotifyAuthState', newAuthState);

  bool? get getSpotifyAuthState =>
      _isUserConnectedToSpotify.get('spotifyAuthState', defaultValue: false);

  Future<void> setAppThemeStateValue(AppThemeState themeState) {
    return _appThemeStateBox.put("app_theme_state", themeState);
  }

  AppThemeState? get getAppThemeStateValue => _appThemeStateBox
      .get("app_theme_state", defaultValue: AppThemeState.light);

  Future<void> setSpotifyDetail(SpotifyDetail spotifyDetail) async {
    await _spotifyDetailBox.put('spotifyDetail', spotifyDetail);
  }

  SpotifyDetail? get spotifyDetail => _spotifyDetailBox.get(
        'spotifyDetail',
      );

  void clearSpotifyData() async {
   await _spotifyDetailBox.clear();
  }
}
