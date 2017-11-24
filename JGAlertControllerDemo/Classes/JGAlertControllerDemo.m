//
//  JGAlertControllerDemo.m
//  JGAlertControllerDemo
//
//  Created by Mei Jigao on 2017/11/24.
//  Copyright © 2017年 MeiJigao. All rights reserved.
//

#import "JGAlertControllerDemo.h"
#import "JGSourceBase.h"
#import "JGAlertController.h"

@interface JGAlertControllerDemo ()

@end

@implementation JGAlertControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JGEnableLogWithMode(JGLogModeFunc);
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.rowHeight = 44;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JGReuseIdentifier(UITableViewCell)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 8;
            break;
            
        case 1:
            return 4;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGReuseIdentifier(UITableViewCell) forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0: {
            
            NSString *titles[8] = {
                @"Alert",
                @"Alert with action",
                @"Alert with other",
                @"Alert with destructive",
                @"Alert with others",
                @"Alert with destructive and others",
                @"Alert with click alert",
                @"Alert after alert with 2 seconds",
            };
            
            [cell.textLabel setText:titles[indexPath.row]];
        }
            break;
            
        case 1: {
            
            NSString *titles[4] = {
                @"Action sheet",
                @"Action sheet with destructive",
                @"Action sheet with click alert",
                @"Action sheet after action sheet with 2 seconds",
            };
            
            [cell.textLabel setText:titles[indexPath.row]];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Alert";
            break;
            
        case 1:
            return @"Action sheet";
            break;
            
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case 0: {
            
            switch (indexPath.row) {
                case 0: {
                    
                    [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel"];
                }
                    break;
                    
                case 1: {
                    
                    [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel" action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        JGLog(@"Tap button : %zd", idx);
                    }];
                }
                    break;
                    
                case 2: {
                    
                    [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel" other:@"Other" action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                    }];
                }
                    break;
                    
                case 3: {
                    
                    [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel" destructive:@"Destructive" action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                    }];
                }
                    break;
                    
                case 4: {
                    
                    [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel" others:@[@"Other 1", @"Other 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                    }];
                }
                    break;
                    
                case 5: {
                    
                    [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Other 1", @"Other 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                    }];
                }
                    break;
                    
                case 6: {
                    
                    [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Other 1", @"Other 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                        [JGAlertController alertWithTitle:@"Inner Title" message:@"Inner Message" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Other 1", @"Other 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                            
                            JGLog(@"Tap button : %zd", idx);
                        }];
                    }];
                }
                    break;
                    
                case 7: {
                    
                    [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        JGLog(@"New alert");
                        [JGAlertController alertWithTitle:@"Title" message:@"Message" cancel:@"Cancel"];
                    });
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1: {
            
            switch (indexPath.row) {
                case 0: {
                    
                    [JGAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                    }];
                }
                    break;
                    
                case 1: {
                    
                    [JGAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                    }];
                }
                    break;
                    
                case 2: {
                    
                    [JGAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                        [JGAlertController alertWithTitle:@"Inner Title" message:@"Inner Message" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Other 1", @"Other 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                            
                            JGLog(@"Tap button : %zd", idx);
                        }];
                    }];
                }
                    break;
                    
                case 3: {
                    
                    [JGAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                        
                        JGLog(@"Tap button : %zd", idx);
                    }];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        JGLog(@"New action sheet");
                        [JGAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                            
                            JGLog(@"Tap button : %zd", idx);
                        }];
                    });
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - End

@end
