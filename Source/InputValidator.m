#import "InputValidator.h"
#import "NumberInputValidator.h"

@implementation InputValidator

- (BOOL)validateString:(NSString *)string {
    return [self validateReplacementString:nil withText:string withRange:NSMakeRange(0, 0)];
}

- (BOOL)validateReplacementString:(NSString *)replacementString withText:(NSString *)text withRange:(NSRange)range {
    BOOL shouldSkipValidations = (text.length == 0 || !self.validation);
    if (shouldSkipValidations) return YES;

    NSString *evaluatedString = text;

    BOOL valid = YES;

    if (self.validation.maximumLength) {
        NSUInteger textLength = [text length];

        if (replacementString.length > 0) {
            textLength++;
        }
        valid = (textLength <= [self.validation.maximumLength unsignedIntegerValue]);
    }

    if (replacementString) {
        NSMutableString *composedString = [[NSMutableString alloc] initWithString:text];
        [composedString insertString:replacementString atIndex:range.location];
        evaluatedString = [composedString copy];
    }

    if (self.validation.maximumValue && text) {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        NSNumber *newValue = [formatter numberFromString:evaluatedString];
        NSNumber *maxValue = self.validation.maximumValue;

        BOOL eligibleForCompare = (newValue && maxValue);
        if (eligibleForCompare) valid = ([newValue floatValue] <= [maxValue floatValue]);
    }

    if (self.validation.format) {
        NSError *formattingError = nil;
        valid = [self validateString:evaluatedString withFormat:self.validation.format error:&formattingError];
        if (formattingError) {
            NSLog(@"There was a problem checking the format of %@ (Format: %@, Error: %@)", evaluatedString, self.validation.format, formattingError);
        }
    }

    return valid;
}

- (BOOL)validateString:(NSString *)fieldValue withFormat:(NSString *)format error:(NSError **)error {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:format options:NSRegularExpressionCaseInsensitive error:error];
    NSRange range = [regex rangeOfFirstMatchInString:fieldValue options:NSMatchingReportProgress range:NSMakeRange(0, fieldValue.length)];

    return (range.location == 0 && range.length == fieldValue.length);
}

@end
