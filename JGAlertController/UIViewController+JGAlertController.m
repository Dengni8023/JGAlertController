//
//  UIViewController+JGAlertController.m
//  JGAlertController
//
//  Created by Mei Jigao on 2017/11/24.
//  Copyright © 2017年 MeiJigao. All rights reserved.
//

#import "UIViewController+JGAlertController.h"
#import <objc/runtime.h>
#import "JGSourceBase.h"

#define JGAlertControllerMemoryDebugLog NO

@implementation UIAlertController (JGAlertController)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        // 重写的系统方法处理
        NSMutableArray<NSString *> *oriSelectors = [NSMutableArray array];
        if (JGAlertControllerMemoryDebugLog) {
            // 此处改写dealloc实现仅为了实现开发调试内存问题
            // dealloc仅用作日志输出检测页面释放情况
            // dealloc在ARC不能通过@selector获取
            [oriSelectors addObject:@"dealloc"];
        }
        
        for (NSString *oriSelName in oriSelectors) {
            
            SEL originSelector = NSSelectorFromString(oriSelName);
            SEL swizzledSelector = NSSelectorFromString([@"JGAlertController_" stringByAppendingString:oriSelName]);
            
            Method originMethod = class_getInstanceMethod(class, originSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            /**
             将自定义方法的实现添加到系统方法
             添加成功后将系统方法的实现添加到自定义方法
             添加失败则直接交换自定义方法与系统方法的实现
             */
            BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if (didAddMethod) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
            }
            else {
                method_exchangeImplementations(originMethod, swizzledMethod);
            }
        }
    });
}

- (void)JGAlertController_dealloc {
    
    JGLogFunc(@"<%@: %p>", NSStringFromClass([self class]), self);
    
    [self JGAlertController_dealloc];
}

#pragma mark - idx
- (NSInteger)cancelIdx {
    return 0;
}

- (NSInteger)destructiveIdx {
    return 1;
}

- (NSInteger)firstOtherIdx {
    return 2;
}

#pragma mark - End

@end

@implementation UIViewController (JGAlertController)

#pragma mark - Alert
- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message {
    return [self alertWithTitle:title message:message cancel:nil];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel {
    return [self alertWithTitle:title message:message cancel:cancel btnAction:nil];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel btnAction:(JGAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel other:nil btnAction:btnAction];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other btnAction:(JGAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel others:[NSArray arrayWithObjects:other, nil] btnAction:btnAction];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel others:(NSArray<NSString *> *)others btnAction:(JGAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel destructive:nil others:others btnAction:btnAction];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive btnAction:(JGAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel destructive:destructive others:nil btnAction:btnAction];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(JGAlertControllerAction)btnAction {
    return [self showAlertWithTitle:title message:message style:UIAlertControllerStyleAlert cancel:cancel destructive:destructive others:others btnAction:btnAction];
}

#pragma mark - ActionSheet
- (UIAlertController *)actionSheetWithTitle:(NSString *)title cancel:(NSString *)cancel others:(NSArray<NSString *> *)others btnAction:(JGAlertControllerAction)btnAction {
    return [self actionSheetWithTitle:title cancel:cancel destructive:nil others:others btnAction:btnAction];
}

- (UIAlertController *)actionSheetWithTitle:(NSString *)title cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(JGAlertControllerAction)btnAction {
    return [self showAlertWithTitle:title message:nil style:UIAlertControllerStyleActionSheet cancel:cancel destructive:destructive others:others btnAction:btnAction];
}

#pragma mark - Alert & ActionSheet
- (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(JGAlertControllerAction)btnAction {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    JGWeak(alert);
    
    if (cancel) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            JGStrong(alert);
            if (btnAction) {
                btnAction(alert, alert.cancelIdx);
            }
        }];
        [alert addAction:cancelAction];
    }
    
    if (destructive) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            JGStrong(alert);
            if (btnAction) {
                btnAction(alert, alert.destructiveIdx);
            }
        }];
        [alert addAction:destructiveAction];
    }
    
    for (NSUInteger i = 0; i < [others count]; i++) {
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:others[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JGStrong(alert);
            if (btnAction) {
                btnAction(alert, alert.firstOtherIdx + i);
            }
        }];
        [alert addAction:otherAction];
    }
    
    if (alert.popoverPresentationController) {
        [alert.popoverPresentationController setSourceView:self.view];
        [alert.popoverPresentationController setSourceRect:self.view.bounds];
        [alert.popoverPresentationController setPermittedArrowDirections:(UIPopoverArrowDirection)0];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
    return alert;
}

#pragma mark - Hide
- (BOOL)hideCurrentAlert:(BOOL)animated {
    
    if (self.presentedViewController && [self.presentedViewController isKindOfClass:[UIAlertController class]]) {
        [self.presentedViewController dismissViewControllerAnimated:animated completion:^{
            
        }];
        return YES;
    }
    return NO;
}

#pragma mark - End

@end
