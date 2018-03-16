//
//  UIViewController+JGACAlertController.m
//  JGAlertController
//
//  Created by Mei Jigao on 2017/11/24.
//  Copyright © 2017年 MeiJigao. All rights reserved.
//

#import "UIViewController+JGACAlertController.h"
#import "JGSourceBase.h"

@implementation UIViewController (JGAlertController)

#pragma mark - Alert
- (UIAlertController *)jg_alertWithTitle:(NSString *)title message:(NSString *)message {
    return [self jg_alertWithTitle:title message:message cancel:nil];
}

- (UIAlertController *)jg_alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel {
    return [self jg_alertWithTitle:title message:message cancel:cancel btnAction:nil];
}

- (UIAlertController *)jg_alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_alertWithTitle:title message:message cancel:cancel other:nil btnAction:btnAction];
}

- (UIAlertController *)jg_alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_alertWithTitle:title message:message cancel:cancel others:[NSArray arrayWithObjects:other, nil] btnAction:btnAction];
}

- (UIAlertController *)jg_alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_alertWithTitle:title message:message cancel:cancel destructive:nil others:others btnAction:btnAction];
}

- (UIAlertController *)jg_alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_alertWithTitle:title message:message cancel:cancel destructive:destructive others:nil btnAction:btnAction];
}

- (UIAlertController *)jg_alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_showAlertWithTitle:title message:message style:UIAlertControllerStyleAlert cancel:cancel destructive:destructive others:others btnAction:btnAction];
}

#pragma mark - ActionSheet
- (UIAlertController *)jg_actionSheetWithTitle:(NSString *)title cancel:(NSString *)cancel others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_actionSheetWithTitle:title cancel:cancel destructive:nil others:others btnAction:btnAction];
}

- (UIAlertController *)jg_actionSheetWithTitle:(NSString *)title cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_showAlertWithTitle:title message:nil style:UIAlertControllerStyleActionSheet cancel:cancel destructive:destructive others:others btnAction:btnAction];
}

#pragma mark - Alert & ActionSheet
- (UIAlertController *)jg_showAlertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    JGSCWeak(alert);
    
    if (cancel) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            JGSCStrong(alert);
            if (btnAction) {
                btnAction(alert, alert.jg_cancelIdx);
            }
        }];
        [alert addAction:cancelAction];
    }
    
    if (destructive) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            JGSCStrong(alert);
            if (btnAction) {
                btnAction(alert, alert.jg_destructiveIdx);
            }
        }];
        [alert addAction:destructiveAction];
    }
    
    for (NSUInteger i = 0; i < [others count]; i++) {
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:others[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JGSCStrong(alert);
            if (btnAction) {
                btnAction(alert, alert.jg_firstOtherIdx + i);
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
- (BOOL)jg_hideCurrentAlert:(BOOL)animated {
    
    if (self.presentedViewController && [self.presentedViewController isKindOfClass:[UIAlertController class]]) {
        [self.presentedViewController dismissViewControllerAnimated:animated completion:^{
            
        }];
        return YES;
    }
    return NO;
}

#pragma mark - Deprecated
- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message {
    return [self alertWithTitle:title message:message cancel:nil];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel {
    return [self alertWithTitle:title message:message cancel:cancel btnAction:nil];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel btnAction:(JGACAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel other:nil btnAction:btnAction];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other btnAction:(JGACAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel others:[NSArray arrayWithObjects:other, nil] btnAction:btnAction];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel destructive:nil others:others btnAction:btnAction];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive btnAction:(JGACAlertControllerAction)btnAction {
    return [self alertWithTitle:title message:message cancel:cancel destructive:destructive others:nil btnAction:btnAction];
}

- (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_showAlertWithTitle:title message:message style:UIAlertControllerStyleAlert cancel:cancel destructive:destructive others:others btnAction:btnAction];
}

- (UIAlertController *)actionSheetWithTitle:(NSString *)title cancel:(NSString *)cancel others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    return [self actionSheetWithTitle:title cancel:cancel destructive:nil others:others btnAction:btnAction];
}

- (UIAlertController *)actionSheetWithTitle:(NSString *)title cancel:(NSString *)cancel destructive:(NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(JGACAlertControllerAction)btnAction {
    return [self jg_showAlertWithTitle:title message:nil style:UIAlertControllerStyleActionSheet cancel:cancel destructive:destructive others:others btnAction:btnAction];
}

- (BOOL)hideCurrentAlert:(BOOL)animated {
    return [self jg_hideCurrentAlert:animated];
}

#pragma mark - End

@end
