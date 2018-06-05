//
//  Colors.h
//  Tool
//
//  Created by iOS开发 on 16/7/20.
//  Copyright © 2016年 iOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Colors : NSObject
+(UIColor*)getColorWithRed:(int)red green:(int)green blue:(int)blue;
//16进制颜色转为UIColor
+(UIColor *)getColorFromHex:(NSString *)hexColor;
@end
