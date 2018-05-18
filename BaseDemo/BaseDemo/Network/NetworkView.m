//
//  NetworkView.m
//  TGX
//
//  Created by 朴子hp on 2018/4/26.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "NetworkView.h"

@interface NetworkView ()

//建立无网状态/ \请求失败下界面
@property (nonatomic, strong) UIView *badView;

//建立数据错误界面
@property (nonatomic, strong) UIView *errorView;

@end


@implementation NetworkView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpMainUI];
    }
    return self;
}

#pragma mark -- 无网状态下视图的建立
- (UIView *)badView{
    if (!_badView) {
        _badView = [[UIView alloc]init];
        _badView.frame = CGRectMake(0, 180, kScreen_Width, 200);
        
        UIImageView *badImage = [[UIImageView alloc]init];
        badImage.image = [UIImage imageNamed:@"net_def"];
        badImage.frame = CGRectMake(kScreen_Width/2 - 44, 0, 87,87 );
        [_badView addSubview:badImage];
        
        UILabel *desLab = [[UILabel alloc]init];
        desLab.frame = CGRectMake(125, 105, kScreen_Width - 250, 30);
        desLab.text = @"网络出了点问题";
        desLab.textColor = RGBOFColor(0xaaaaaa);
        desLab.textAlignment = NSTextAlignmentCenter;
        desLab.font = [UIFont systemFontOfSize:12.0f];
        [_badView addSubview:desLab];
        
        UIButton *refreBtn = [[UIButton alloc]init];
        refreBtn.frame = CGRectMake(125, desLab.y + 50, kScreen_Width - 250, 35);
        refreBtn.layer.cornerRadius =17.50f;
        refreBtn.layer.borderWidth = 1;
        refreBtn.layer.borderColor = RGBOFColor(0xaaaaaa).CGColor;
        refreBtn.layer.masksToBounds = YES;
        [refreBtn setTitle:@"刷新看看" forState:UIControlStateNormal];
        [refreBtn setTitleColor:RGBOFColor(0x000000) forState:UIControlStateNormal];
        [refreBtn addTarget:self action:@selector(refreshUI:) forControlEvents:UIControlEventTouchUpInside];
        [_badView addSubview:refreBtn];
        
    }
    return _badView;
}
#pragma mark -- 数据错误视图的建立
- (UIView *)errorView{
    if (!_errorView) {
        _errorView = [[UIView alloc]init];
        _errorView.frame = CGRectMake(0, 180, kScreen_Width, 200);
        
        UIImageView *badImage = [[UIImageView alloc]init];
        badImage.image = [UIImage imageNamed:@"data_def"];
        badImage.frame = CGRectMake(kScreen_Width/2 - 44, 0, 87,87 );
        [_errorView addSubview:badImage];
        
        UILabel *desLab = [[UILabel alloc]init];
        desLab.frame = CGRectMake(125, 105, kScreen_Width - 250, 30);
        desLab.text = @"糟糕,数据出问题了!";
        desLab.textColor = RGBOFColor(0xaaaaaa);
        desLab.textAlignment = NSTextAlignmentCenter;
        desLab.font = [UIFont systemFontOfSize:12.0f];
        [_errorView addSubview:desLab];
        
        UIButton *backBtn = [[UIButton alloc]init];
        backBtn.frame = CGRectMake(58, desLab.y + 50, kScreen_Width/2 - 68, 35);
        backBtn.layer.cornerRadius = 17.50f;
        backBtn.layer.borderWidth = 1;
        backBtn.layer.borderColor = RGBOFColor(0xaaaaaa).CGColor;
        backBtn.layer.masksToBounds = YES;
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:RGBOFColor(0x000000) forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backLeft:) forControlEvents:UIControlEventTouchUpInside];
        [_errorView addSubview:backBtn];
        
        UIButton *refreBtn = [[UIButton alloc]init];
        refreBtn.frame = CGRectMake(kScreen_Width/2 + 10 , desLab.y + 50, kScreen_Width/2 - 68, 35);
        refreBtn.layer.cornerRadius = 17.50f;
        refreBtn.layer.borderWidth = 1;
        refreBtn.layer.borderColor = RGBOFColor(0xaaaaaa).CGColor;
        refreBtn.layer.masksToBounds = YES;
        [refreBtn setTitle:@"刷新看看" forState:UIControlStateNormal];
        [refreBtn setTitleColor:RGBOFColor(0x000000) forState:UIControlStateNormal];
        [refreBtn addTarget:self action:@selector(refreshUI:) forControlEvents:UIControlEventTouchUpInside];
        [_errorView addSubview:refreBtn];
        
    }
    return _errorView;
}
#pragma mark -- 建立相关加载动画
- (void)setUpMainUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}
#pragma mark -- 建立相关加载动画
- (void)setUpLodingView{
    
    [ProgressHUD pleaseWait];
    
}
#pragma amrk -- 相关网络状态的处理
- (void)setState:(NetworkStatus)status{
    
    _status = status;
    self.hidden = NO;
    
    switch (status) {
        case NetworkStatusError:{
            [ProgressHUD dismiss];
            [self.errorView removeFromSuperview];
            [self addSubview:self.badView];
        } break;
        case NetworkStatusLoading:{
            [self.badView removeFromSuperview];
            [self.errorView removeFromSuperview];
            [self setUpLodingView];
        } break;
        case NetworkStatusSuccess:{
            [self.badView removeFromSuperview];
            [self.errorView removeFromSuperview];
            [ProgressHUD dismiss];
            self.hidden = YES;
        } break;
        case NetworkStatusDataError:{
            [ProgressHUD dismiss];
            [self.badView removeFromSuperview];
            [self addSubview:self.errorView];
        } break;
        default:
            break;
    }
}

#pragma mark -- 刷新界面
- (void)refreshUI:(UIButton *)btn;{
    
    if ([self.delegate respondsToSelector:@selector(refreshViewUI:)]) {
        [self.delegate refreshViewUI:btn];
    }
}

#pragma mark -- 返回相关
- (void)backLeft:(UIButton *)btn;{
    
    if ([self.delegate respondsToSelector:@selector(backLeftTouch:)]) {
        [self.delegate backLeftTouch:btn];
    }
}

@end
