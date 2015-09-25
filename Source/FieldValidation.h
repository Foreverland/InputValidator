@import Foundation;
@import CoreGraphics;

@interface FieldValidation : NSObject

@property (nonatomic, copy) NSString *compareRule;
@property (nonatomic, copy) NSString *compareToFieldID;
@property (nonatomic, copy) NSString *format;
@property (nonatomic) NSNumber *maximumLength;
@property (nonatomic) NSNumber *minimumLength;
@property (nonatomic) NSNumber *maximumValue;
@property (nonatomic) NSNumber *minimumValue;
@property (nonatomic, getter = isRequired) BOOL required;

@end
