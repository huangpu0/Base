//
//  HpKeyboard.h
//  keng
//
//  Created by limeng on 16/5/16.
//  Copyright © 2016年 limeng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^KeyBlock)(NSInteger height);

@interface Keyboard : NSObject

/*
    移除监察者,控制器跳转的时候调用一下就行,也可不用调用
 */
+(void)KeyRemoveMonitor;

/**
 *  
 *
 *  添加监听键盘弹出或消失方法,
 *
 *  @param showBackBlock 键盘 弹出的回调block,可带动画效果
 *  @param dismissBackBlock 键盘 消失的回调block,带动画效果
 */
+(void)KeyAddMonitorWithShowBack:(KeyBlock)showBackBlock andDismissBlock:(KeyBlock)dismissBackBlock;

@end
