//
//  MJHeadTool.m
//  Tool
//
//  Created by iOS开发 on 16/7/29.
//  Copyright © 2016年 iOS开发. All rights reserved.
//

#import "MJHeadTool.h"

@implementation MJHeadTool
-(void)prepare
{
    [super prepare];
    NSMutableArray *imagesArray = [NSMutableArray array];
    for (int i = 1; i <= 10; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i]];
        [imagesArray addObject:image];
    }
    [self setImages:imagesArray forState:MJRefreshStateIdle];
    [self setImages:imagesArray forState:MJRefreshStatePulling];
    //设置正在刷新的状态动画 
    [self setImages:imagesArray forState:MJRefreshStateRefreshing];
}
@end
