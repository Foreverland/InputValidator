# InputValidator

Helps you verify if a string should be inserted into another string, useful when validating inputs on a UITextField. For example no letters should be allowed in a UITextField that contains a phone number.

```objc
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!string || [string isEqualToString:@"\n"]) return YES;

    NumberInputValidator *inputValidator = [NumberInputValidator new];
    return [inputValidator validateReplacementString:string withText:self.text withRange:range];
}
```

Or if you want to validate that a value is between 5 and 6

```swift
let validation = Validation()
validation.minimumValue = NSNumber(int: 5)
validation.maximumValue = NSNumber(int: 6)

var result: Bool
result = validator.validateString("4") // false
result = validator.validateString("5") // true
result = validator.validateString("6") // true
result = validator.validateString("7") // false
```

Input validator also lets validate:
- Maximum length
- Minimum length 
- Maximum value
- Minimum value
- Required (non-empty)

## Included built-in input validators

- Float
- Name
- Number

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
