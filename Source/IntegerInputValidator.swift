import Foundation
import Validation

public struct IntegerInputValidator: Validatable {
    var validation: Validation

    public init(validation: Validation) {
        self.validation = validation
    }

    public func validateString(string: String) -> Bool {
        return self.validateReplacementString(nil, usingFullString: string, inRange: nil)
    }

    public func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?, exhaustive: Bool = false) -> Bool {
        let baseInputValidator = InputValidator(validation: self.validation)
        var valid = baseInputValidator.validateReplacementString(replacementString, usingFullString: fullString, inRange: range)
        if valid {
            if let replacementString = replacementString {
                let decimalDigitCharacterSet = NSCharacterSet.decimalDigitCharacterSet()
                let stringCharacterSet = NSCharacterSet(charactersInString: replacementString)
                valid = decimalDigitCharacterSet.isSupersetOfSet(stringCharacterSet)
            }
        }

        return valid
    }
}
