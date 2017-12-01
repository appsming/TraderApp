

#import "NSString+Custom.h"

@implementation NSString (Custom)

- (BOOL)have {
    if (self == nil) return NO;
    if ([self isEqualToString:@"null"]) return NO;
    if ([self isEqualToString:@"(null)"]) return NO;
    if (self.length == 0) return NO;
    return YES;
}
- (NSString *)getPriceStr {
    NSString *priceStr = [NSString stringWithFormat:@"%.2f", [self floatValue]];
    if ([priceStr hasSuffix:@".00"]) {
        priceStr = [NSString stringWithFormat:@"%.0f", [self floatValue]];
    } else if ([priceStr hasSuffix:@"0"]) {
        priceStr = [NSString stringWithFormat:@"%.1f", [self floatValue]];
    }
    return priceStr;
}
- (id)toJSONObject {
    id obj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    return obj;
}
- (CGSize)mm_sizeWithFont:(float)fontSize withWidth:(float)width {
    if (![self have]) {
        return CGSizeZero;
    }
    CGSize size =  [self boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    if (width == 0) {
        return size;
    }
    if (size.width < width) {
        size.width = size.width + 1;
        size.height = size.height + 1;
    } else {
        size.height = size.height + 1;
    }
    return size;
}
- (NSString *)getMinDateStr {
    NSString *str = [self stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    if (str.length > 18) {
        str = [str substringToIndex:16];
    }
    return str;
}
- (NSString *)getDateStr {
    NSArray *arr = [self componentsSeparatedByString:@"T"];
    if (arr.count == 2) {
        return arr[0];
    }
    return self;
}
@end