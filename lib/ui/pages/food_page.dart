part of 'pages.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;
    return ListView(
      children: [
        Column(
          children: [
            //// HEADER
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white,
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Food Market",
                        style: blackFontStyle1,
                      ),
                      Text(
                        "Let's get some foods",
                        style: greyFontStyle.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .picturePath,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
            //// LIST OF FOOD
            Container(
              height: 258,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: mockFoods
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(
                              left: (e == mockFoods.first) ? defaultMargin : 0,
                              right: defaultMargin,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => FoodDetailsPage(
                                    onBackButtonPressed: () {
                                      Get.back();
                                    },
                                    transaction: Transaction(
                                      food: e,
                                      user: (context.read<UserCubit>().state
                                              as UserLoaded)
                                          .user,
                                    ),
                                  ),
                                );
                              },
                              child: FoodCard(food: e),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
            //// LIST OF FOOD (TABS)
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                    selectedIndex: selectedIndex,
                    titles: ["New Taste", "Popular", "Recommended"],
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Builder(
                    builder: (_) {
                      List<Food> foods = (selectedIndex == 0)
                          ? mockFoods
                          : (selectedIndex == 1)
                              ? []
                              : [];

                      return Column(
                        children: foods
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  defaultMargin,
                                  0,
                                  defaultMargin,
                                  16,
                                ),
                                child: FoodListItem(
                                  food: e,
                                  itemWidth: listItemWidth,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        )
      ],
    );
  }
}
