//
//  ViewController.h
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NetworkView;

@interface ViewController : UIViewController

/**
  是否隐藏导航栏 默认 NO
 */
@property BOOL currentViewNavigationBarHidden;

/**
  导航栏 -- >> 相关设置
 */
-(void)setNavigationBar;


/**
   导航栏 -- >> 显示文字
 @param title 导航栏显示文字
 */
-(void)setNavigationWithTitle:(NSString *)title;

/**
  导航栏文字➕左返回按钮 【leftTitle -->>  nil 显示默认返回按钮图片 / \ 文字显示图片+文字形式】
 @param title 导航栏显示文字
 @param leftTitle 返回按钮
 */
-(void)setNavigationWithTitle:(NSString *)title leftBtnWithTitle:(NSString *)leftTitle;

/**
 导航栏文字➕左返回按钮➕右侧文字 【rightTitle -->>  右侧显示文字 】
 @param title 导航栏显示文字
 @param rightTitle 右侧显示文字
 @param leftTitle  返回按钮
 */
-(void)setNavigationWithTitle:(NSString *)title rightBtnWithTitle:(NSString *)rightTitle leftBtnWithTitle:(NSString *)leftTitle;

/**
  导航栏文字➕左返回按钮➕右侧显示图片【rightImageName -->>  右侧显示图片】
 @param title 导航栏显示文字
 @param rightImageName 右侧显示图片
 @param leftTitle 返回按钮
 */
-(void)setNavigationWithTitle:(NSString *)title rightBtnWithImageName:(NSString *)rightImageName leftBtnWithTitle:(NSString *)leftTitle;


/**
 导航栏文字➕左返回按钮➕右侧双图片【rightTitle -->>  右侧显示图片】
 @param title 导航栏显示文字
 @param rightImageName 最右侧显示图片
 @param rightOtherIamgeName 紧挨最右侧显示图片
 @param leftTitle 返回按钮
 */
-(void)setNavigationWithTitle:(NSString *)title rightBtnWithImageName:(NSString *)rightImageName rightBtnWithOtherImageName:(NSString *)rightOtherIamgeName leftBtnWithTitle:(NSString *)leftTitle;

/**
 用这个方法重写导航后 没法右滑返回 需要实现以下这个方法才能返回
 */
// 导航条左按钮返回触发的方法
-(void)touchLeftBtn;

//  导航条右按钮触发的方法
-(void)touchRightBtn;

// 导航条紧挨最右侧右按钮触发的方法
-(void)touchOtherRightBtn;

/**
 获取当前APP网络状态自动刷新数据,刷新当前页面,返回上一页
 */

@property(strong, nonatomic) NetworkView *netView;

- (void)getNetworkStatus:(NSNotification *)notice;

- (void)refreshViewUI:(UIButton *)btn;

- (void)backLeftTouch:(UIButton *)btn;


@end

