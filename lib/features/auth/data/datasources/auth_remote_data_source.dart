import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

/// Interface for remote authentication data source
abstract class AuthRemoteDataSource {
  /// Signs in a user with email and password
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  /// Registers a new user with email and password
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  });

  /// Signs out the current user
  Future<void> signOut();

  /// Resets the user's password
  Future<void> resetPassword({
    required String email,
  });

  /// Gets the current user data
  Future<UserModel> getCurrentUser();

  /// Checks if a user is signed in
  Future<bool> isSignedIn();
}

/// Implementation of [AuthRemoteDataSource] using Firebase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  /// Creates a new [AuthRemoteDataSourceImpl] instance
  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (userCredential.user == null) {
        throw ServerException(message: 'User not found');
      }
      
      final uid = userCredential.user!.uid;
      final userData = await _firestore.collection('users').doc(uid).get();
      
      if (!userData.exists) {
        throw ServerException(message: 'User data not found');
      }
      
      return UserModel.fromJson(userData.data()!);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (userCredential.user == null) {
        throw ServerException(message: 'Failed to create user');
      }
      
      final uid = userCredential.user!.uid;
      
      final userModel = UserModel(
        uid: uid,
        email: email,
        name: name,
        phone: phone,
        image: 'https://firebasestorage.googleapis.com/v0/b/travelapp-f3c48.appspot.com/o/users%2Fdefault_profile.png?alt=media',
        cover: 'https://firebasestorage.googleapis.com/v0/b/travelapp-f3c48.appspot.com/o/users%2Fdefault_cover.png?alt=media',
        bio: 'Write your bio...',
        isEmailVerified: false,
        followers: '',
        following: '',
      );
      
      await _firestore.collection('users').doc(uid).set(userModel.toJson());
      
      return userModel;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      
      if (currentUser == null) {
        throw ServerException(message: 'User not signed in');
      }
      
      final userData = await _firestore.collection('users').doc(currentUser.uid).get();
      
      if (!userData.exists) {
        throw ServerException(message: 'User data not found');
      }
      
      return UserModel.fromJson(userData.data()!);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      return _firebaseAuth.currentUser != null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
} 