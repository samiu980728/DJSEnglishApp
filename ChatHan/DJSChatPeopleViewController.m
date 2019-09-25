//
//  DJSChatPeopleViewController.m
//  ChatHan
//
//  Created by 萨缪 on 2019/4/18.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatPeopleViewController.h"
#import "DJSChatViewController.h"
#import "DJSChatWithFriendManager.h"
@interface DJSChatPeopleViewController () <getMessageDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DJSChatWithFriendManager * webSocket;

@end

@implementation DJSChatPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.chatListView = [[DJSChatWithPeopleView alloc] initWithFrame:self.view.bounds];
    [self.chatListView initTableView];
    [self.view addSubview:self.chatListView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * peopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    peopleButton.frame = CGRectMake(50, 100, 200, 30);
    peopleButton.tintColor = [UIColor blackColor];
    [peopleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [peopleButton setTitle:@"best lover" forState:UIControlStateNormal];
    [peopleButton addTarget:self action:@selector(pushChatViewButton:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:peopleButton];
    [self getData];
}


- (NSMutableArray *)dataSouceArray {
    if (_dataSouceArray == nil) {
        _dataSouceArray = [[NSMutableArray alloc] init];
    }
    return _dataSouceArray;
}

- (NSMutableDictionary *)parameterDict {
    if (_parameterDict == nil) {
        _parameterDict = [NSMutableDictionary dictionary];
    }
    return _parameterDict;
}

//记得退出页面关闭socket
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_webSocket closeSocket];
}

//发送按钮 调用websocket发送方法,推给服务器消息
- (void)sendACT{
//    [self. textField resignFirstResponder];
//    NSLog(@"text = %@",self.textField.text);
//    if (!([_textField.text  isEqual: @""])) {
//        [_webSocket sendTalkMessage:_textField.text];
//        [self.talkArr addObject:_textField.text];
//        [_mainTableView reloadData];
//        _textField.text = nil;
//    }
}
//获取到服务器数据后创建websocket
- (void)getData{
    //webscoket链接
    _webSocket = [DJSChatWithFriendManager sharedManager];
    [_webSocket SRWebSocketOpenWithURLString:@"ws://www.zhangshuo.fun:8080/chat/30"];
//    [_webSocket WithIP:@"ws://www.zhangshuo.fun:8080/chat/29"];
//    [_webSocket WithIP:@"wss://echo.websocket.org"];
    _webSocket.delegate = self;
    [_webSocket openSocket];
}


- (void)pushChatViewButton:(UIButton *)Button
{
    DJSChatViewController * viewController = [[DJSChatViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pushChatViewButton:)];
    nav.navigationController.navigationItem.leftBarButtonItem = barButtonItem;
    nav.title = @"聊天";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
