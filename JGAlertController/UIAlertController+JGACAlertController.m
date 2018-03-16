//
//  UIAlertController+JGACAlertController.m
//  JGAlertController
//
//  Created by 梅继高 on 2018/6/12.
//  Copyright © 2018年 MeiJigao. All rights reserved.
//

#import "UIAlertController+JGACAlertController.h"
#import "JGSourceBase.h"

@implementation UIAlertController (JGACAlertController)

// Dealloc测试内存Log开关
static BOOL const JGACAlertControllerMemoryDebugLog = YES;

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        // 重写的系统方法处理
        NSMutableArray<NSString *> *oriSelectors = [NSMutableArray array];
        if (JGACAlertControllerMemoryDebugLog) {
            // 此处改写dealloc实现仅为了实现开发调试内存问题
            // dealloc仅用作日志输出检测页面释放情况
            // dealloc在ARC不能通过@selector获取
            [oriSelectors addObject:@"dealloc"];
        }
        
        for (NSString *oriSelName in oriSelectors) {
            
            SEL originSelector = NSSelectorFromString(oriSelName);
            SEL swizzledSelector = NSSelectorFromString([@"JGACAlertController_" stringByAppendingString:oriSelName]);
            
            JGSCRuntimeSwizzledMethod(class, originSelector, swizzledSelector);
        }
    });
}

- (void)JGACAlertController_dealloc {
    
    JGSCLogFunc(@"<%@: %p>", NSStringFromClass([self class]), self);
    
    [self JGACAlertController_dealloc];
}

#pragma mark - idx
- (NSInteger)jg_cancelIdx {
    return 0;
}

- (NSInteger)jg_destructiveIdx {
    return 1;
}

- (NSInteger)jg_firstOtherIdx {
    return 2;
}

#pragma mark - Deprecated
- (NSInteger)cancelIdx {
    return self.jg_cancelIdx;
}

- (NSInteger)destructiveIdx {
    return self.jg_destructiveIdx;
}

- (NSInteger)firstOtherIdx {
    return self.jg_firstOtherIdx;
}

#pragma mark - End

@end
