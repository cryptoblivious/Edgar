class Pricing {
  List<double> prices = [];
  double? lowestPrice;
  double? averagePrice;

  Pricing({required this.prices}) {
    lowestPrice = prices.reduce((value, element) => value < element ? value : element);
    averagePrice = prices.reduce((value, element) => value + element) / prices.length;
  }
}
