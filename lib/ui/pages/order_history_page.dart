part of 'pages.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int selectedIndex = 0;
  List<Transaction> inProgress = mockTransactions
      .where((element) =>
          element.status == TransactionStatus.on_delivery ||
          element.status == TransactionStatus.pending)
      .toList();

  List<Transaction> past = mockTransactions
      .where((element) =>
          element.status == TransactionStatus.delivered ||
          element.status == TransactionStatus.cancelled)
      .toList();

  @override
  Widget build(BuildContext context) {
    if (inProgress.length == 0 && past.length == 0) {
      return IllustrationPage(
        title: 'Ouch! Hungry',
        subTitle: 'Seems you like have not\nordered any food yet',
        picturePath: 'assets/love_burger.png',
        buttonTitle1: 'Find Foods',
        buttonTap1: () {},
      );
    } else {
      double listItemWidth =
          MediaQuery.of(context).size.width - 2 * defaultMargin;
      return ListView(
        children: [
          Column(
            children: [
              /// Head
              Container(
                height: 100,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: defaultMargin),
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your Orders", style: blackFontStyle1),
                    Text(
                      "Wait for the best meal",
                      style:
                          greyFontStyle.copyWith(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),

              /// Body
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    CustomeTabBar(
                      selectedIndex: selectedIndex,
                      titles: ['In Progress', 'Past Orders'],
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: (selectedIndex == 0 ? inProgress : past)
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(
                                right: defaultMargin,
                                left: defaultMargin,
                                bottom: 16,
                              ),
                              child: OrderListItem(
                                transaction: e,
                                itemWidth: listItemWidth,
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      );
    }
  }
}
