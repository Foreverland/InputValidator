# InputValidator

Helps you verify if a string should be inserted into another string, useful when validating inputs on a UITextField. For example no letters should be allowed in a UITextField that contains a phone number.

```objc
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!string || [string isEqualToString:@"\n"]) return YES;

    PhoneNumberInputValidator *inputValidator = [PhoneNumberInputValidator new];
    return [inputValidator validateReplacementString:string withText:self.text withRange:range];
}
```

Input validator also lets validate maximum length, minimum length, maximum value, minimum value and check for required fields.

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
