//
//  ViewController.m
//  CircleDemo
//
//  Created by kuroky on 2017/7/29.
//  Copyright © 2017年 kuroky. All rights reserved.
//

#import "ViewController.h"
#import "SingleDemoViewController.h"
#import "MultiDemoViewController.h"
#import "ProgressViewController.h"

static NSString *const  kViewControllerCell  =   @"viewControllerCell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupData {
    self.dataList = @[@"Demo1", @"Demo2", @"Progress"];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kViewControllerCell];
}

#pragma mark - UITableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kViewControllerCell
                                                            forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

#pragma mark _ UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.dataList[indexPath.row];
    if ([title isEqualToString:@"Demo1"]) {
        [self.navigationController pushViewController:[SingleDemoViewController new]
                                             animated:YES];
    }
    else if ([title isEqualToString:@"Demo2"]) {
        [self.navigationController pushViewController:[MultiDemoViewController new]
                                             animated:YES];
    }
    else if ([title isEqualToString:@"Progress"]) {
        [self.navigationController pushViewController:[ProgressViewController new]
                                             animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
