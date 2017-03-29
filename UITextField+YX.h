//
//  UITextField+YX.h
//  FocusEntrance
//
//  Created by zhaoxin_dev on 2017/3/29.
//  Copyright © 2017年 ifenduo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

@interface UITextField (YX)
@property (weak, nonatomic) id<YXTextFieldDelegate> delegate;
@end
/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const YXTextFieldDidDeleteBackwardNotification;
