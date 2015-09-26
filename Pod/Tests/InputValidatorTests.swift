import UIKit
import XCTest

class InputValidatorTests: XCTestCase {

    func testValidateReplacementStringWithEmailFormat() {
        let validation = Validation()
        validation.format = "[\\w._%+-]+@[\\w.-]+\\.\\w{2,}"

        let validator = InputValidator()
        validator.validation = validation
        let text = "elvisnunez@me.co"
        XCTAssertTrue(validator.validateReplacementString("m", withText: text, withRange: NSRange(location: text.characters.count, length: text.characters.count)))
        XCTAssertFalse(validator.validateReplacementString("!", withText: text, withRange: NSRange(location: text.characters.count, length: text.characters.count)))
        XCTAssertTrue(validator.validateReplacementString("m", withText: text, withRange: NSRange(location: text.characters.count, length: 4)))
        XCTAssertFalse(validator.validateReplacementString("]", withText: text, withRange: NSRange(location: text.characters.count, length: 4)))
    }

    func testEmailFormatValidation() {
        let validation = Validation()
        validation.format = "[\\w._%+-]+@[\\w.-]+\\.\\w{2,}"

        let validator = InputValidator()
        validator.validation = validation
        XCTAssertTrue(validator.validateString("elvisnunez@me.com"))
        XCTAssertFalse(validator.validateString("elvisnunez[@]me.com"))
        XCTAssertFalse(validator.validateString("Elvis Nunez"))
    }

    func testMaximumLengthValidation() {

    }

    func testMinimumLengthValidation() {

    }

    func testMaximumValueValidation() {

    }

    func testMinimumValueValidation() {

    }

    func testRequiredValidation() {

    }
}
