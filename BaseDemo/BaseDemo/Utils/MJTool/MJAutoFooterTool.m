//
//  MJAutoFooterTool.m
//  Tool
//
//  Created by iOS开发 on 16/8/1.
//  Copyright © 2016年 iOS开发. All rights reserved.
//

#import "MJAutoFooterTool.h"

@implementation MJAutoFooterTool
#pragma mark 在这里做一些初始化配置（比如添加子控件）
-(void)prepare
{
    [super prepare];
    //设置控件的高度
    self.mj_h = 50;
    
    //添加label
    UILabel *label = [[UILabel alloc]init];;
    label.textColor = RGBColor(1.0, 0.5, 0);
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    //loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:    UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:loading];
    self.loading = loading;
}
#pragma mark 在这里设置子控件的位置和尺寸
-(void)placeSubviews
{
    [super placeSubviews];
    self.label.frame = self.bounds;
    self.loading.center = CGPointMake(kScreen_Width *0.2, self.mj_h *0.5);
}
#pragma mark 在这里监听控件的刷新状态
-(void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"客官,再加把劲";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在努力加载...";
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"客官,没有最新数据了";
            break;
   
        default:
            break;
    }
}
@end
