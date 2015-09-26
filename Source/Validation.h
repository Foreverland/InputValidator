@import Foundation;
@import CoreGraphics;

@interface Validation : NSObject

@property (nonatomic, copy) NSString *format;
@property (nonatomic) NSNumber *maximumLength;
@property (nonatomic) NSNumber *minimumLength;
@property (nonatomic) NSNumber *maximumValue;
@property (nonatomic) NSNumber *minimumValue;
@property (nonatomic, getter = isRequired) BOOL required;

@end
