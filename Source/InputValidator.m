#import "InputValidator.h"
#import "NumberInputValidator.h"

@interface InputValidator ()

@property (nonatomic) Validation *validation;

@end

@implementation InputValidator

- (instancetype)initWithValidation:(Validation *)validation {
    self = [super init];
    if (self) {
        _validation = validation;
    }

    return self;
}

- (BOOL)validateString:(NSString *)string {
    return [self validateReplacementString:nil withText:string withRange:NSMakeRange(0, 0)];
}

- (BOOL)validateReplacementString:(NSString *)replacementString withText:(NSString *)text withRange:(NSRange)range {
    BOOL shouldSkipValidations = (!self.validation);
    if (shouldSkipValidations) {
        return YES;
    }

    NSString *evaluatedString = text;

    BOOL valid = YES;

    if (self.validation.required == YES && !self.validation.minimumLength) {
        self.validation.minimumLength = @1;
    }

    if (self.validation.maximumLength || self.validation.minimumLength) {
        NSUInteger textLength = text.length;

        if (replacementString.length > 0) {
            textLength += replacementString.length;
        }

        if (self.validation.maximumLength) {
            valid = (textLength <= [self.validation.maximumLength unsignedIntegerValue]);
        }

        if (valid && self.validation.minimumLength) {
            valid = (textLength >= [self.validation.minimumLength unsignedIntegerValue]);
        }
    }

    if (replacementString) {
        NSMutableString *composedString = [[NSMutableString alloc] initWithString:text];
        [composedString insertString:replacementString atIndex:range.location];
        evaluatedString = [composedString copy];
    }

    if (text && valid && (self.validation.maximumValue || self.validation.minimumValue)) {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        NSNumber *newValue = [formatter numberFromString:evaluatedString];

        if (newValue) {
            if (self.validation.maximumValue) {
                valid = ([newValue floatValue] <= [self.validation.maximumValue floatValue]);
            }

            if (valid && self.validation.minimumValue) {
                valid = ([newValue floatValue] >= [self.validation.minimumValue floatValue]);
            }
        }
    }

    if (valid && self.validation.format) {
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
