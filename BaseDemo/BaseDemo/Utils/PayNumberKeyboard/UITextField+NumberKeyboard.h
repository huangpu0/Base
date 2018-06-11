//
//  UITextField+NumberKeyboard.h
//  BaseDemo
//
//  Created by 朴子hp on 2018/6/11.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayNumberKeyboardView.h"

@interface UITextField (NumberKeyboard)

@property (nonatomic, assign) PayInputType inputType;     // 键盘类型

@property (nonatomic, assign) NSInteger interval;        // 每隔多少个数字空一格

@property (nonatomic, copy) NSString *inputAccessoryText;  // 工具栏显示的文字


@end
