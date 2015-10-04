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
    public func validateReplacementString(replacementString: String?, fullString: String?, inRange range: NSRange?) -> Bool {
        let evaluatedString = self.composedString(replacementString, fullString: fullString, inRange: range)

        return self.validation.validateString(evaluatedString)
    }

    public func composedString(replacementString: String?, fullString: String?, inRange range: NSRange?) -> String {
        var composedString = fullString ?? ""

        if let replacementString = replacementString, range = range {
            let index = composedString.startIndex.advancedBy(range.location)
            if range.location == composedString.characters.count {
                composedString.insertContentsOf(replacementString.characters, at: index)
            } else {
                composedString = (composedString as NSString).stringByReplacingCharactersInRange(range, withString: replacementString)
            }
            return composedString
        }

        return composedString
    }
}
