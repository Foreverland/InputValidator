import Foundation

struct InputValidator: Validatable {
    var validation: Validation

    init(validation: Validation) {
        self.validation = validation
    }

    func validateString(text: String) -> Bool {
        return self.validateReplacementString(nil, fullText: text, range: nil)
    }

    func validateReplacementString(replacementString: String?, fullText: String?, range: NSRange?) -> Bool {
        let text = fullText ?? ""
        var evaluatedString = text
        var valid = true

        var textLength = text.characters.count
        if let replacementString = replacementString {
            if replacementString.characters.count > 0 {
                textLength += replacementString.characters.count
            }
        }

        if let maximumLength = self.validation.maximumLength {
            valid = (textLength <= maximumLength)
        }

        if valid {
            var minimumLength: Int? = nil

            if let required = self.validation.required where required == true {
                minimumLength = 1
            }

            if let validationMinimumLength = self.validation.minimumLength {
                minimumLength = validationMinimumLength
            }

            valid = (textLength >= minimumLength)
        }

        if let replacementString = replacementString, range = range {
            let composedString = text
            composedString.insert(replacementString, index: range.location)
            evaluatedString = composedString
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
    func insert(string: String, index: Int) -> String {
        return  String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count-index))
    }
}
