import Foundation
import Validation

public class InputValidator {
    public var validation: Validation

    public init(validation: Validation) {
        self.validation = validation
    }

    public func validateString(string: String) -> Bool {
        return self.validation.validateString(string)
    }

    // This method is useful for partial validations, or validations where the final string is
    // in process of been completed. For example when entering characters into an UITextField.
    public func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?) -> Bool {
        let text = fullString ?? ""
        var evaluatedString = text
        var valid = true

        if let replacementString = replacementString, range = range {
            evaluatedString = self.composedString(replacementString, text: text, inRange: range)
        }

        valid = self.validation.validateString(evaluatedString)

        return valid
    }

    public func composedString(replacementString: String, text: String, inRange range: NSRange) -> String {
        var composedString = text
        let index = composedString.startIndex.advancedBy(range.location)
        if range.location == text.characters.count {
            composedString.insertContentsOf(replacementString.characters, at: index)
        } else {
            composedString = (composedString as NSString).stringByReplacingCharactersInRange(range, withString: replacementString)
        }
        return composedString
    }
}
