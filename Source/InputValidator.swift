import Foundation
import Validation

public struct InputValidator: Validatable {
    var validation: Validation

    public init(validation: Validation) {
        self.validation = validation
    }

    public func validateString(string: String) -> Bool {
        return self.validateReplacementString(nil, usingFullString: string, inRange: nil, exhaustive: true)
    }

    public func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?, exhaustive: Bool = false) -> Bool {
        let text = fullString ?? ""
        var evaluatedString = text
        var valid = true

        if let replacementString = replacementString, range = range {
            evaluatedString = self.composedString(replacementString, text: text, inRange: range)
        }

        valid = self.validation.validateString(evaluatedString, exhaustive: exhaustive)

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
