import Foundation
import Validation

public struct NameInputValidator: Validatable {
    public var validation: Validation

    public init(validation: Validation) {
        self.validation = validation
    }

    public func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?) -> Bool {
        let baseInputValidator = InputValidator(validation: self.validation)
        var valid = baseInputValidator.validateReplacementString(replacementString, usingFullString: fullString, inRange: range)
        if valid {
            if let replacementString = replacementString {
                let letterCharacterSet = NSCharacterSet.letterCharacterSet()
                let whitespaceCharacterSet = NSCharacterSet.whitespaceCharacterSet()
                let delimiterCharacterSet = NSCharacterSet(charactersInString: "-")
                let stringSet = NSCharacterSet(charactersInString: replacementString)
                let allowsString = (
                    letterCharacterSet.isSupersetOfSet(stringSet) ||
                    whitespaceCharacterSet.isSupersetOfSet(stringSet) ||
                    delimiterCharacterSet.isSupersetOfSet(stringSet)
                )
                valid = allowsString
            }
        }

        return valid
    }
}
