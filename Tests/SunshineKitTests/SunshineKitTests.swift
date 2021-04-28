import XCTest
@testable import SunshineKit

final class SunshineKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SunshineKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
