#import "Validation.h"

@interface InputValidator : NSObject

@property (nonatomic) Validation *validation;

- (BOOL)validateString:(NSString *)string;

- (BOOL)validateReplacementString:(NSString *)string withText:(NSString *)text withRange:(NSRange)range;

@end
