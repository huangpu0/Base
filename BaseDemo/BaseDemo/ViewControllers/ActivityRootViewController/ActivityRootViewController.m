//
//  ActivityRootViewController.m
//  BaseDemo
//
//  Created by 朴子hp on 2018/5/15.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

#import "ActivityRootViewController.h"
#import "AnimationTableViewCell.h"
#import "LiveAnimationViewController.h"
@interface ActivityRootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ActivityRootViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabView];
}

#pragma mark -- 构建主要视图
- (void)setUpTabView{
    
    NSArray *array = [NSArray arrayWithObjects:@"烟花动画",@"跑车动画",@"飞机动画",@"刷火箭",@"钻石动画",@"雪花", nil];
    [self.dataArray addObjectsFromArray:array];
    
    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    self.tabView.tableFooterView = [UIView new];
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tabView registerClass:[AnimationTableViewCell class] forCellReuseIdentifier:@"animationCell"];
    [self.view addSubview:self.tabView];
    
}
#pragma mark -- UITableViewDataSource,UITableViewDelegate 数据源及代理
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identity = @"animationCell";
    AnimationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[AnimationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveAnimationViewController *animationVC = [[LiveAnimationViewController alloc]init];
    animationVC.tag = indexPath.row;
    [self.navigationController pushViewController:animationVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
