import ComposableArchitecture
import XCTest

@testable import CounterApp

final class CounterFeatureTests: XCTestCase {
  func testTimer() async {
    let store = await TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    }
    
    await store.send(.toggleTimerButtonTapped) {
      $0.isTimerRunning = true
    }
    await store.receive(\.timerTick) {
      $0.count = 1
    }
    await store.send(.toggleTimerButtonTapped) {
      $0.isTimerRunning = false
    }
  }
}
