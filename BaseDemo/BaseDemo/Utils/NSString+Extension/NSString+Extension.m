//
//  NSString+Extension.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString(Extension)

-(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width{
    CGSize textSize;
    NSString *string = [self copy];
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                           options:opts
                                        attributes:attributes
                                           context:nil];
        textSize = rect.size;
    }else{
        NSDictionary *attributes = @{ NSFontAttributeName : font };
        textSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                          options:\
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                       attributes:attributes
                                          context:nil].size;
    }
    return textSize.height;
}
@end
