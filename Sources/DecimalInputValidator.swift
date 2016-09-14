import Foundation
import Validation

public struct DecimalInputValidator: InputValidatable {
    public var validation: Validation?

    public init(validation: Validation? = nil) {
        self.validation = validation
    }

    public func validateReplacementString(_ replacementString: String?, fullString: String?, inRange range: NSRange?) -> Bool {
        var valid = true
        if let validation = self.validation {
            let evaluatedString = self.composedString(replacementString, fullString: fullString, inRange: range)
            valid = validation.validateString(evaluatedString, complete: false)
        }

        if valid {
            let composedString = self.composedString(replacementString, fullString: fullString, inRange: range)
            if composedString.characters.count > 0 {
                let stringSet = NSCharacterSet(charactersIn: composedString)
                let floatSet = NSMutableCharacterSet.decimalDigit()
                floatSet.addCharacters(in: ".,")
                let hasValidElements = floatSet.isSuperset(of: stringSet as CharacterSet)
                if hasValidElements  {
                    let firstElementSet = NSCharacterSet(charactersIn: String(composedString.characters.first!))
                    let integerSet = NSCharacterSet.decimalDigits
                    let firstCharacterIsNumber = integerSet.isSuperset(of: firstElementSet as CharacterSet)
                    if firstCharacterIsNumber {
                        if replacementString == nil {
                            let lastElementSet = NSCharacterSet(charactersIn: String(composedString.characters.last!))
                            let lastCharacterIsInvalid = !integerSet.isSuperset(of: lastElementSet as CharacterSet)
                            if lastCharacterIsInvalid {
                                valid = false
                            }
                        }

                        if valid {
                            let elementsSeparatedByDot = composedString.components(separatedBy: ".")
                            let elementsSeparatedByComma = composedString.components(separatedBy: ",")
                            if elementsSeparatedByDot.count >= 2 && elementsSeparatedByComma.count >= 2 {
                                valid = false
                            } else if elementsSeparatedByDot.count > 2 || elementsSeparatedByComma.count > 2 {
                                valid = false
                            }
                        }
                    } else {
                        valid = false
                    }
                } else {
                    valid = false
                }
            }
        }

        return valid
    }
}
