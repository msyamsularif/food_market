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
                              .picturePath!,
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
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) => (state is FoodLoaded)
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: state.foods
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsets.only(
                                      left: (e == state.foods.first)
                                          ? defaultMargin
                                          : 0,
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
                                              user: (context
                                                      .read<UserCubit>()
                                                      .state as UserLoaded)
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
                      )
                    : Center(child: loadingIndicator),
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
                  BlocBuilder<FoodCubit, FoodState>(
                    builder: (context, state) {
                      if (state is FoodLoaded) {
                        List<Food> foods = state.foods
                            .where(
                              (element) => element.types.contains(
                                (selectedIndex == 0)
                                    ? FoodType.new_food
                                    : (selectedIndex == 1)
                                        ? FoodType.popular
                                        : FoodType.recommended,
                              ),
                            )
                            .toList();

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
                      } else {
                        return Center(
                          child: loadingIndicator,
                        );
                      }
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
