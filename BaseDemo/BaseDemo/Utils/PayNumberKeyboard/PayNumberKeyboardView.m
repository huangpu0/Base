//
//  PayNumberKeyboardView.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/6/11.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "PayNumberKeyboardView.h"
@interface PayNumberKeyboardView () <UIKeyInput>

/** 键盘删除按钮 */
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

/** 键盘x/.替换按钮 */
@property (weak, nonatomic) IBOutlet UIButton *replaceBtn;

/** 隐藏键盘按钮 */
@property (weak, nonatomic) IBOutlet UIButton *hideBtn;

@end

@implementation PayNumberKeyboardView

- (instancetype)initWithFrame:(CGRect)frame withInputType:(PayInputType)inputType{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        self.inputType = inputType;
        
        [self.deleteBtn setImage:[UIImage imageNamed:@"PayNumbeKeyboard.bundle/image/delete.png"]
                        forState:UIControlStateNormal];
        [self.hideBtn setImage:[UIImage imageNamed:@"PayNumbeKeyboard.bundle/image/resign.png"]
                        forState:UIControlStateNormal];
    }
    return self;
}

+( PayNumberKeyboardView *)AcquireCustomView{
    PayNumberKeyboardView *view = [[UINib nibWithNibName:@"PayNumberKeyboardView" bundle:nil] instantiateWithOwner:self options:nil].lastObject;
    return view;
}

/** 对应键盘显示类型 */
- (void)setInputType:(PayInputType)inputType
{
    _inputType = inputType;
    
    switch (inputType)
    {
            /** 浮点数键盘 */
        case PayFloatInputType:
        {
            [self.replaceBtn setTitle:@"." forState:UIControlStateNormal];
            break;
        }
            /** 身份证键盘 */
        case PayIDCardInputType:
        {
            [self.replaceBtn setTitle:@"X" forState:UIControlStateNormal];
            break;
        }
            /** 数字键盘 */
        default:
        {
            self.replaceBtn.hidden = YES;
            break;
        }
    }
}

- (IBAction)keyboardViewAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    
    switch (tag)
    {
        case 1010:
        {
            /** 小数点 */
        if (self.inputType == PayFloatInputType) {
            if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"."])
                [self.textInput insertText:@"."];
        }else{
            /** 身份证 */
            if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"X"])
               [self.textInput insertText:@"X"];
        }
            
        }
            break;
        case 1011:
        {
            /** 隐藏键盘 */
            [self.textInput resignFirstResponder];
        }
            break;
        case 1012:
        {
            /** 删除 */
            if(self.textInput.text.length > 0)
                [self.textInput deleteBackward];
        }
            break;
        case 1013:
        {
            /** 确认 */
            [self.textInput resignFirstResponder];
        }
            break;
        default:
        {
            /** 数字 */
            NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
            [self.textInput insertText:text];
        
            if(self.interval && (self.textInput.text.length+1) % ([self.interval integerValue] + 1) == 0)
                [self.textInput insertText:@" "];
        }
            break;
    }
}

- (void)setInterval:(NSNumber *)interval{
    _interval = interval;
}

#pragma mark -- UIKeyInput 协议相关

/**  判断数据是否为空*/
- (BOOL)hasText;{
    return self.textInput.text.length > 0;
}

/** 重新写入数据*/
- (void)insertText:(NSString *)text;{
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:self.textInput.text];
    [mutableStr appendString:text];
    [self setNeedsDisplay];
}

/** 删除按钮*/
- (void)deleteBackward;{
    if ([self.textInput.text length] == 0) {
        return;
    }
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:self.textInput.text];
    NSRange theRange = NSMakeRange(self.textInput.text.length - 1, 1);
    [mutableStr deleteCharactersInRange:theRange];
    /** 重新写入数据*/
    [self setNeedsDisplay];
}

@end


