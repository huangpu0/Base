//
//  PayNumberKeyboardView.h
//  BaseDemo
//
//  Created by 朴子hp on 2018/6/11.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PayInputType) {
    
    /** 纯数字键盘 */
    PayIntInputType = 0,
    
    /** 浮点数键盘 */
    PayFloatInputType = 1,
    
    /** 身份证键盘 */
    PayIDCardInputType = 2,
    
};

@interface PayNumberKeyboardView : UIView 

@property (nonatomic, weak) UITextField<UITextInput> *textInput;

@property (nonatomic, assign) PayInputType inputType;        /** 键盘类型 */

@property (nonatomic, strong) NSNumber *interval;           /** 每隔多少个数字空一格 */

- (instancetype)initWithFrame:(CGRect)frame withInputType:(PayInputType)inputType;

+ (PayNumberKeyboardView *)AcquireCustomView;

@end
