# InputValidator

`InputValidator` is the easiest way to validate a value, things that `InputValidator` lets you validate:
- Maximum length
- Minimum length 
- Maximum value
- Minimum value
- Required (non-empty)

For example if you want to validate that a value is between 5 and 6 you can do this:

```swift
let validation = Validation()
validation.minimumValue = 5
validation.maximumValue = 6

var result: Bool
let validator = InputValidator(validation: validation)
result = validator.validateString("4") // false
result = validator.validateString("5") // true
result = validator.validateString("6") // true
result = validator.validateString("7") // false
```

It also helps you verify if a string should be inserted into another string, useful when validating inputs on a `UITextField`. For example no letters should be allowed in a `UITextField` that contains a phone number.

```objc
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!string || [string isEqualToString:@"\n"]) return YES;

    IntegerInputValidator *inputValidator = [IntegerInputValidator new];
    return [inputValidator validateReplacementString:string withText:self.text withRange:range];
}
```

## Included built-in input validators

- CardExpirationDate
- Decimal
- Integer
- Name

## Installation

**InputValidator** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InputValidator'
```

## License

**InputValidator** is available under the MIT license. See the LICENSE file for more info.

## Author

Elvis Nuñez, [@3lvis](https://twitter.com/3lvis)
