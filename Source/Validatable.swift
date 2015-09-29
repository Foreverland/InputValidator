import Foundation

protocol Validatable {
    func validateString(fullText: String) -> Bool
    func validateReplacementString(replacementString: String?, fullText: String?, range: NSRange?) -> Bool
}
