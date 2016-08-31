import Foundation
import Validation

public protocol InputValidatable {
    var validation: Validation? { get }

    init(validation: Validation?)

    func validateString(string: String) -> Bool

    // This method is useful for partial validations, or validations where the final string is
    // in process of been completed. For example when entering characters into an UITextField.
    func validateReplacementString(replacementString: String?, fullString: String?, inRange range: NSRange?) -> Bool
}

extension InputValidatable {
    public func validateString(string: String) -> Bool {
        var valid = true
        if let validation = self.validation {
            valid = validation.validateString(string)
        }

        if valid {
            valid = self.validateReplacementString(nil, fullString: string, inRange: nil)
        }

        return valid
    }

    public func validateReplacementString(replacementString: String?, fullString: String?, inRange range: NSRange?) -> Bool {
        var valid = true
        if let validation = self.validation {
            let evaluatedString = self.composedString(replacementString, fullString: fullString, inRange: range)
            valid = validation.validateString(evaluatedString, complete: false)
        }

        return valid
    }

    public func composedString(replacementString: String?, fullString: String?, inRange range: NSRange?) -> String {
        var composedString = fullString ?? ""
        
        func rangeFromNSRange(nsRange : NSRange, string: String) -> Range<String.Index>? {
            let from16 = string.utf16.startIndex.advancedBy(nsRange.location, limit: string.utf16.endIndex)
            let to16 = from16.advancedBy(nsRange.length, limit: string.utf16.endIndex)
            if let from = String.Index(from16, within: string),
                let to = String.Index(to16, within: string) {
                return from ..< to
            }
            return nil
        }

        if let replacementString = replacementString, nsrange = range {
            if let range = rangeFromNSRange(nsrange, string: composedString) {
                let distance = composedString.startIndex.distanceTo(range.startIndex)
                let index = composedString.startIndex.advancedBy(distance)
                if distance == composedString.characters.count {
                    composedString.insertContentsOf(replacementString.characters, at: index)
                } else {
                    composedString = (composedString as NSString).stringByReplacingCharactersInRange(nsrange, withString: replacementString)
                }
                return composedString
            }
        }

        return composedString
    }
}
