
// TODO Implement this library.



import 'package:flutter/foundation.dart';

import '../datamodels/address.dart';

class AppData extends ChangeNotifier {
  Address pickupAddress;
  Address destinationAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }
    void updateDestinationAddress(Address destination) {
      destinationAddress = destination;
      notifyListeners();
    }
  }