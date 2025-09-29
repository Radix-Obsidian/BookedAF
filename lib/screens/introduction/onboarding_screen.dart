import 'package:flutter/material.dart';
import 'package:salon_app/screens/role_selection/role_selection_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  ScrollController controller = ScrollController();
  double controllerOffset = 0.0;
  int index = 0;
  
  void move() {
    controller.animateTo(controllerOffset + 392,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 500));
  }

  bool isRev = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      move();
      setState(() {
        controllerOffset += 392;
      });
    });

    Future.delayed(const Duration(seconds: 8), () {
      move();
      setState(() {
        controllerOffset += 392;
      });
    });
    super.initState();
  }

  List imgUrl = [
    "https://thumbs.dreamstime.com/b/hairdresser-protective-mask-cutting-hair-curly-african-american-client-beauty-salon-free-space-195792989.jpg",
    "https://as2.ftcdn.net/v2/jpg/02/65/48/75/1000_F_265487582_hg1t4uvUI33fhRDTdxVyHTNjv0F5WdX4.jpg",
    "https://www.nextinsurance.com/wp-content/uploads/2018/05/shutterstock_256912663-802x454.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 600,
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
            child: ListView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: 392,
                      height: 600,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            imgUrl[index],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 392,
                      height: 600,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff721c80).withOpacity(0.7),
                            const Color.fromARGB(255, 196, 103, 169).withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Professional Beauty Services",
            style: TextStyle(
              color: Color(0xff721c80),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: const Text(
              "Book appointments with top beauty professionals or grow your own beauty business from home",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(32),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoleSelectionScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff721c80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              reverse: isRev,
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: imgUrl
                      .map((e) => BannerImages(
                            height: height,
                            width: width,
                            image: e,
                          ))
                      .toList()),
            ),
            SingleChildScrollView(
              reverse: isRev,
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      height: 5,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controllerOffset < 300
                              ? const Color(0xff721c80).withOpacity(0.8)
                              : Colors.grey.withOpacity(0.8)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      height: 5,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              300 < controllerOffset && controllerOffset < 600
                                  ? const Color(0xff721c80).withOpacity(0.8)
                                  : Colors.grey.withOpacity(0.8)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      height: 5,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              600 < controllerOffset && controllerOffset < 800
                                  ? const Color(0xff721c80).withOpacity(0.8)
                                  : Colors.grey.withOpacity(0.8)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              "The Professional Specialists",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "choose your hairStyle choose your hair\n          style choose your hairStyle",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            GestureDetector(
              onTap: () {
                Authentication.signInWithGoogle(context: context)
                    .then(((value) {
                  if (value != null) {
                    userProvider.setUser(value);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const BottomNavigationComponent()),
                    );
                  }
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                height: 50,
                width: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff721c80),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff721c80),
                      Color.fromARGB(255, 196, 103, 169),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                    child: Text(
                  "Get Started",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ));
  }
}

class BannerImages extends StatelessWidget {
  final String image;
  const BannerImages({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.8 * (height / 3),
      width: width,
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
