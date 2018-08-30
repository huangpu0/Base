//
//  ProgressHUD.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/6.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "ProgressHUD.h"

#define kBackViewWidth 100.0f
#define kBackViewHeight 100.0f
#define kImageViewWidth 100.0f

#define kMainWidth [UIScreen mainScreen].bounds.size.width
#define kMainHeight [UIScreen mainScreen].bounds.size.height

@interface ProgressHUD ()

@property (nonatomic, strong) UIWindow *kWindow;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIActivityIndicatorView *kWhirlView;
@property (nonatomic, strong) UIImageView *kImageView;
@property (nonatomic, strong) UILabel *kLabel;

@end

@implementation ProgressHUD

+ (ProgressHUD *)sharedView{
    
    static ProgressHUD *sharedView;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedView = [[ProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    });
    return sharedView;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

/**
 动画消失
 */
+ (void)dismiss{
    [[ProgressHUD sharedView] dismiss];
}
- (void)dismiss{
    [self.kImageView stopAnimating];
    [self.kWhirlView stopAnimating];
    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:_kWindow];
    _kWindow = nil;
}

/**
 UIActivityIndicatorView转圈动画
 */
+ (void)pleaseWait;{
    [[ProgressHUD sharedView]pleaseWait];
}
-(void)pleaseWait;{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.superview) [self.kWindow addSubview:self];
        [self.kWindow makeKeyAndVisible];
        if (!self.superview) [self.kWindow addSubview:self];
        [self.kWindow makeKeyAndVisible];
        self.kWhirlView.center = CGPointMake(kBackViewWidth/2, kBackViewHeight/2);
        //通过transform来修改显示UIActivityIndicatorView的大小。
        CGAffineTransform transform = CGAffineTransformMakeScale(1.5f,1.5f);
        self.kWhirlView.transform = transform;
        [self.kWhirlView startAnimating];
    });
}

/**
  UIActivityIndicatorView转圈+文字 正在处理中...
 */
+ (void)progressPopUp:(NSString *)status;{
    [[ProgressHUD sharedView]progressPopUp:status];
}
- (void)progressPopUp:(NSString *)status;{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.superview)
        [self.kWindow addSubview:self];
        [self.kWindow makeKeyAndVisible];
        self.kLabel.text = status;
        self.kWhirlView.center = CGPointMake(kBackViewWidth/2, kBackViewHeight/2-10);
        //通过transform来修改显示UIActivityIndicatorView的大小。
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f,1.0f);
        self.kWhirlView.transform = transform;
        [self.kWhirlView startAnimating];
    });
}

/**
 UIImageView有关的帧动画
 */
+(void)pleaseWaitImageView{
    [[ProgressHUD sharedView]pleaseWaitImageView];
}
-(void)pleaseWaitImageView{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.superview) [self.kWindow addSubview:self];
        [self.kWindow makeKeyAndVisible];
        [self.kImageView startAnimating];
    });
}

/**
 成功的动画提示
 */
+ (void)showSuccess:(NSString *)status;{
    [[ProgressHUD sharedView]showSuccess:status];
}
- (void)showSuccess:(NSString *)status;{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.superview) [self.kWindow addSubview:self];
        [self.kWindow makeKeyAndVisible];
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource: @"ProgressHUD" ofType :@"bundle"];
        NSString *successImgPath= [bundlePath stringByAppendingPathComponent:@"success.png"];
        self.kImageView.frame = CGRectMake((kBackViewWidth-30)/2, 20, 30, 30);
        self.kImageView.image = [UIImage imageWithContentsOfFile:successImgPath];
        [self.backView addSubview:self.kImageView];
        self.kLabel.text = status;
        self.backView.alpha = 1.0f;
        [UIView animateWithDuration:1.0f animations:^{
            self.backView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self dismiss];
        }];
    });
}

/**
 失败的动画提示
 */
