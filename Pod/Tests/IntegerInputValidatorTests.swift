import XCTest
import Validation

class IntegerInputValidatorTests: XCTestCase {
    func testInteger() {
        let validator = IntegerInputValidator()
        XCTAssertTrue(validator.validateString("3123"))
        XCTAssertFalse(validator.validateString("3,123"))

        // 1st character
        var fullString = ""
        var fullStringLenght = fullString.characters.count
        XCTAssertTrue(validator.validateReplacementString("0", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString(",", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))

        // 2nd character:
        fullString = "1"
        fullStringLenght = fullString.characters.count
        XCTAssertTrue(validator.validateReplacementString("1", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString(",", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
    }
}
