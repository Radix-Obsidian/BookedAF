import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app/models/user_models.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a professional profile
  static Future<void> createProfessionalProfile(BusinessProfile businessProfile) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    // Create user profile with professional role
    final userProfile = UserProfile(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoURL: user.photoURL,
      role: UserRole.beautyProfessional,
      businessProfile: businessProfile,
    );

    // Save to Firestore
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(userProfile.toJson());

    // Also create a separate professional document for easier querying
    await _firestore
        .collection('professionals')
        .doc(user.uid)
        .set({
      'uid': user.uid,
      'businessName': businessProfile.businessName,
      'serviceCategories': businessProfile.serviceCategories,
      'serviceAddress': businessProfile.serviceAddress.toJson(),
      'isVerified': businessProfile.isVerified,
      'createdAt': businessProfile.createdAt.toIso8601String(),
      'isActive': true,
    });
  }

  // Create a customer profile
  static Future<void> createCustomerProfile({String? phoneNumber}) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    final customerProfile = CustomerProfile(
      phoneNumber: phoneNumber,
      favoriteServices: [],
      createdAt: DateTime.now(),
    );

    final userProfile = UserProfile(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoURL: user.photoURL,
      role: UserRole.customer,
      customerProfile: customerProfile,
    );

    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(userProfile.toJson());
  }

  // Get user profile
  static Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserProfile.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  // Check if user has completed profile setup
  static Future<bool> hasCompletedProfile(String uid) async {
    final profile = await getUserProfile(uid);
    return profile != null;
  }

  // Update business profile
  static Future<void> updateBusinessProfile(String uid, BusinessProfile businessProfile) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .update({
      'businessProfile': businessProfile.toJson(),
    });

    // Update professional document
    await _firestore
        .collection('professionals')
        .doc(uid)
        .update({
      'businessName': businessProfile.businessName,
      'serviceCategories': businessProfile.serviceCategories,
      'serviceAddress': businessProfile.serviceAddress.toJson(),
    });
  }

  // Get all professionals (for customer discovery)
  static Future<List<UserProfile>> getAllProfessionals() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: UserRole.beautyProfessional.toString())
          .get();

      return querySnapshot.docs
          .map((doc) => UserProfile.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting professionals: $e');
      return [];
    }
  }

  // Search professionals by service category
  static Future<List<UserProfile>> searchProfessionals(String serviceCategory) async {
    try {
      final querySnapshot = await _firestore
          .collection('professionals')
          .where('serviceCategories', arrayContains: serviceCategory)
          .where('isActive', isEqualTo: true)
          .get();

      // Get full profiles for matching professionals
      List<UserProfile> professionals = [];
      for (var doc in querySnapshot.docs) {
        final profile = await getUserProfile(doc.id);
        if (profile != null) {
          professionals.add(profile);
        }
      }

      return professionals;
    } catch (e) {
      print('Error searching professionals: $e');
      return [];
    }
  }
}