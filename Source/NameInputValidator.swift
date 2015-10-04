import Foundation
import Validation

public class NameInputValidator: InputValidator {
    public override func validateReplacementString(replacementString: String?, fullString: String?, inRange range: NSRange?) -> Bool {
        var valid = super.validateReplacementString(replacementString, fullString: fullString, inRange: range)
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
