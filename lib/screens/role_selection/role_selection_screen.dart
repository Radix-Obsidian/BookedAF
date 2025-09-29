import 'package:flutter/material.dart';
import 'package:salon_app/screens/registration/professional_registration_screen.dart';
import 'package:salon_app/components/bottom_navigationbar.dart';
import 'package:salon_app/models/user_models.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff721c80),
              Color.fromARGB(255, 196, 103, 169),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Welcome to BookedAF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Choose how you\'ll use the app',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                
                // Customer Option
                _buildRoleCard(
                  context: context,
                  title: 'I\'m looking for beauty services',
                  subtitle: 'Book appointments with salons and beauty professionals',
                  icon: Icons.person_outline,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigationComponent(),
                      ),
                    );
                  },
                  isCustomer: true,
                ),
                
                const SizedBox(height: 24),
                
                // Professional Option
                _buildRoleCard(
                  context: context,
                  title: 'I\'m a beauty professional',
                  subtitle: 'Grow your business and manage clients from home or salon',
                  icon: Icons.business_center_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfessionalRegistrationScreen(),
                      ),
                    );
                  },
                  isCustomer: false,
                ),
                
                const Spacer(),
                
                const Text(
                  'You can change this later in your profile settings',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required bool isCustomer,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isCustomer 
                    ? const Color(0xff721c80).withOpacity(0.1)
                    : const Color.fromARGB(255, 196, 103, 169).withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                icon,
                size: 40,
                color: isCustomer 
                    ? const Color(0xff721c80)
                    : const Color.fromARGB(255, 196, 103, 169),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff721c80),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}