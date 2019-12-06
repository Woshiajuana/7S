
import 'package:scoped_model/scoped_model.dart';
import 'package:qimiao/model/state/user.state.model.dart';


class StateModel extends Model with UserStateModel {
  static StateModel of(context) => ScopedModel.of<StateModel>(context, rebuildOnChange: true);
}