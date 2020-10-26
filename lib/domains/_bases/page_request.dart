import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';

class PageRequest {
  int page;
  int size;
  Sort sort;

  PageRequest({
    this.page = Endpoint.defaultPage,
    this.size = Endpoint.defaultSize,
    this.sort = const Sort()
  });

  PageRequest.sort({
    this.page = Endpoint.defaultPage,
    this.size = Endpoint.defaultSize,
    String property,
    Direction direction
  }) {
    this.sort = Sort(
        property: property,
        direction: direction
    );
  }

  @override
  String toString() {
    return 'page=$page&size=$size&sort=$sort';
  }
}

class Sort {
  final String property;
  final Direction direction;

  const Sort({
    this.property = Endpoint.defaultProperty,
    this.direction = Endpoint.defaultDirection
  });

  @override
  String toString() {
    return '$property,' + (direction == Direction.DESC ? 'DESC' : 'ASC');
  }
}

enum Direction { DESC, ASC }