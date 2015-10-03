import Foundation
import Validation

public class IntegerInputValidator: InputValidator {
    public override func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?) -> Bool {
        var valid = super.validateReplacementString(replacementString, usingFullString: fullString, inRange: range)
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
