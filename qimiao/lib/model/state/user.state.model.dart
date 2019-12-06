
import 'package:qimiao/model/json/user.json.model.dart';
import 'package:scoped_model/scoped_model.dart';


abstract class UserStateModel extends Model {

  UserJsonModel _userJsonModel;
  UserJsonModel get user => _userJsonModel;

  void setUserJsonModel(UserJsonModel userJsonModel){
    _userJsonModel = userJsonModel;
    notifyListeners();
  }

}