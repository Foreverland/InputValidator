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
                if (composedString.length == 1) {
                    valid = ([composedString isEqualToString:@"0"] ||
                             [composedString isEqualToString:@"1"]);
                } else if (composedString.length == 2 || composedString.length == 3) {
                    if (composedString.length == 3) {
                        composedString = [composedString substringToIndex:[@"12" length]];
                    }

                    NSNumberFormatter *formatter = [NSNumberFormatter new];
                    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
                    NSNumber *number = [formatter numberFromString:composedString];
                    valid = (number.integerValue > 0 && number.integerValue <= 12);
                } else if (composedString.length == 4 || composedString.length == 5) {
                    composedString = [composedString substringFromIndex:[@"01/" length]];

                    NSNumberFormatter *formatter = [NSNumberFormatter new];
                    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
                    NSNumber *number = [formatter numberFromString:composedString];

                    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
                    NSInteger year = [components year];

                    CGFloat century = floor(year / 100.0);
                    NSInteger basicYear = year - (century * 100);
                    NSInteger decade = floor(basicYear / 10.0);

                    if (composedString.length == 1) {
                        valid = (number.integerValue >= decade);
                    } else if (composedString.length == 2) {
                        valid = (number.integerValue >= basicYear);
                    }
                }
            }
        }
    }

    return valid;
}

@end
