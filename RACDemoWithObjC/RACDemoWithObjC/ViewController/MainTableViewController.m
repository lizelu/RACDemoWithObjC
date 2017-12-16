//
//  MainTableViewController.m
//  RACDemoWithObjC
//
//  Created by lizelu on 2017/12/1.
//  Copyright © 2017年 lizelu. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()
@property (nonatomic) NSArray *dataSource;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RAC";
    [self createDataSource];
}

- (void)createDataSource {
    
    self.dataSource = @[@{@"title":@"BaseOperator", @"vc":@"RACBaseOperatorViewController"},
                        
                        @{@"title":@"ColdSignal", @"vc":@"ColdSignalViewController"},
                        
                        @{@"title":@"SignalSwitch", @"vc":@"SignalSwitchToLatestViewController"},
                        
                        @{@"title":@"SignalCombiningLatest", @"vc":@"SignalCombiningLatestViewController"},
                        
                        @{@"title":@"SignalMerge", @"vc":@"SignalMergeViewController"},
                        
                        @{@"title":@"RACSubject", @"vc":@"RACSubjectViewController"},
                        
                        @{@"title":@"RACReplaySubject", @"vc":@"RACReplaySubjectViewController"},
                        
                        @{@"title":@"RACObserve", @"vc":@"RACObserveViewController"},
                        
                        @{@"title":@"RAC(_,…)", @"vc":@"RACKeypathController"},
                        
                        @{@"title":@"Lgin", @"vc":@"RACCommandViewController"},
                        
                        @{@"title":@"RAC And FPS", @"vc":@"RACAndFPSViewController"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *vcInfo = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell" forIndexPath:indexPath];
    cell.textLabel.text = vcInfo[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *vcInfo = self.dataSource[indexPath.row];
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:vcInfo[@"vc"]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
