class CardData {
  final String title;
  final String? assetPath;
  final Function? onTap;

  CardData({
    required this.title,
    required this.assetPath,
    this.onTap,
  });
}
