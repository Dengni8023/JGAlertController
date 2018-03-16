//
//  JGACAlertController.m
//  JGAlertController
//
//  Created by 梅继高 on 2018/6/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "JGACAlertController.h"
#import "UIViewController+JGACAlertController.h"

@implementation JGACAlertController

#pragma mark - Alert
+ (BOOL)hideAlert {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window = window ?: [[UIApplication sharedApplication] windows].firstObject;
    UIViewController *vcT = window.rootViewController;
    while (vcT.presentedViewController) {
        vcT = vcT.presentedViewController;
        if ([vcT isKindOfClass:[UIAlertController class]]) {
            [vcT dismissViewControllerAnimated:YES completion:^{
                
            }];
            return YES;
        }
    }
    
    return NO;
}

+ (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    return [self alertWithTitle:title message:message cancel:nil];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel {
    return [self alertWithTitle:title message:message cancel:cancel action:nil];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel action:(JGACAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel other:nil action:btnAction];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other action:(JGACAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel others:[NSArray arrayWithObjects:other, nil] action:btnAction];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive action:(JGACAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel destructive:destructive others:nil action:btnAction];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel others:(NSArray<NSString *> *)others action:(JGACAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel destructive:nil others:others action:btnAction];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others action:(JGACAlertControllerAction)btnAction {
    return [self shoWithTitle:title message:message style:UIAlertControllerStyleAlert cancel:cancel destructive:destructive others:others action:btnAction];
}

#pragma mark - ActionSheet
+ (UIAlertController *)actionSheetWithTitle:(NSString *)title cancel:(NSString *)cancel others:(NSArray<NSString *> *)others action:(JGACAlertControllerAction)btnAction {
    return [self actionSheetWithTitle:title cancel:cancel destructive:nil others:others action:btnAction];
}

+ (UIAlertController *)actionSheetWithTitle:(NSString *)title cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others action:(JGACAlertControllerAction)btnAction {
    return [self shoWithTitle:title message:nil style:UIAlertControllerStyleActionSheet cancel:cancel destructive:destructive others:others action:btnAction];
}

#pragma mark - UIAlertController
+ (UIAlertController *)shoWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others action:(JGACAlertControllerAction)btnAction {
    
    UIViewController *vcT = [self viewControllerForPresent];
    switch (style) {
        case UIAlertControllerStyleAlert:
            return [vcT jg_alertWithTitle:title message:message cancel:cancel destructive:destructive others:others btnAction:btnAction];
            break;
            
        case UIAlertControllerStyleActionSheet:
            return [vcT jg_actionSheetWithTitle:(title.length > 0 ? title : message) cancel:cancel destructive:destructive others:others btnAction:btnAction];
            break;
    }
}

+ (UIViewController *)viewControllerForPresent {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window = window ?: [[UIApplication sharedApplication] windows].firstObject;
    UIViewController *vcT = window.rootViewController;
    while (vcT.presentedViewController) {
        vcT = vcT.presentedViewController;
    }
    return vcT;
}

#pragma mark - End

@end

@implementation JGAlertController

@end
