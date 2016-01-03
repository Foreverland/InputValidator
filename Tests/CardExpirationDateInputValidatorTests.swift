import XCTest
import Validation
import InputValidator
import Foundation

class CardExpirationDateInputValidatorTests: XCTestCase {
    func testCardExpirationDate() {
        let validator = CardExpirationDateInputValidator()
        XCTAssertTrue(validator.validateString("12/12"))

        // 1st character: First character can be 0, 1
        let oneCharacter = ""
        let oneCharacterLenght = oneCharacter.characters.count
        XCTAssertTrue(validator.validateReplacementString("0", fullString: "", inRange: NSRange(location: oneCharacterLenght, length: oneCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("1", fullString: "", inRange: NSRange(location: oneCharacterLenght, length: oneCharacterLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString("2", fullString: "", inRange: NSRange(location: oneCharacterLenght, length: oneCharacterLenght + 1)))

        // 2nd character: The second character composed with the first one should be equal or less than 12
        let secondCharacter = "1"
        let secondCharacterLenght = secondCharacter.characters.count
        XCTAssertTrue(validator.validateReplacementString("1", fullString: "0", inRange: NSRange(location: secondCharacterLenght, length: secondCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("2", fullString: "1", inRange: NSRange(location: secondCharacterLenght, length: secondCharacterLenght + 1)))
        XCTAssertFalse(validator.validateReplacementString("3", fullString: "1", inRange: NSRange(location: secondCharacterLenght, length: secondCharacterLenght + 1)))

        // 3rd character: The third character is the '\'
        let thirdCharacter = "MM"
        let thirdCharacterLenght = thirdCharacter.characters.count
        XCTAssertFalse(validator.validateReplacementString("0", fullString: "12", inRange: NSRange(location: thirdCharacterLenght, length: thirdCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("/", fullString: "12", inRange: NSRange(location: thirdCharacterLenght, length: thirdCharacterLenght + 1)))

        // 4th character: The fourth character has to be higher than the decimal of the current year.
        // For example if the current year is 2015, then the fourth character has to be equal or higher than 1
        let fourthCharacter = "MM/"
        let fourthCharacterLenght = fourthCharacter.characters.count
        XCTAssertFalse(validator.validateReplacementString("0", fullString: "12/", inRange: NSRange(location: fourthCharacterLenght, length: fourthCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("1", fullString: "12/", inRange: NSRange(location: fourthCharacterLenght, length: fourthCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString("2", fullString: "12/", inRange: NSRange(location: fourthCharacterLenght, length: fourthCharacterLenght + 1)))

        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year], fromDate: date)

        let previousYear =  String(String(components.year - 1).characters.last!)
        let currentYear =  String(String(components.year).characters.last!)
        let nextYear =  String(String(components.year + 1).characters.last!)

        // 5th character: The fifth character composed with the fourth character should be equal or higher than 
        // the decimal of the current year
        let fifthCharacter = "MM/1"
        let fifthCharacterLenght = fifthCharacter.characters.count
        XCTAssertFalse(validator.validateReplacementString(previousYear, fullString: "12/1", inRange: NSRange(location: fifthCharacterLenght, length: fifthCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString(currentYear, fullString: "12/1", inRange: NSRange(location: fifthCharacterLenght, length: fifthCharacterLenght + 1)))
        XCTAssertTrue(validator.validateReplacementString(nextYear, fullString: "12/1", inRange: NSRange(location: fifthCharacterLenght, length: fifthCharacterLenght + 1)))
    }
}
