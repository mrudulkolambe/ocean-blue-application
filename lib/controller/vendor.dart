import 'package:get/state_manager.dart';
import 'package:ocean_blue/models/Auth.dart';

class VendorController extends GetxController {
  Vendor vendor = Vendor(
    fullname: "",
    id: "",
    companyName: "",
    email: "",
    isVerified: false,
    phoneNo: "",
    timeStamp: 0,
    role: "vendor",
    image: ""
  );

  void updateVendor(Vendor data) {
    vendor = data;
    update();
  }
}
