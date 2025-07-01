import 'package:halaqat_wasl_main_app/model/user_model/user_model.dart';
import 'package:halaqat_wasl_main_app/repo/user_operation/user_operation_repo.dart';

class UserData {

  UserModel? user;

  Future<void> loadDate() async{
    user = await UserOperationRepo.getUserDetailsFromDB();
  }
}