//
//  DJSChatInterfaceModel.h
//  ChatHan
//
//  Created by 萨缪 on 2019/8/9.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImage+Han.h"
#import "ConstantPart.h"

typedef NS_OPTIONS(NSUInteger, messageType) {
    //接收消息类型
    messageTypeText = 1,
    messageTypeImage = 2
};

//发送消息的对象
typedef NS_OPTIONS(NSUInteger, messageSenderType) {
    messageSenderMe = 1,
    messageSenderOther
};

//消息的发送状态
typedef NS_OPTIONS(NSUInteger, messageSendStatus) {
    messageSendStatusSended = 1,
    messageSendStatusUnSended,
    messageSendStatusSending,
};

@interface DJSChatInterfaceModel : NSObject

@property (nonatomic, assign) messageType messageType;

@property (nonatomic, assign) messageSenderType messageSenderType;

@property (nonatomic, assign) messageSendStatus messageSenderStatus;

@property (nonatomic, copy) NSString * messageTextStr;

@property (nonatomic, copy) NSString * messageImageUrl;

@property (nonatomic, strong) UIImage * messageImageSmall;

@property (nonatomic, copy) NSString * messageTime;

@property (nonatomic, copy) NSString * logoUrlStr;


#pragma mark 这是方法！ 不是懒加载  必须得手动调用
- (CGRect)timeFrame;
- (CGRect)logoFrame;
- (CGRect)messageFrame;
- (CGRect)voiceFrame;
- (CGRect)voiceAnimationFrame;
- (CGRect)bubbleFrame;
- (CGRect)imageFrame;
- (CGFloat)cellHeight;


@end
