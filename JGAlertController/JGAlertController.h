//
//  JGAlertController.h
//  JGAlertController
//
//  Created by Mei Jigao on 2017/11/24.
//  Copyright © 2017年 MeiJigao. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for JGAlertController.
FOUNDATION_EXPORT double JGAlertControllerVersionNumber;

//! Project version string for JGAlertController.
FOUNDATION_EXPORT const unsigned char JGAlertControllerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <JGAlertController/PublicHeader.h>

// JG 缩写说明
// JG: 作者名
// AC: Alert Controller

#if __has_include(<JGAlertController/JGAlertController.h>)

#import <JGAlertController/JGACAlertController.h>
#import <JGAlertController/UIViewController+JGACAlertController.h>

#else

#import "JGAlertControllerImpl.h"
#import "UIViewController+JGACAlertController.h"

#endif
