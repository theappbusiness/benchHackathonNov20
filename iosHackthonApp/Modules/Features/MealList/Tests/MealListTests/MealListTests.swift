import XCTest
@testable import MealList

final class MealListTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MealList().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
