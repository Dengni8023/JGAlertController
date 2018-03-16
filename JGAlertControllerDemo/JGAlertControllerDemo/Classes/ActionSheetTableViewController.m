//
//  ActionSheetTableViewController.m
//  JGAlertControllerDemo
//
//  Created by Mei Jigao on 2018/3/16.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "ActionSheetTableViewController.h"
#import <JGSourceBase/JGSourceBase.h>
#import <JGAlertController/JGAlertController.h>
#import "JGDemoTableData.h"

@interface ActionSheetTableViewController ()

@property (nonatomic, strong) NSArray<JGDemoTableSectionData *> *demoData;

@end

@implementation ActionSheetTableViewController

#pragma mark - init & dealloc
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self initDatas];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        
        [self initDatas];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self initDatas];
    }
    return self;
}

- (void)initDatas {
    
    _demoData = @[
                  JGDemoTableSectionMake(@"",
                                         @[
                                           JGDemoTableRowMakeBlock(@"Action sheet", ^(JGDemoTableRowData * _Nonnull rowData) {
                      
                      [JGACAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                          
                          JGSCLog(@"Tap button : %zd", idx);
                      }];
                  }),
                                           JGDemoTableRowMakeBlock(@"Action sheet with destructive", ^(JGDemoTableRowData * _Nonnull rowData) {
                      
                      [JGACAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                          
                          JGSCLog(@"Tap button : %zd", idx);
                      }];
                  }),
                                           JGDemoTableRowMakeBlock(@"Action sheet with click alert", ^(JGDemoTableRowData * _Nonnull rowData) {
                      
                      [JGACAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                          
                          JGSCLog(@"Tap button : %zd", idx);
                          [JGACAlertController alertWithTitle:@"Inner Title" message:@"Inner Message" cancel:@"Cancel" destructive:@"Destructive" others:@[@"Other 1", @"Other 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                              
                              JGSCLog(@"Tap button : %zd", idx);
                          }];
                      }];
                  }),
                                           JGDemoTableRowMakeBlock(@"Action sheet after action sheet with 2 seconds", ^(JGDemoTableRowData * _Nonnull rowData) {
                      
                      [JGACAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                          
                          JGSCLog(@"Tap button : %zd", idx);
                      }];
                      
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          
                          JGSCLog(@"New action sheet");
                          [JGACAlertController actionSheetWithTitle:@"Title" cancel:@"Cancel" others:@[@"Action 1", @"Action 2"] action:^(UIAlertController * _Nonnull alert, NSInteger idx) {
                              
                              JGSCLog(@"Tap button : %zd", idx);
                          }];
                      });
                  }),
                                           ]),
                  ];
}

- (void)dealloc {
    
    JGSCLog(@"<%@: %p>", NSStringFromClass([self class]), self);
}

#pragma mark - Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    
    JGSCEnableLogWithMode(JGSCLogModeFunc);
    self.title = NSStringFromClass([self class]);
    
    self.clearsSelectionOnViewWillAppear = YES;
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.rowHeight = 44;
    self.tableView.sectionHeaderHeight = 48;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JGSCReuseIdentifier(UITableViewCell)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.demoData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoData[section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGSCReuseIdentifier(UITableViewCell) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = self.demoData[indexPath.section].rows[indexPath.row].title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.demoData[section].title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JGDemoTableRowData *rowData = self.demoData[indexPath.section].rows[indexPath.row];
    if (rowData.selectBlock) {
        rowData.selectBlock(rowData);
    }
}

#pragma mark - End

@end
