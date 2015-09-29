import Foundation

public protocol Validatable {
    func validateString(string: String) -> Bool
    func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?) -> Bool
}
