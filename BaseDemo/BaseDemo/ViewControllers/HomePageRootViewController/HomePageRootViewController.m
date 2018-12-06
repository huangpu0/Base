//
//  HomePageRootViewController.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/15.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "HomePageRootViewController.h"
#import "TestModel.h"

@interface HomePageRootViewController ()

@end

@implementation HomePageRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dic = @[@{
                          @"test":@"hhh"
                          }];
    NSArray *model = [TestModel modelArrayWithDataArray:dic];
    TestModel *temModel = model[0];
    NSLog(@"ttet---%@",temModel.test);
    
    NSDictionary *dict = @{
                          @"appType": @"1",
                          @"systemType" : @"2"
       };
    //?appType=1&systemType=2
    [HttpServer requestPostMethodWithURL:@"http://192.168.0.198:18080/v1/sys/versionMessage" withParameters:dict withSuccessBlock:^(id response) {
        NSLog(@"ttt--%@",response[@"msg"]);
    } withFailureBlock:^(NSError *error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
