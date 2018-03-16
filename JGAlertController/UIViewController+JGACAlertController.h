//
//  UIViewController+JGACAlertController.h
//  JGAlertController
//
//  Created by Mei Jigao on 2017/11/24.
//  Copyright © 2017年 MeiJigao. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<JGAlertController/UIAlertController+JGACAlertController.h>)
#import <JGAlertController/UIAlertController+JGACAlertController.h>
#else
#import "UIAlertController+JGACAlertController.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JGAlertController)

#pragma mark - Alert
/**
 Alert 单个按钮，无点击响应
 
 @param title 标题，默认“提示”
 @param message 提示内容
 @return UIAlertController
 */
- (UIAlertController *)jg_alertWithTitle:(nullable NSString *)title message:(NSString *)message;

/**
 Alert 单个按钮，无点击响应
 
 @param title 标题，默认“提示”
 @param message 提示内容
 @param cancel 取消按钮标题
 @return UIAlertController
 */
- (UIAlertController *)jg_alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel;

/**
 Alert 单个按钮，有点击响应
 
 @param title 标题，默认“提示”
 @param message 提示内容
 @param cancel 取消按钮标题
 @param btnAction 点击响应block
 @return UIAlertController
 */
- (UIAlertController *)jg_alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel btnAction:(nullable JGACAlertControllerAction)btnAction;

/**
 * Alert 双按钮
 
 @param title 标题，默认“提示”
 @param message 提示内容
 @param cancel 取消按钮标题
 @param other 确定按钮标题
 @param btnAction 点击响应block
 @return UIAlertController
 */
- (UIAlertController *)jg_alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel other:(nullable NSString *)other btnAction:(nullable JGACAlertControllerAction)btnAction;

/**
 * Alert 双按钮，红色警告destructive按钮
 
 @param title 标题，默认“提示”
 @param message 提示内容
 @param cancel 取消按钮标题
 @param destructive 警告按钮标题
 @param btnAction 点击响应block
 @return UIAlertController
 */
- (UIAlertController *)jg_alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel destructive:(nullable NSString *)destructive btnAction:(nullable JGACAlertControllerAction)btnAction;

/**
 Alert 多按钮
 
 @param title 标题，默认“提示”
 @param message 提示内容
 @param cancel 取消按钮标题
 @param others 目前仅支持不多于20个，多余不显示
 @param btnAction 点击响应block
 @return UIAlertController
 */
- (UIAlertController *)jg_alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel others:(nullable NSArray<NSString *> *)others btnAction:(nullable JGACAlertControllerAction)btnAction;

/**
 Alert 多按钮，红色警告destructive按钮
 
 @param title 标题，默认“提示”
 @param message 提示内容
 @param cancel 取消按钮标题
 @param destructive 警告按钮标题
 @param others 目前仅支持不多于20个，多余不显示
 @param btnAction 点击响应block
 @return UIAlertController
 */
- (UIAlertController *)jg_alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel destructive:(nullable NSString *)destructive others:(nullable NSArray<NSString *> *)others btnAction:(nullable JGACAlertControllerAction)btnAction;

#pragma mark - ActionSheet
/**
 Actionsheet
 
 @param title 标题，默认“提示”
 @param cancel 提示内容
 @param others 目前仅支持不多于20个，多余不显示
 @param btnAction 点击响应block
 @return UIActionSheet / UIAlertController
 */
- (UIAlertController *)jg_actionSheetWithTitle:(nullable NSString *)title cancel:(nullable NSString *)cancel others:(NSArray<NSString *> *)others btnAction:(nullable JGACAlertControllerAction)btnAction;

/**
 Actionsheet，红色警告destructive按钮
 
 @param title 标题，默认“提示”
 @param cancel 提示内容
 @param destructive 警告按钮标题
 @param others 目前仅支持不多于20个，多余不显示
 @param btnAction 点击响应block
 @return UIActionSheet / UIAlertController
 */
- (UIAlertController *)jg_actionSheetWithTitle:(nullable NSString *)title cancel:(nullable NSString *)cancel destructive:(nullable NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(nullable JGACAlertControllerAction)btnAction;

#pragma mark - Hide
/**
 隐藏弹出的实现
 
 @return 是否需要隐藏
 */
- (BOOL)jg_hideCurrentAlert:(BOOL)animated;

//#pragma mark - Deprecated
- (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(NSString *)message DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_alertWithTitle:message:");

- (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_alertWithTitle:message:cancel:");

- (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel btnAction:(nullable JGACAlertControllerAction)btnAction DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_alertWithTitle:message:cancel:btnAction:");

- (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel other:(nullable NSString *)other btnAction:(nullable JGACAlertControllerAction)btnAction DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_alertWithTitle:message:cancel:other:btnAction:");

- (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel destructive:(nullable NSString *)destructive btnAction:(nullable JGACAlertControllerAction)btnAction DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_alertWithTitle:message:cancel:destructive:btnAction:");

- (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel others:(nullable NSArray<NSString *> *)others btnAction:(nullable JGACAlertControllerAction)btnAction DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_alertWithTitle:message:cancel:others:btnAction:");

- (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(NSString *)message cancel:(nullable NSString *)cancel destructive:(nullable NSString *)destructive others:(nullable NSArray<NSString *> *)others btnAction:(nullable JGACAlertControllerAction)btnAction DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_alertWithTitle:message:cancel:destructive:others:btnAction:");

- (UIAlertController *)actionSheetWithTitle:(nullable NSString *)title cancel:(nullable NSString *)cancel others:(NSArray<NSString *> *)others btnAction:(nullable JGACAlertControllerAction)btnAction DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_actionSheetWithTitle:cancel:others:btnAction:");

- (UIAlertController *)actionSheetWithTitle:(nullable NSString *)title cancel:(nullable NSString *)cancel destructive:(nullable NSString *)destructive others:(NSArray<NSString *> *)others btnAction:(nullable JGACAlertControllerAction)btnAction DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_actionSheetWithTitle:cancel:destructive:others:btnAction:");

- (BOOL)hideCurrentAlert:(BOOL)animated DEPRECATED_MSG_ATTRIBUTE("Replaced by -jg_hideCurrentAlert:");

@end

NS_ASSUME_NONNULL_END
