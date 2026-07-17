class PaymentOption {
  final String title;
  final String  image;

  const PaymentOption({
    required this.title,
    required this.image,

});
}
class PaymentMethods{
  static const List<PaymentOption> options =[
    PaymentOption(title: "G-pay", image: "assets/payment_icons/gpay.png"),
    PaymentOption(title: "phone pe", image: "assets/payment_icons/phone_pe.png"),
    PaymentOption(title: "Amazon pay", image: "assets/payment_icons/amazon_pay.png"),
    PaymentOption(title: "Debit/Credit Card", image: "assets/payment_icons/card.png"),
    PaymentOption(title: "Cash on Delivery", image: "assets/payment_icons/cod.png"),

  ];

}