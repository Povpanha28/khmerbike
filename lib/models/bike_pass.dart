enum PassType { monthly, daily, annual, oneTime }

class BikePass {
  final PassType type;
  final String id;
  final Duration duration;
  final double price;

  BikePass({
    required this.type,
    required this.id,
    required this.duration,
    required this.price,
  });

  @override
  String toString() {
    return 'BikePass{type: $type, id: $id, duration: $duration, price: $price}';
  }
}
