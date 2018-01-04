//
//  ProgressHUD.h
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/6.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressHUD : UIView

//** 动画消失 */
+ (void)dismiss;

/** UIActivityIndicatorView转圈动画 */
+ (void)pleaseWait;

/** UIActivityIndicatorView转圈+文字 正在处理中... */
+ (void)progressPopUp:(NSString *)status;

/** UIImageView有关的帧动画 */
+ (void)pleaseWaitImageView;

/** 成功的动画提示 */
+ (void)showSuccess:(NSString *)status;

/** 失败的动画提示 */
+ (void)showError:(NSString *)status;

/** 文字提示*/
+ (void)showMessage:(NSString *)status;

@end
