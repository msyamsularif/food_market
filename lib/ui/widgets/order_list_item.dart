part of 'widgets.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    Key? key,
    required this.transaction,
    required this.itemWidth,
  }) : super(key: key);

  final Transaction transaction;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(transaction.food.picturePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: itemWidth - 182,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.food.name,
                style: blackFontStyle2,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
              Text(
                "${transaction.quantity} items(s)" +
                    NumberFormat.currency(
                      symbol: 'IDR ',
                      decimalDigits: 0,
                      locale: 'id-ID',
                    ).format(transaction.total),
                style: greyFontStyle.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                convertDateTime(transaction.dateTime),
                style: greyFontStyle.copyWith(fontSize: 12),
              ),
              (transaction.status == TransactionStatus.cancelled)
                  ? Text(
                      "Cancelled",
                      style: GoogleFonts.poppins(
                        color: 'D9435E'.toColor(),
                        fontSize: 10,
                      ),
                    )
                  : (transaction.status == TransactionStatus.pending)
                      ? Text(
                          "Pending",
                          style: GoogleFonts.poppins(
                            color: 'D9435E'.toColor(),
                            fontSize: 10,
                          ),
                        )
                      : (transaction.status == TransactionStatus.on_delivery)
                          ? Text(
                              "On Delivery",
                              style: GoogleFonts.poppins(
                                color: '1ABC9C'.toColor(),
                                fontSize: 10,
                              ),
                            )
                          : SizedBox()
            ],
          ),
        )
      ],
    );
  }

  String convertDateTime(DateTime dateTime) {
    String mount;

    switch (dateTime.month) {
      case 1:
        mount = 'Jan';
        break;
      case 2:
        mount = 'Feb';
        break;
      case 3:
        mount = 'Mar';
        break;
      case 4:
        mount = 'Apr';
        break;
      case 5:
        mount = 'May';
        break;
      case 6:
        mount = 'Jun';
        break;
      case 7:
        mount = 'Jul';
        break;
      case 8:
        mount = 'Aug';
        break;
      case 9:
        mount = 'Sep';
        break;
      case 10:
        mount = 'Oct';
        break;
      case 11:
        mount = 'Nov';
        break;
      default:
        mount = 'Des';
    }
    return mount + ' ${dateTime.day}, ${dateTime.hour}:${dateTime.minute}';
  }
}
