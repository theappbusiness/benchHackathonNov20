//
//  Strings+extensionTests.swift
//  iosHackthonAppTests
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import XCTest
@testable import iosHackthonApp

class StringsExtensionTests: XCTestCase {

    func test_last4Chars_asLetters_returnsCorrectString() {
        XCTAssertEqual("12abcdefg".last4Chars(), "DEFG")
    }

    func test_last4Chars_asNumbers_returnsCorrectString() {
        XCTAssertEqual("abcg1212".last4Chars(), "1212")
    }

    func test_last4Chars_asCombined_returnsCorrectString() {
        XCTAssertEqual("abcg12".last4Chars(), "CG12")
    }
}
