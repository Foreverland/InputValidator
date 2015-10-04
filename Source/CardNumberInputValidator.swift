import Foundation
import Validation

public struct CardNumberInputValidator: InputValidatable {
    public var validation: Validation?

    public init(validation: Validation? = nil) {
        var predefinedValidation = Validation()
        predefinedValidation.maximumLength = "1234 5678 1234 5678".characters.count
        predefinedValidation.required = validation?.required
        self.validation = predefinedValidation
    }

    public func validateReplacementString(replacementString: String?, fullString: String?, inRange range: NSRange?) -> Bool {
        var valid = true
        if let validation = self.validation {
            let evaluatedString = self.composedString(replacementString, fullString: fullString, inRange: range)
            valid = validation.validateString(evaluatedString)
        }

        if valid {
            let composedString = self.composedString(replacementString, fullString: fullString, inRange: range)
            if composedString.characters.count > 0 {
                let decimalDigitCharacterSet = NSMutableCharacterSet.decimalDigitCharacterSet()
                decimalDigitCharacterSet.addCharactersInString(" ")
                let stringCharacterSet = NSCharacterSet(charactersInString: composedString)
                valid = decimalDigitCharacterSet.isSupersetOfSet(stringCharacterSet)
            }
        }

        return valid
    }
}
