//
//  DJSChatWithFriendManager.m
//  ChatHan
//
//  Created by 萨缪 on 2019/7/31.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatWithFriendManager.h"
#import "DJSReceiveChatView.h"

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif


@implementation DJSChatWithFriendManager

static DJSChatWithFriendManager * manager = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DJSChatWithFriendManager alloc] init];
    });
    return manager;
}

- (void)WithIP:(NSString *)URLIP {
    NSLog(@"URLIP = %@",URLIP);
    NSString * str1 = [URLIP stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:str1];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"request.URL = %@",request.URL);
    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    _webSocket.delegate = self;
    [_webSocket open];
}

- (void)openSocket {
//    [_webSocket open];
}

- (void)closeSocket {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}

//外部聊天发送消息
//message 是 textFiled.text
- (void)sendTalkMessage:(NSString *)message{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic = [@{ @"content":message} mutableCopy];
    //这个方法只是为了包装一下收到的 textFiled.text消息
    [self sendMessage:dic];
}

//ping pong 心跳链接
- (void)SendPangMessage{
    
}

- (void)initHeartBeat {
    
    if (self.heartBeatTimer) {
        return;
    }
    [self destoryHeartBeat];
    dispatch_main_async_safe(^{
        self.heartBeatTimer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(sentheart) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.heartBeatTimer forMode:NSRunLoopCommonModes];
    });
}

#pragma mark  显示完毕 该接收和发送消息并显示到屏幕上了！！！
- (void)sendData:(id)data {
    NSLog(@"socketSendData --------------- %@",data);
    __weak typeof(self)weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("zy", NULL);
    NSLog(@"weakSelf.webSocket = %@",weakSelf.webSocket);
    dispatch_async(queue, ^{
        if (weakSelf.webSocket != nil) {
            //只有SR_OPEN状态才能发送信息啊
            if (weakSelf.webSocket.readyState == SR_OPEN) {
                //发送数据
                NSDictionary * dataDic = [NSDictionary dictionaryWithObjects:@[@"30",@"31",data] forKeys:@[@"senderId",@"to",@"text"]];
                //
                NSData * dataDa = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
                NSString * strs = [[NSString alloc] initWithData:dataDa encoding:NSUTF8StringEncoding];
                [weakSelf.webSocket send:strs];
            } else if (weakSelf.webSocket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                // 代码有点长，我就写个逻辑在这里好了
                [self reConnect];
            } else if (weakSelf.webSocket.readyState == SR_CLOSING || weakSelf.webSocket.readyState == SR_CLOSED) {
            
                // websocket 断开了，调用 reConnect 方法重连
                
                NSLog(@"重连");
                
                [self reConnect];
             }
                
        } else {
            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
            NSLog(@"其实最好是发送前判断一下网络状态比较好，我写的有点晦涩，socket==nil来表示断网");
        }
    });
}

#pragma mark - **************** private mothodes
- (void)SRWebSocketClose {
    if (self.webSocket){
        [self.webSocket close];
        self.webSocket = nil;
        //断开连接时销毁心跳
        [self destoryHeartBeat];
    }
}

//重连机制
-(void)SRWebSocketOpenWithURLString:(NSString *)urlString {
    if (self.webSocket) {
        return;
    }
    if (!urlString) {
        return;
    }
    
    NSString * str1 = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    self.urlString = str1;
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str1]]];
    
    NSLog(@"请求的websocket地址：%@",self.webSocket.url.absoluteString);

    self.webSocket.delegate = self;
    
    [_webSocket open];

}

- (void)reConnect {
    [self SRWebSocketClose];
    
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (self.reConnectTime > 64) {
        //网络状态不好 重试
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(self.reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.webSocket = nil;
        [self SRWebSocketOpenWithURLString:self.urlString];
        NSLog(@"重连");
    });
    
    //重新连接时间指数级增长
    if (self.reConnectTime == 0) {
        self.reConnectTime = 2;
    } else {
        self.reConnectTime *= 2;
    }
}

