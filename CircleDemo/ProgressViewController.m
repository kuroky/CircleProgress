//
//  ProgressViewController.m
//  CircleDemo
//
//  Created by kuroky on 2017/12/6.
//  Copyright © 2017年 kuroky. All rights reserved.
//

#import "ProgressViewController.h"
#import "ProgressCell.h"
#import "CircleCell.h"

static NSString *const kCellId  =   @"cellId";
static NSString *const KCircleCellId    =   @"circleCellId";

@interface ProgressViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (assign, nonatomic) NSInteger cellType;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellType = 1;
    self.dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        [self.dataList addObject:@""];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Switch"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(tapRightBar)];
    self.tableView.rowHeight = 60;
    UINib *nib = [UINib nibWithNibName:@"ProgressCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kCellId];
    
    nib = [UINib nibWithNibName:@"CircleCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:KCircleCellId];
}

- (void)tapRightBar {
    if (self.cellType == 1) {
        self.cellType = 2;
    }
    else {
        self.cellType = 1;
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellType == 1) {
        ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
        return cell;
    }
    else {
        CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:KCircleCellId forIndexPath:indexPath];
        return cell;
    }
}

//MARK:- UITableViewDataSource

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
