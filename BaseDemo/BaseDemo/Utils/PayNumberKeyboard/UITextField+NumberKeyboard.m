//
//  UITextField+NumberKeyboard.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/6/11.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "UITextField+NumberKeyboard.h"

@implementation UITextField (NumberKeyboard)

- (void)setInputType:(PayInputType)inputType{
    PayNumberKeyboardView *inputView = [[PayNumberKeyboardView AcquireCustomView] initWithFrame:CGRectMake(0, kScreen_Height - 216, kScreen_Width, 216) withInputType:inputType];
    inputView.textInput = self;
    self.inputView = inputView;
    objc_setAssociatedObject(self, _cmd, @(inputType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setInterval:(NSInteger)interval{
    if([self.inputView isKindOfClass:[PayNumberKeyboardView class]])
        [self.inputView performSelector:@selector(setInterval:) withObject:@(interval)];
    objc_setAssociatedObject(self, _cmd, @(interval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/** 键盘上方工具栏 */
- (void)setInputAccessoryText:(NSString *)inputAccessoryText{
    UIView *tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 35)];
    self.inputAccessoryView = tView;
    objc_setAssociatedObject(self, _cmd, inputAccessoryText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PayInputType)inputType{
    return [objc_getAssociatedObject(self, @selector(setInputType:)) integerValue];
}

- (NSInteger)interval{
    return [objc_getAssociatedObject(self, @selector(setInterval:)) integerValue];
}

- (NSString *)inputAccessoryText{
    return objc_getAssociatedObject(self, @selector(inputAccessoryText));
}

@end
