//
//  DiamondView.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/12.
//  Copyright © 2018年 朴子hp. All rights reserved.
//  帧动画

#import "DiamondView.h"

@implementation DiamondView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.gifImageView.frame = frame;
        [self startAnimation];
        [self addSubview:_gifImageView];
    }
    return self;
}

- (void)startAnimation{
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (int i = 1; i < 26; i ++) {
        
        NSString *strImage = [NSString stringWithFormat:@"meteor_after_%d",i];
        
        UIImage *image =  [UIImage imageNamed:strImage];;
        
        [tempArr addObject:image];
        
    }
    
    _gifImageView.animationImages = tempArr;
    
    _gifImageView.animationDuration = 2.5f;
    
    _gifImageView.animationRepeatCount = 1;
    
    [_gifImageView startAnimating];
    
    [self performSelector:@selector(deleteGif:) withObject:nil afterDelay:3];
}

//释放内存
- (void)deleteGif:(id)object{
    [_gifImageView stopAnimating];
    _gifImageView.animationImages = nil;
    [self removeFromSuperview];
}

- (UIImageView *)gifImageView{
    if (_gifImageView == nil) {
        _gifImageView = [[UIImageView alloc]init];
    }
    return _gifImageView;
}

@end
