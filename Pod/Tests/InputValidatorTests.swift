import UIKit
import XCTest
import Validation

class InputValidatorTests: XCTestCase {
    func testNullability() {
        let validation = Validation()
        let validator = InputValidator(validation: validation)
        XCTAssertTrue(validator.validateReplacementString(nil, usingFullString: nil, inRange: nil))
    }

    func testRangeInsertion() {
        var validation = Validation()
        let count = "1234 5678 1234 5678".characters.count
        validation.maximumLength = count
        validation.minimumLength = 1
        let validator = InputValidator(validation: validation)
        XCTAssertEqual("1234 0 4444 4444", validator.composedString("0", text: "1234 4444 4444 4444", inRange: NSRange(location: 5, length: 4)))
        XCTAssertTrue(validator.validateReplacementString("0", usingFullString: "1234 4444 4444 4444", inRange: NSRange(location: 5, length: 4)))
    }
}
