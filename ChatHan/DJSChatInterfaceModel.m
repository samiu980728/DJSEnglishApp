//
//  DJSChatInterfaceModel.m
//  ChatHan
//
//  Created by 萨缪 on 2019/8/9.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatInterfaceModel.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHight [UIScreen mainScreen].bounds.size.height

@implementation DJSChatInterfaceModel

- (NSString *)messageTextStr {
    if (_messageTextStr == nil) {
        _messageTextStr = [[NSString alloc] init];
    }
    return _messageTextStr;
}

- (UIImage *)messageImageSmall {
    if (_messageImageSmall == nil) {
        _messageImageSmall = [[UIImage alloc] init];
    }
    return _messageImageSmall;
}

- (NSString *)messageTime {
    if (_messageTime == nil) {
        _messageTime = [[NSString alloc] init];
    }
    return _messageTime;
}

- (CGRect)timeFrame {
    CGRect rect = CGRectZero;
    rect.size = [self labelAutoCaculateRectWith:self.messageTime Font:[UIFont systemFontOfSize:11] MaxSize:CGSizeMake(MAXFLOAT, 15)];
    rect = CGRectMake((ScreenWidth-rect.size.width)/2, 0, rect.size.width, rect.size.height);
    return rect;
}

- (CGRect)messageFrame {
    CGRect timeRect = [self timeFrame];
    CGRect rect = CGRectZero;
    CGFloat maxWidth = ScreenWidth * 0.7 - 60;
    rect.size = [self labelAutoCaculateRectWith:self.messageTextStr Font:[UIFont systemFontOfSize:16] MaxSize:CGSizeMake(maxWidth, MAXFLOAT)];
    
    if (self.messageTextStr == nil) {
        return rect;
    }
    if (self.messageSenderType == messageSenderMe) {
        rect = CGRectMake(ScreenWidth * 0.3, timeRect.size.height+10, maxWidth-5, rect.size.height);
    } else if (self.messageSenderType == 2) {
        rect = CGRectMake(65, timeRect.size.height+10, maxWidth, rect.size.height);
    }
    return rect;
}

- (CGRect)logoFrame {
    CGRect timeRect = [self timeFrame];
    CGRect rect = CGRectZero;
    if (self.messageSenderType == messageSenderMe) {
        rect = CGRectMake(ScreenWidth-50, timeRect.size.height+10, 40, 40);
    } else {
        rect = CGRectMake(10, timeRect.size.height+10, 40, 40);
    }
    return rect;
}

- (CGRect)imageFrame {
    CGRect timeRect = [self timeFrame];
    CGRect rect = CGRectZero;
    CGSize imageSize = [self.messageImageSmall imageShowSize];
    if (self.messageImageSmall == nil) {
        return rect;
    }
    if (self.messageSenderType == messageSenderMe) {
        rect = CGRectMake(ScreenWidth-imageSize.width-50, timeRect.size.height+10, imageSize.width, imageSize.height);
    } else {
        rect = CGRectMake(50, timeRect.size.height+10, imageSize.width, imageSize.height);
    }
    return rect;
}

- (CGRect)bubbleFrame {
    CGRect rect = CGRectZero;
    switch (self.messageType) {
        case messageTypeText:
            rect = [self messageFrame];
#pragma mark  这里没有加
            break;
        case messageTypeImage:
            rect = [self imageFrame];
            break;
        default:
            break;
    }
    return rect;
}

- (CGFloat)cellHeight {
    return [self timeFrame].size.height + [self messageFrame].size.height + [self imageFrame].size.height + 15;
}

- (CGSize)labelAutoCaculateRectWith:(NSString *)textStr Font:(UIFont *)textFont MaxSize:(CGSize)maxSize {
    NSDictionary * attritues = @{NSFontAttributeName:textFont};
    CGRect rect = [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attritues context:nil];
    return rect.size;
}

@end
