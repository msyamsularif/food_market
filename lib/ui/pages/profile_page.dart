part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            //// Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              height: 220,
              margin: EdgeInsets.only(bottom: defaultMargin),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/photo_border.png'),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                              (context.read<UserCubit>().state as UserLoaded)
                                  .user
                                  .picturePath!,
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Text(
                    (context.read<UserCubit>().state as UserLoaded).user.name!,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    (context.read<UserCubit>().state as UserLoaded).user.email!,
                    style: greyFontStyle.copyWith(fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
            //// Body
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                    titles: ["Account", "FoodMarket"],
                    selectedIndex: selectedIndex,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: ((selectedIndex == 0)
                            ? [
                                'Edit Profile',
                                'Home Address',
                                'Security',
                                'Payment'
                              ]
                            : [
                                'Rate App',
                                'Help Center',
                                'Privacy & Policy',
                                'Term & Condition'
                              ])
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(
                              bottom: 16,
                              left: defaultMargin,
                              right: defaultMargin,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e,
                                  style: blackFontStyle3,
                                ),
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                    'assets/right_arrow.png',
                                    fit: BoxFit.contain,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(defaultMargin),
          child: isLoading
              ? loadingIndicator
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await context.read<UserCubit>().logOut();

                    UserState state = context.read<UserCubit>().state;

                    if (state is UserInitial) {
                      Get.offAll(() => SignInPage());
                    } else {
                      Get.showSnackbar(
                        GetBar(
                          backgroundColor: "D9435E".toColor(),
                          icon: Icon(
                            MdiIcons.closeCircleOutline,
                            color: Colors.white,
                          ),
                          titleText: Text(
                            "Log Out Failed",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          messageText: Text(
                            (state as UserLoadingFailed).message,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Text("Log Out"),
                ),
        ),
      ],
    );
  }
}
