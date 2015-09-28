import UIKit
import XCTest

class CardExpirationDateInputValidatorTests: XCTestCase {
    func testCardExpirationDate() {
        /*
            This input validator should validate strings with the following pattern:
            MM/YY, where MM is month and YY is year. MM shouldn't be more than 12 and year
            can be pretty much any number above the current year (this to ensure that the
            card is not expired).
        */

        let validation = Validation()
        validation.maximumLength = NSNumber(int: 5)

        let validator = CardExpirationDateInputValidator(validation: validation)
        XCTAssertTrue(validator.validateString("12/12"))

        // 1st character: First character can be 0, 1
        let oneCharacter = ""
        let oneCharacterLenght = oneCharacter.characters.count
        XCTAssertTrue(validator.validateReplacementString("0", withText: "", withRange: NSRange(location: oneCharacterLenght, length: oneCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("1", withText: "", withRange: NSRange(location: oneCharacterLenght, length: oneCharacterLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString("2", withText: "", withRange: NSRange(location: oneCharacterLenght, length: oneCharacterLenght + 1)))

        // 2nd character: The second character composed with the first one should be equal or less than 12
        let secondCharacter = "1"
        let secondCharacterLenght = secondCharacter.characters.count
        XCTAssertTrue(validator.validateReplacementString("1", withText: "0", withRange: NSRange(location: secondCharacterLenght, length: secondCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("2", withText: "1", withRange: NSRange(location: secondCharacterLenght, length: secondCharacterLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString("3", withText: "1", withRange: NSRange(location: secondCharacterLenght, length: secondCharacterLenght + 1)))

        // 3rd character: The third character is the '\'

        // 4th character: The fourth character has to be higher than the decimal of the current year.
        // For example if the current year is 2015, then the fourth character has to be equal or higher than 1
        let fourthCharacter = "12/"
        let fourthCharacterLenght = fourthCharacter.characters.count
        XCTAssertFalse(validator.validateReplacementString("0", withText: "12/", withRange: NSRange(location: fourthCharacterLenght, length: fourthCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("1", withText: "12/", withRange: NSRange(location: fourthCharacterLenght, length: fourthCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("2", withText: "12/", withRange: NSRange(location: fourthCharacterLenght, length: fourthCharacterLenght + 1)))

        // 5th character: The fifth character composed with the fourth character should be equal or higher than 
        // the decimal of the current year
        let fifthCharacter = "12/1"
        let fifthCharacterLenght = fifthCharacter.characters.count
        XCTAssertFalse(validator.validateReplacementString("4", withText: "12/1", withRange: NSRange(location: fifthCharacterLenght, length: fifthCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("5", withText: "12/1", withRange: NSRange(location: fifthCharacterLenght, length: fifthCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("6", withText: "12/1", withRange: NSRange(location: fifthCharacterLenght, length: fifthCharacterLenght + 1)))
    }
}
