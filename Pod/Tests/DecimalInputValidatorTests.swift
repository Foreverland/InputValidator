import XCTest
import Validation

class DecimalInputValidatorTests: XCTestCase {
    func testDecimal() {
        let validator = DecimalInputValidator()
        XCTAssertTrue(validator.validateString("3123"))
        XCTAssertTrue(validator.validateString("3,123"))
        XCTAssertTrue(validator.validateString("3.123"))
        XCTAssertFalse(validator.validateString("3,"))
        XCTAssertFalse(validator.validateString("3."))
        XCTAssertFalse(validator.validateString("3,1,23"))
        XCTAssertFalse(validator.validateString("3.1.23"))
        XCTAssertFalse(validator.validateString("321/222"))

        // 1st character
        var fullString = ""
        var fullStringLenght = fullString.characters.count
        XCTAssertTrue(validator.validateReplacementString("0", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString(",", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString(".", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString("/", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))

        // 2nd character:
        fullString = "1"
        fullStringLenght = fullString.characters.count
        XCTAssertTrue(validator.validateReplacementString("1", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString(",", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString(".", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString("/", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))

        // 3rd character:
        fullString = "1,"
        fullStringLenght = fullString.characters.count
        XCTAssertTrue(validator.validateReplacementString("1", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString(",", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString(".", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString("/", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))

        // 3rd character alternative:
        fullString = "1."
        fullStringLenght = fullString.characters.count
        XCTAssertTrue(validator.validateReplacementString("1", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString(",", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString(".", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString("/", fullString: fullString, inRange: NSRange(location: fullStringLenght, length: fullStringLenght + 1)))
    }
}
