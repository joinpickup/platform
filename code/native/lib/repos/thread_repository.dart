import 'package:local/repos/data/models/message/thread.dart';

List<Thread> allThreads = [];

List<Thread> currentThreads = [];

List<Thread> requestThreads = [];

List<Thread> hiddenThreads = [];

class ThreadRepository {
  Future<List<Thread>> getCurrentThreads() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return currentThreads;
  }

  Future<List<Thread>> getRequestThreads() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return requestThreads;
  }

  Future<List<Thread>> getHiddenThreads() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return hiddenThreads;
  }
}
