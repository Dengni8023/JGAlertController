//
//  UIAlertController+JGACAlertController.h
//  JGAlertController
//
//  Created by 梅继高 on 2018/6/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JGACAlertControllerAction)(UIAlertController * __nonnull alert, NSInteger idx);
typedef void(^JGAlertControllerAction)(UIAlertController * __nonnull alert, NSInteger idx) DEPRECATED_MSG_ATTRIBUTE("Use JGACAlertControllerAction instead");

@interface UIAlertController (JGACAlertController)

@property (nonatomic, assign, readonly) NSInteger jg_cancelIdx; // 0
@property (nonatomic, assign, readonly) NSInteger jg_destructiveIdx; // 1
@property (nonatomic, assign, readonly) NSInteger jg_firstOtherIdx; // 2

#pragma mark - Deprecated
@property (nonatomic, assign, readonly) NSInteger cancelIdx DEPRECATED_MSG_ATTRIBUTE("Use jg_cancelIdx instead");

@property (nonatomic, assign, readonly) NSInteger destructiveIdx DEPRECATED_MSG_ATTRIBUTE("Use jg_destructiveIdx instead");

@property (nonatomic, assign, readonly) NSInteger firstOtherIdx DEPRECATED_MSG_ATTRIBUTE("Use jg_firstOtherIdx instead");

@end
