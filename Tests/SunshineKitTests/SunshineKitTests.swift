import XCTest
import CoreLocation
@testable import SunshineKit

final class SunshineKitTests: XCTestCase {
    func test_fetchWeatherForLocation() {
        let location = CLLocation(latitude: .init(51.5), longitude: -0.07)
        let c = SunshineKit.shared
            .weather(for: location)
            .sink { c in
                print(c)
            } receiveValue: { result in
                print(result)
            }
    }

    static var allTests = [
        ("testExample", test_fetchWeatherForLocation),
    ]
}
