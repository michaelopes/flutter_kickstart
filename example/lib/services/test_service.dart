abstract class ITestService {
  void run();
}

class TestService extends ITestService {
  @override
  void run() {
    print("TestService called");
  }
}
