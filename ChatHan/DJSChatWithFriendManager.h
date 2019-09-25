//
//  DJSChatWithFriendManager.h
//  ChatHan
//
//  Created by 萨缪 on 2019/7/31.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SRWebSocket.h>

typedef void(^DJSChatWithFriendHandle)(NSDictionary * receiveDictionary);

typedef void(^DJSReceiveMessageHandle)(id message);

typedef void(^ErrorHandle)(NSError * error);

typedef void(^returnTextBlock)(id showText);

//@protocol SRWebSocketDelegate;
@class DJSReceiveChatView;
@protocol getMessageDelegate <NSObject>
- (void)getMessageFromSocket:(NSDictionary *)message;
@end

@interface DJSChatWithFriendManager : NSObject <SRWebSocketDelegate>

//@property (nonatomic, weak) id <SRWebSocketDelegate> delegate;
@property (assign, nonatomic) id<getMessageDelegate>delegate;

@property (nonatomic, strong) SRWebSocket * webSocket;

//心跳机制
@property (nonatomic, strong) NSTimer * heartBeatTimer;

//重新连接时间
@property (nonatomic, assign) NSTimeInterval reConnectTime;

//用于判断是否主动关闭长连接，如果是主动断开连接，连接失败的代理中，就不用执行 重新连接方法
@property (nonatomic, assign) BOOL isActivityClose;

@property (nonatomic, copy) NSString * urlString;

//获取链接状态
@property (nonatomic,assign,readonly) SRReadyState socketReadyState;

@property (nonatomic, copy) returnTextBlock returnTextBlock;

+ (instancetype)sharedManager;

//外部调用传入链接URL
- (void)WithIP:(NSString *)URLIP;
//外部控制打开webSocket(拿到接口传给的URL之后)
- (void)openSocket;
//外部调用控制关闭webSocket
- (void)closeSocket;
//ping pong 心跳链接
- (void)SendPangMessage;
//外部聊天发送消息
- (void)sendTalkMessage:(NSString *)message;

- (void)fetchConcetionWithFirend:(NSString *)idStr
                         succeed:(DJSChatWithFriendHandle)succeedBlock
                           error:(ErrorHandle)errorBlock;


-(void)SRWebSocketOpenWithURLString:(NSString *)urlString;

- (void)sendData:(id)data;

-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;

- (void)returnText:(returnTextBlock)block;

@end