- (void)sentheart {
    //发送心跳 和后台可以约定发送什么内容  一般可以调用ping  我这里根据后台的要求 发送了data给他
    //这个方法在textView代理方法中使用
    [self sendData:@"heart"];
}


//pingPong
- (void)ping {
    if (self.webSocket.readyState == SR_OPEN) {
        [self.webSocket sendPing:nil];
    }
}

- (void)destoryHeartBeat {
    __weak typeof(self)weakSelf = self;
    dispatch_main_async_safe(^{
        if (weakSelf.heartBeatTimer) {
            [weakSelf.heartBeatTimer invalidate];
            weakSelf.heartBeatTimer = nil;
        }
    });
}

#pragma mark   /*******  socket必须实现的代理方法 *********/
//打开socket后根据后端要求传入字典字符串
-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    //每次正常连接的时候清零重新连接时间
    self.reConnectTime = 0;
    //开启心跳
    [self initHeartBeat];
    if (webSocket == self.webSocket) {
        NSLog(@"************************** socket 连接成功************************** ");
    }
    NSLog(@"链接成功");
}

//socket接收到信息后通过代理传给外部使用
//这个就是接受消息的代理方法了，这里接受服务器返回的数据，方法里面就应该写处理数据，存储数据的方法了。
-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    if (webSocket == self.webSocket) {
        NSLog(@"************************** socket收到数据了************************** ");
        NSLog(@"我这后台约定的 message 是 json 格式数据收到数据，就按格式解析吧，然后把数据发给调用层");
        NSLog(@"message:%@",message);
        
        //发送通知
#pragma mark 接收消息后 要把这个消息装入一个自定义cell相关的字典中 然后传给这个cell然后显示在界面上
        if (self.returnTextBlock != nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMessage" object:nil];
            self.returnTextBlock(message);
        }
    }
    NSLog(@"收到消息了:%@",message);
}

//再建立一个通知 在通知里调用块
- (void)returnText:(returnTextBlock)block {
    self.returnTextBlock = block;
}


-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    if (webSocket == self.webSocket) {
        NSLog(@"************************** socket连接断开************************** ");
        NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",(long)code,reason,wasClean);
        [self SRWebSocketClose];
    }
    NSLog(@"WebSocket closed");
    NSLog(@"WebSocket closed");
    
}

/*
 该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply===%@",reply);
}


-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    if (webSocket == self.webSocket) {
        NSLog(@":( Websocket Failed With Error %@", error);
        _webSocket = nil;
    }
    [self reConnect];
}

//send数据转化成json字符串
- (void)sendMessage:(NSDictionary *)messageDic {
    //这个目的是为了转化成JSON字符串
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [_webSocket send:jsonString];
}

- (SRReadyState)socketReadyState {
    return self.webSocket.readyState;
}

//- (void)fetchConcetionWithFirend:(NSString *)idStr succeed:(DJSChatWithFriendHandle)succeedBlock error:(ErrorHandle)errorBlock {
//    self.webSocket.delegate = nil;
//    [self.webSocket close];
//    self.webSocket = nil;
//    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"ws://www.zhangshuo.fun/chat/{%@}", idStr]]]];
////    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"ws://www.zhangshuo.fun/chat/{%@}", idStr]]] protocols:@[] allowsUntrustedSSLCertificates:YES];
////    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"ws://www.zhangshuo.fun/chat/{%@}", idStr]]];
//
//    self.webSocket.delegate = self;
//    [self.webSocket open];
//}
//
//- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
//    NSLog(@"链接成功");
//    [self.webSocket send:@"你好啊 康思婉"];
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
//    NSLog(@"收到消息了:%@",message);
//}
//
//- (void)webSocket:(SRWebSocket*)webSocket didFailWithError:(NSError*)error{
//
//    NSLog(@"连接失败.....");
//    self.webSocket = nil;
//}
//
//- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
//    NSLog(@"WebSocket closed");
//}


@end
