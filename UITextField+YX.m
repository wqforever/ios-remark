//
//  UITextField+YX.m
//  FocusEntrance
//
//  Created by zhaoxin_dev on 2017/3/29.
//  Copyright © 2017年 ifenduo. All rights reserved.
//

#import "UITextField+YX.h"
#import <objc/runtime.h>



NSString * const YXTextFieldDidDeleteBackwardNotification = @"textfield_did_notification";

@implementation UITextField(YX)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(yx_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)yx_deleteBackward {
    [self yx_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <YXTextFieldDelegate> delegate  = (id<YXTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YXTextFieldDidDeleteBackwardNotification object:self];
}
@end
