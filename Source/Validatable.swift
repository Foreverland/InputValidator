import Foundation
import Validation

public protocol Validatable {
    var validation: Validation { get set }

    init(validation: Validation)

    func validateString(string: String) -> Bool

    // This method is useful for partial validations, or validations where the final string is
    // in process of been completed. For example when entering characters into an UITextField.
    func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?) -> Bool
}

extension Validatable {
    public func validateString(string: String) -> Bool {
        return self.validation.validateString(string)
    }
}
