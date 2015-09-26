#import "Validation.h"

@interface InputValidator : NSObject

- (instancetype)initWithValidation:(Validation *)validation;

- (BOOL)validateString:(NSString *)string;

- (BOOL)validateReplacementString:(NSString *)string withText:(NSString *)text withRange:(NSRange)range;

@end
