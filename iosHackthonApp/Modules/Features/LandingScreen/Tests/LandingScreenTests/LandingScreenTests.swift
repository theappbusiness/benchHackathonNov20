import XCTest
@testable import LandingScreen

final class LandingScreenTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LandingScreen().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
