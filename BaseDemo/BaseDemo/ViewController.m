//
//  ViewController.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(instancetype)init{
    self = [super init];
    _currentViewNavigationBarHidden = NO;
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:_currentViewNavigationBarHidden animated:YES];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [UIViewController attemptRotationToDeviceOrientation];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
}

-(void)setNavigationBar{
    self.navigationController.navigationBar.translucent= NO;
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

/**
 导航栏   显示文字
 @param title 导航栏显示文字
 */
-(void)setNavigationWithTitle:(NSString *)title{
    [self setNavigationBar];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    if (title) {
        UILabel *titleLabel=[[UILabel alloc]init];
        titleLabel.text= title;
        [titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel sizeToFit];
        self.navigationItem.titleView=titleLabel;
    }
}

/**
 导航栏文字➕左返回按钮 【leftTitle -->>  nil 显示默认返回按钮图片 / \ 文字显示图片+文字形式】
 @param title 导航栏显示文字
 @param leftTitle 返回按钮
 */
-(void)setNavigationWithTitle:(NSString *)title leftBtnWithTitle:(NSString *)leftTitle{
    [self setNavigationWithTitle:title];
    if ([leftTitle isEqualToString:@""]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        view.backgroundColor = [UIColor blueColor];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *imgtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLeftBtn)];
        [view addGestureRecognizer:imgtap];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = [UIColor blackColor];
        imgView.frame = CGRectMake(0, 4, 13, 22);
        imgView.image = [UIImage imageNamed:@"nav_back"];
        [view addSubview:imgView];
        
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:view];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -6;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftBar];
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *imgtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLeftBtn)];
        [view addGestureRecognizer:imgtap];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(0, 4, 13, 22);
        imgView.image = [UIImage imageNamed:@"nav_back"];
        [view addSubview:imgView];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = leftTitle;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:15];
        [lab sizeToFit];
        lab.frame = CGRectMake(CGRectGetMaxX(imgView.frame) + 5, (view.frame.size.height - lab.frame.size.height)/2, lab.frame.size.width, lab.frame.size.height);
        [view addSubview:lab];
        
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:view];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -6;//这个数值可以根据情况自由变化
        
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftBar];
    }
}

/**
 导航栏文字➕左返回按钮➕右侧文字 【rightTitle -->>  右侧显示文字 】
 @param title 导航栏显示文字
 @param rightTitle 右侧显示文字
 @param leftTitle  返回按钮
 */
-(void)setNavigationWithTitle:(NSString *)title rightBtnWithTitle:(NSString *)rightTitle leftBtnWithTitle:(NSString *)leftTitle{
    [self setNavigationWithTitle:title leftBtnWithTitle:leftTitle];
    
    if (rightTitle) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn sizeToFit];
        [rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -12;//这个数值可以根据情况自由变化
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer,right];
    }
}

/**
 导航栏文字➕左返回按钮➕右侧显示图片【rightImageName -->>  右侧显示图片】
 @param title 导航栏显示文字
 @param rightImageName 右侧显示图片
 @param leftTitle 返回按钮
 */
-(void)setNavigationWithTitle:(NSString *)title rightBtnWithImageName:(NSString *)rightImageName leftBtnWithTitle:(NSString *)leftTitle{
    [self setNavigationWithTitle:title leftBtnWithTitle:leftTitle];
    if (rightImageName) {
        UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightImageName]];
        rightImage.backgroundColor = [UIColor blackColor];
        rightImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchRightBtn)];
        [rightImage addGestureRecognizer:imgTap];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = 0;//这个数值可以根据情况自由变化
        
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightImage];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightBtn];
    }
}

/**
 导航栏文字➕左返回按钮➕右侧双图片【rightImageName -->>  最右侧显示图片 / \ rightOtherIamgeName -->> 紧挨最右侧显示图片】
 @param title 导航栏显示文字
 @param rightImageName 最右侧显示图片
 @param rightOtherIamgeName 紧挨最右侧显示图片
 @param leftTitle 返回按钮
 */
-(void)setNavigationWithTitle:(NSString *)title rightBtnWithImageName:(NSString *)rightImageName rightBtnWithOtherImageName:(NSString *)rightOtherIamgeName leftBtnWithTitle:(NSString *)leftTitle;{
    [self setNavigationWithTitle:title leftBtnWithTitle:leftTitle];
    if (rightImageName&&rightOtherIamgeName) {
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setImage:[UIImage imageNamed:rightImageName] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn sizeToFit];
        [rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *rightOtherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightOtherBtn.frame = CGRectMake(0, 40, 35, 35);
        [rightOtherBtn setImage:[UIImage imageNamed:rightOtherIamgeName] forState:UIControlStateNormal];
        [rightOtherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightOtherBtn sizeToFit];
        [rightOtherBtn addTarget:self action:@selector(touchOtherRightBtn) forControlEvents:UIControlEventTouchUpInside];
       
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        UIBarButtonItem *rightOtherItem = [[UIBarButtonItem alloc] initWithCustomView:rightOtherBtn];
        self.navigationItem.rightBarButtonItems = @[rightItem,rightOtherItem];
    }
}

#pragma mark -->> 导航条左按钮返回触发的方法
-(void)touchLeftBtn{
    //在子类中实现
     [self.navigationController popViewControllerAnimated:YES];
}

#pragma MARK -->> 导航条右侧按钮触发的方法
-(void)touchRightBtn{
    //在子类中实现
}

#pragma MARK -->> 导航条紧挨最右侧右按钮触发的方法
-(void)touchOtherRightBtn;{
    //在子类中实现
}

/**
 屏幕竖屏等设置相关处理
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotate{
    return YES;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end
