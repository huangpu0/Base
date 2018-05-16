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
    _currentViewNavigationBarHidden=NO;
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

-(void)setNavigationWithTitle:(NSString *)title leftBtnWithTitle:(NSString *)leftTitle{
    [self setNavigationWithTitle:title];
    if ([leftTitle isEqualToString:@""]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *imgtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLeftBtn)];
        [view addGestureRecognizer:imgtap];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(0, 6, 11, 18);
        imgView.image = [UIImage imageNamed:@"nav_back"];
        [view addSubview:imgView];
        
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:view];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -6;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftBar];
    }else if ([leftTitle isEqualToString:@"1"]){
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *imgtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchLeftBtn)];
        [view addGestureRecognizer:imgtap];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(0, 6, 11, 18);
        imgView.image = [UIImage imageNamed:@"nav_back"];
        [view addSubview:imgView];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = leftTitle;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:15];
        [lab sizeToFit];
        lab.frame = CGRectMake(CGRectGetMaxX(imgView.frame) + 3, (view.frame.size.height - lab.frame.size.height)/2, lab.frame.size.width, lab.frame.size.height);
        [view addSubview:lab];
        
        UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:view];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -6;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftBar];
    }
}

-(void)setNavigationWithTitle:(NSString *)title rightBtnWithImageName:(NSString *)imageName leftBtnWithTitle:(NSString *)leftTitle{
    [self setNavigationWithTitle:title leftBtnWithTitle:leftTitle];
    if (imageName) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer *imgtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchRightBtn)];
        [img addGestureRecognizer:imgtap];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = 0;//这个数值可以根据情况自由变化
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:img];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer,right];
    }
}

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
-(void)setNavigationWithTitle:(NSString *)title rightBtnWithImageName:(NSString *)imageName rightBtnWithTitle:(NSString *)rightTitle leftBtnWithTitle:(NSString *)leftTitle;{
    [self setNavigationWithTitle:title leftBtnWithTitle:leftTitle];
    if (rightTitle&&imageName) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn sizeToFit];
        [rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -12;//这个数值可以根据情况自由变化
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer,right];
    }
}

-(void)setNavigationWithTitle:(NSString *)title rightBtnWithBgImageName:(NSString *)rightName leftBtnWithTitle:(NSString *)leftTitle{
    [self setNavigationWithTitle:title leftBtnWithTitle:leftTitle];
    if ([rightName isEqualToString:@"1"]) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"home_ico_more"] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn sizeToFit];
        [rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -12;//这个数值可以根据情况自由变化
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer,right];
    }
    if (![rightName isEqualToString:@"筛选"]) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:rightName forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"d_nav_fb"] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn sizeToFit];
        [rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -12;//这个数值可以根据情况自由变化
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer,right];
    }
    if ([rightName isEqualToString:@"筛选"]){
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:rightName forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"e0_nav_btn"] forState:UIControlStateNormal];
        [rightBtn sizeToFit];
        [rightBtn addTarget:self action:@selector(touchRightBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -12;//这个数值可以根据情况自由变化
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer,right];
    }
}
#pragma mark - 点击左边按钮
-(void)touchLeftBtn{
    //在子类中实现
}
#pragma mark - 点击右边按钮
-(void)touchRightBtn{
    //在子类中实现
}
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
