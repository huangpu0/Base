//
//  NetworkView.h
//  TGX
//
//  Created by 朴子hp on 2018/4/26.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
   网络状态相关描述
 - NetStateError: 网络引起的错误
 - NetStateLoading: 网络加载状态
 - NetStateSuccess: 网络状态完好
 - NetStateDataError: 网络数据引起的错误
 */

typedef NS_ENUM(NSInteger, NetState) {
    NetStateError = 0,
    NetStateLoading = 1,
    NetStateSuccess = 2,
    NetStateDataError = 3,
};

@protocol NetworkViewDelegate <NSObject>

/**
  刷新,返回代理
 */
@required
- (void)refreshViewUI:(UIButton *)btn;

@optional
- (void)backLeftTouch:(UIButton *)btn;

@end

@interface NetworkView : UIView

@property (nonatomic, weak) id<NetworkViewDelegate>delegate;

@property (nonatomic, assign) NetState state;


@end
