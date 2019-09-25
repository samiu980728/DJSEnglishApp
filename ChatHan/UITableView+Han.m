//
//  UITableView+Han.m
//  ChatHan
//
//  Created by 萨缪 on 2019/4/8.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "UITableView+Han.h"

@implementation UITableView (Han)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextView class]]) {
        [self.superview endEditing:YES];
        [self endEditing:YES];
    }
    return view;
}

@end
