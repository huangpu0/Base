//
//  HomePageViewController.m
//  BaseDemo
//
//  Created by 朴子hp on 2017/12/5.
//  Copyright © 2017年 朴子hp. All rights reserved.
//

#import "HomePageViewController.h"
#import "FilesManager.h"
@interface HomePageViewController ()<UISearchControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *teView;
@property (weak, nonatomic) UIImageView *testView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationWithTitle:@"首页"];
    
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
    [ProgressHUD showMessage:@"你说的好的"];
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
