import Foundation

public protocol Validatable {
    func validateString(string: String) -> Bool

    // The exhaustive boolean is useful for partial validations, or validations where the final string is
    // in process of been completed. For example when entering characters into an UITextField.
    // For example if your required input has the form XX/YY and the current input is XX/ making exhaustive be true
    // will cause the validation to fail, meanwhile making exhaustive be false, will cause the validation to succeed.
    func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?, exhaustive: Bool ) -> Bool
}

extension Validatable {
    public func validateString(string: String) -> Bool {
        return self.validateReplacementString(nil, usingFullString: string, inRange: nil, exhaustive: true)
    }
}
