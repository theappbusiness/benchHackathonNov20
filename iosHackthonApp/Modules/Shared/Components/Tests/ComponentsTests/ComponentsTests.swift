import XCTest
@testable import Components

final class ComponentsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Components().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
