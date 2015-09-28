#import "CardExpirationDateInputValidator.h"
@import CoreGraphics;

@implementation CardExpirationDateInputValidator

- (BOOL)validateReplacementString:(NSString *)replacementString withText:(NSString *)text withRange:(NSRange)range {
    BOOL valid = [super validateReplacementString:replacementString withText:text withRange:range];
    if (valid) {
        if (replacementString) {
            NSMutableString *mixedString = [NSMutableString new];
            if (text) {
                [mixedString appendString:text];
            }
            [mixedString insertString:replacementString atIndex:range.location];
            NSString *composedString = [mixedString copy];

            if (composedString.length > 0) {
                BOOL isFirstCharacter = (composedString.length == 1);
                BOOL isSecondCharacter = (composedString.length == 2);
                BOOL isThirdCharacter = (composedString.length == 3);
                BOOL isFourthCharacter = (composedString.length == 4);
                BOOL isFifthCharacter = (composedString.length == 5);

                NSNumber *number;
                if (!isFirstCharacter) {
                    if (isThirdCharacter) {
                        composedString = [composedString substringToIndex:[@"MM" length]];
                    } else if (isFourthCharacter || isFifthCharacter) {
                        composedString = [composedString substringFromIndex:[@"MM/" length]];
                    }

                    NSNumberFormatter *formatter = [NSNumberFormatter new];
                    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
                    number = [formatter numberFromString:composedString];
                }


                if (isFirstCharacter) {
                    valid = ([composedString isEqualToString:@"0"] ||
                             [composedString isEqualToString:@"1"]);
                } else if (isSecondCharacter || isThirdCharacter) {
                    NSInteger maximumMonth = 12;
                    valid = (number.integerValue > 0 && number.integerValue <= maximumMonth);
                } else if (isFourthCharacter || isFifthCharacter) {
                    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
                    NSInteger year = [components year];

                    CGFloat century = floor(year / 100.0);
                    NSInteger basicYear = year - (century * 100);
                    NSInteger decade = floor(basicYear / 10.0);

                    BOOL isDecimal = (composedString.length == 1);
                    BOOL isYear = (composedString.length == 2);
                    if (isDecimal) {
                        valid = (number.integerValue >= decade);
                    } else if (isYear) {
                        valid = (number.integerValue >= basicYear);
                    }
                }
            }
        }
    }

    return valid;
}

@end
