//
//  LPUserModel.h
//  PenFan
//
//  Created by iOS on 16/5/17.
//  Copyright © 2016年 kaifa001. All rights reserved.
//


#import "BaseModel.h"
@interface LPUserModel : BaseModel
@property (nonatomic, assign) NSInteger uID;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *logintype;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, assign) NSInteger point;
@property (nonatomic, assign) NSInteger exp;
@property (nonatomic, assign) NSInteger nextexppoint;
@property (nonatomic, assign) NSInteger lv;
@property (nonatomic, copy) NSString *remember_token;
@property (nonatomic, copy) NSString *verfgttoken;
@property (nonatomic, assign) NSInteger publishct;
@property (nonatomic, assign) NSInteger auditct;
@property (nonatomic, assign) NSInteger isver;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *deleted_at;
@property (nonatomic, copy) NSString *logintime;
@property (nonatomic, assign) NSInteger status_at;
@property (strong,nonatomic) NSString *token;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
