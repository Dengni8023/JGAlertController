//
//  ViewController.m
//  JGAlertControllerDemo
//
//  Created by Mei Jigao on 2018/3/16.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "ViewController.h"
#import <JGSourceBase/JGSourceBase.h>
#import "JGDemoTableData.h"
#import "AlertTableViewController.h"
#import "ActionSheetTableViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray<JGDemoTableSectionData *> *demoData;

@end

@implementation ViewController

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
    
    JGSCWeak(self);
    _demoData = @[
                  JGDemoTableSectionMake(@"",
                                         @[
                                           JGDemoTableRowMakeBlock(@"Alert", ^(JGDemoTableRowData * _Nonnull rowData) {
                      
                      JGSCStrong(self);
                      AlertTableViewController *vcT = [[AlertTableViewController alloc] init];
                      [self.navigationController pushViewController:vcT animated:YES];
                  }),
                                           JGDemoTableRowMakeBlock(@"Action Sheet", ^(JGDemoTableRowData * _Nonnull rowData) {
                      
                      JGSCStrong(self);
                      ActionSheetTableViewController *vcT = [[ActionSheetTableViewController alloc] init];
                      [self.navigationController pushViewController:vcT animated:YES];
                  }),
                                           ]),
                  ];
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
