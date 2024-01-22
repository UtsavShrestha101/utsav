import 'package:saro/core/flavor/flavor.dart';
import 'package:saro/core/flavor/flavor_config.dart';
import 'package:saro/core/flavor/flavor_values.dart';

import 'bootstrap.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    values: FlavorValues(
      baseUrl: 'https://api-dev.saro.love/v1',
      socketUrl: 'https://socket-dev.saro.love',
    ),
  );
  bootstrap();
}
