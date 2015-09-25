#import "Field.h"
#import "FieldValidation.h"

@interface InputValidator : NSObject

@property (nonatomic) FieldValidation *validation;

- (BOOL)validateReplacementString:(NSString *)string withText:(NSString *)text withRange:(NSRange)range;

@end
