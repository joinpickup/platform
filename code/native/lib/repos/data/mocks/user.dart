import 'package:local/repos/data/models/user/user.dart';

final user1 = User(
  hasSubscription: true,
  email: "acohen@joinpickup.com",
  password: "pickup123",
  userID: 1,
);

final user2 = User(
  hasSubscription: false,
  email: "bcorrell@joinpickup.com",
  password: "pickup123",
  userID: 2,
);

final user3 = User(
  hasSubscription: false,
  email: "jolivares@joinpickup.com",
  password: "pickup123",
  userID: 3,
);

final user4 = User(
  hasSubscription: true,
  email: "solivares@joinpickup.com",
  password: "pickup123",
  userID: 4,
);

final allUsers = [user1, user2, user3, user4];
