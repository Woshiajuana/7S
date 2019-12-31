
import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

// 个人中心刷新事件
class MineEvent {
  MineEvent();
}

// 照片列表刷新事件
class PhotoListEvent {
  PhotoListEvent();
}

// table 上下页
class WowCalendar {
  WowCalendar(bool isNext);
}