+ (void)showError:(NSString *)status;{
    [[ProgressHUD sharedView]showError:status];
}
- (void)showError:(NSString *)status;{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.superview) [self.kWindow addSubview:self];
        [self.kWindow makeKeyAndVisible];
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource: @"ProgressHUD" ofType :@"bundle"];
        NSString *successImgPath= [bundlePath stringByAppendingPathComponent:@"error.png"];
        self.kImageView.frame = CGRectMake((kBackViewWidth-30)/2, 20, 30, 30);
        self.kImageView.image = [UIImage imageWithContentsOfFile:successImgPath];
        [self.backView addSubview:self.kImageView];
        self.kLabel.text = status;
        self.backView.alpha = 1.0f;
        [UIView animateWithDuration:1.0f animations:^{
            self.backView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self dismiss];
        }];
    });
}

/**
 文字提示
 */
+ (void)showMessage:(NSString *)message{
    [[ProgressHUD sharedView]showMessage:message];
}
-(void)showMessage:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.superview) [self.kWindow addSubview:self];
        [self.kWindow makeKeyAndVisible];
        self.kLabel.text = message;
        CGFloat backWidth = [self getSizeWithString:message withFont:[UIFont systemFontOfSize:15] withWidth:300.0f].width;
        CGFloat backHeight = [self getSizeWithString:message withFont:[UIFont systemFontOfSize:15] withWidth:300.0f].height;
        self.kLabel.frame = CGRectMake(0, 0,backWidth , backHeight + 20);
        self.kLabel.center = CGPointMake((backWidth+50)/2, 25);
        self.backView.frame = CGRectMake((kMainWidth-backWidth-50)/2, (kMainHeight-backHeight)/2-50, backWidth+50,50);
        self.backView.alpha = 1.0f;
        [UIView animateWithDuration:1.5f animations:^{
            self.backView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self dismiss];
        }];
    });
}
-(CGSize)getSizeWithString:(NSString *)string withFont:(UIFont *)font withWidth:(CGFloat)width{
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
        return  rect.size;
    }
    else{
        NSDictionary *attributes = @{ NSFontAttributeName : font };
        return  [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:\
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                     attributes:attributes
                                        context:nil].size;
    }
}

/**
 Window界面
 */
- (UIWindow *)kWindow{
    if (!_kWindow) {
        _kWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _kWindow;
}

/**
 文字
 */
- (UILabel *)kLabel
{
    if (!_kLabel) {
        _kLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kBackViewHeight - 35, kBackViewWidth, 30)];
        _kLabel.textColor = [UIColor whiteColor];
        _kLabel.textAlignment = NSTextAlignmentCenter;
        _kLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _kLabel.numberOfLines = 0;
        [self.backView addSubview:_kLabel];
    }
    return _kLabel;
}

/**
 背景视图懒加载处理
 */
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake((kMainWidth - kBackViewWidth)/2,(kMainHeight - kBackViewHeight)/2-50, kBackViewWidth, kBackViewHeight)];
        _backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
        _backView.layer.cornerRadius = 10.f;
        _backView.layer.masksToBounds = YES;
        [self addSubview:_backView];
    }
    return _backView;
}

/**
 UIImageView懒加载处理
 */
- (UIImageView *)kImageView{
    if (_kImageView == nil) {
        _kImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kMainWidth - kImageViewWidth)/2,(kMainHeight - kImageViewWidth)/2-20, kImageViewWidth, kImageViewWidth)];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 11 ; i++) {
            NSString *imageName = [NSString stringWithFormat:@"gifs_%d", i];
            UIImage *image = [UIImage imageNamed:imageName];
            [array addObject:image];
        }
        [_kImageView  setAnimationImages:array];
        [_kImageView  setAnimationDuration:5.0f];
        [self addSubview:_kImageView ];
    }
    return _kImageView;
}

/**
 UIImageView懒加载处理
 */
-(UIActivityIndicatorView *)kWhirlView{
    if (_kWhirlView == nil) {
        _kWhirlView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.backView addSubview:_kWhirlView];
    }
    return _kWhirlView;
}

@end
