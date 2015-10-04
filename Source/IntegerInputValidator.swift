import Foundation
import Validation

public struct IntegerInputValidator: InputValidatable {
    public var validation: Validation?

    public init(validation: Validation? = nil) {
        self.validation = validation
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
                let decimalDigitCharacterSet = NSCharacterSet.decimalDigitCharacterSet()
                let stringCharacterSet = NSCharacterSet(charactersInString: composedString)
                valid = decimalDigitCharacterSet.isSupersetOfSet(stringCharacterSet)
            }
        }

        return valid
    }
}
