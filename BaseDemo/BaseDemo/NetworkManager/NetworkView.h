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
 - NetworkStatusError: 网络引起的错误
 - NetworkStatusLoading: 网络加载状态
 - NetworkStatusSuccess: 网络状态完好
 - NetworkStatusDataError: 网络数据引起的错误
 */

typedef NS_ENUM(NSInteger, NetworkStatus) {
    NetworkStatusError = 0,
    NetworkStatusLoading = 1,
    NetworkStatusSuccess = 2,
    NetworkStatusDataError = 3,
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

@property (nonatomic, assign) NetworkStatus status;


@end
