import Foundation
import Validation

public class DecimalInputValidator: InputValidator {
    public override func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?) -> Bool {
        var valid = super.validateReplacementString(replacementString, usingFullString: fullString, inRange: range)
        if valid {
            if let fullString = fullString, replacementString = replacementString {
                let hasDelimiter = (fullString.containsString(",") || fullString.containsString("."))
                let replacementIsDelimiter = (replacementString == "," || replacementString == ".")
                if hasDelimiter && replacementIsDelimiter {
                    valid = false
                }
            }

            if let replacementString = replacementString {
                let floatSet = NSCharacterSet(charactersInString: "1234567890,")
                let stringSet = NSCharacterSet(charactersInString: replacementString)
                valid = floatSet.isSupersetOfSet(stringSet)
            }
        }
        
        return valid
    }
}
