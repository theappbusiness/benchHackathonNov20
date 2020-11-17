import XCTest
@testable import AddMeal

final class AddMealTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AddMeal().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
