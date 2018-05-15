//
//  HomePageViewController.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "HomePageViewController.h"
#import "FilesManager.h"
#import "FireworksView.h"
#import "PlaneView.h"
#import "SportsCarView.h"
#import "RocketView.h"
#import "UIView+Extension.h"
#import "DiamondView.h"

@interface HomePageViewController ()<UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *teView;

@property (weak, nonatomic) UIImageView *testView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationWithTitle:@"首页"];
    
    [HttpServer downloadFileWithURL:@"http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4" withParameters:nil downloadCreateDirectoryName:nil withProgressBlock:^(NSProgress *progress) {
        
    } withSuccessBlock:^(id response) {
        NSLog(@"文件地址==%@",response);
    } withFailureBlock:^(NSError *error) {
        
    }];
}
-(void)setNavigationWithTitle:(NSString *)title{
    [super setNavigationWithTitle:title];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    if ([title isEqualToString:@"首页"]) {
        UISegmentedControl *seController = [[UISegmentedControl alloc]initWithItems:@[@"商品",@"评论",]];
        seController.selectedSegmentIndex = 0;
        seController.tintColor = [UIColor blackColor];
        [seController setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
        [seController setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
        [seController addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = seController;
    }
}
- (IBAction)sureBtn:(id)sender {

    SportsCarView *car = [SportsCarView loadCarViewWithPoint:CGPointZero];
    NSMutableArray *pointArrs = [[NSMutableArray alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 2;
    [pointArrs addObject:NSStringFromCGRect(CGRectMake(width, 300, width, 300))];
    car.curveControlAndEndPoints = pointArrs;
    [car addAnimationsMoveToPoint:CGPointMake(self.view.bounds.size.width, 300) endPoint:CGPointMake(-166, 0)];
    [self.view addSubview:car];

}
- (void)selectItem:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"商品详情");
    }else{
        NSLog(@"评论详情");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
