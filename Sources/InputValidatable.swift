import Foundation
import Validation

public protocol InputValidatable {
    var validation: Validation? { get }

    init(validation: Validation?)

    func validateString(_ string: String) -> Bool

    // This method is useful for partial validations, or validations where the final string is
    // in process of been completed. For example when entering characters into an UITextField.
    func validateReplacementString(_ replacementString: String?, fullString: String?, inRange range: NSRange?) -> Bool
}

extension InputValidatable {
    public func validateString(_ string: String) -> Bool {
        var valid = true
        if let validation = self.validation {
            valid = validation.validateString(string)
        }

        if valid {
            valid = self.validateReplacementString(nil, fullString: string, inRange: nil)
        }

        return valid
    }

    public func validateReplacementString(_ replacementString: String?, fullString: String?, inRange range: NSRange?) -> Bool {
        var valid = true
        if let validation = self.validation {
            let evaluatedString = self.composedString(replacementString, fullString: fullString, inRange: range)
            valid = validation.validateString(evaluatedString, complete: false)
        }

        return valid
    }

    public func composedString(_ replacementString: String?, fullString: String?, inRange range: NSRange?) -> String {
        var composedString = fullString ?? ""

        if let replacementString = replacementString, let range = range {
            let index = composedString.characters.index(composedString.startIndex, offsetBy: range.location)
            if range.location == composedString.characters.count {
                composedString.insert(contentsOf: replacementString.characters, at: index)
            } else {
                composedString = (composedString as NSString).replacingCharacters(in: range, with: replacementString)
            }
            return composedString
        }

        return composedString
    }
}
