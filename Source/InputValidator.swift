import Foundation

public struct InputValidator: Validatable {
    var validation: Validation

    public init(validation: Validation) {
        self.validation = validation
    }

    public func validateString(string: String) -> Bool {
        return self.validateReplacementString(nil, usingFullString: string, inRange: nil)
    }

    public func validateReplacementString(replacementString: String?, usingFullString fullString: String?, inRange range: NSRange?) -> Bool {
        let text = fullString ?? ""
        var evaluatedString = text
        var valid = true

        if let replacementString = replacementString, range = range {
            var composedString = text
            let index = composedString.startIndex.advancedBy(range.location)
            composedString.insertContentsOf(replacementString.characters, at: index)
            evaluatedString = composedString
        }

        if let maximumLength = self.validation.maximumLength {
            valid = (evaluatedString.characters.count <= maximumLength)
        }

        if valid {
            var minimumLength: Int? = nil

            if let required = self.validation.required where required == true {
                minimumLength = 1
            }

            if let validationMinimumLength = self.validation.minimumLength {
                minimumLength = validationMinimumLength
            }

            if let minimumLength = minimumLength {
                valid = (evaluatedString.characters.count >= minimumLength)
            }
        }

        if valid {
            let formatter = NSNumberFormatter()
            let number = formatter.numberFromString(evaluatedString)
            if let number = number {
                if let maximumValue = self.validation.maximumValue {
                    valid = (number.doubleValue <= maximumValue)
                }

                if valid {
                    if let minimumValue = self.validation.minimumValue {
                        valid = (number.doubleValue >= minimumValue)
                    }
                }
            }
        }

        return valid
    }
}
