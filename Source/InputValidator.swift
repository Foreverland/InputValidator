import Foundation

public struct InputValidator: Validatable {
    var validation: Validation

    public init(validation: Validation) {
        self.validation = validation
    }

    public func validateString(text: String) -> Bool {
        return self.validateReplacementString(nil, fullText: text, range: nil)
    }

    public func validateReplacementString(replacementString: String?, fullText: String?, range: NSRange?) -> Bool {
        let text = fullText ?? ""
        var evaluatedString = text
        var valid = true

        if let replacementString = replacementString, range = range {
            let composedString = text
            composedString.insert(replacementString, atIndex: range.location)
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

extension String {
    func insert(string: String, atIndex index: Int) -> String {
        return  String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count - index))
    }
}
