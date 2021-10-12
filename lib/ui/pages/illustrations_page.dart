part of 'pages.dart';

class IllustrationPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final String picturePath;
  final String buttonTitle1;
  final String? buttonTitle2;
  final Function buttonTap1;
  final Function? buttonTap2;

  const IllustrationPage({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.picturePath,
    required this.buttonTitle1,
    this.buttonTitle2,
    required this.buttonTap1,
    this.buttonTap2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(picturePath),
              ),
            ),
          ),
          Text(
            title,
            style: blackFontStyle3.copyWith(fontSize: 20),
          ),
          Text(
            subTitle,
            style: greyFontStyle.copyWith(fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 12),
            width: 200,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text(
                buttonTitle1,
                style: blackFontStyle3.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          if (buttonTap2 != null)
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: '8D92A3'.toColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  buttonTitle2 ?? "title",
                  style: blackFontStyle3.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
