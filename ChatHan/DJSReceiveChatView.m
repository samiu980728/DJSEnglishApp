//
//  DJSReceiveChatView.m
//  ChatHan
//
//  Created by 萨缪 on 2019/8/8.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSReceiveChatView.h"

@implementation DJSReceiveChatView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithTableView];
        [self bottomView];
        [self dataArray];
    }
    return self;
}

- (void)initWithTableView {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:@"receiveMessage" object:nil];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-44) style:UITableViewStylePlain];
    [self.tableView registerClass:[DJSChatInterfaceTableViewCell class] forCellReuseIdentifier:@"WeChatCell"];
    [self.tableView registerClass:[DJSRewriteChatInterfaceTableViewCell class] forCellReuseIdentifier:@"rewriteClass"];
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
#pragma mark  这里根据数据的多少 可以用for循环 来展示
    DJSChatInterfaceModel * model = [[DJSChatInterfaceModel alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)receiveMessage:(NSNotificationCenter *)noti {
    DJSChatWithFriendManager * manager = [DJSChatWithFriendManager sharedManager];
    [manager returnText:^(id showText) {
        NSString * textStr = [NSString stringWithFormat:@"%@",showText];
#pragma mark 在这里再创建model 然后插入进cell中
    }];
}

- (void)bottomView {
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 44)];
    backGroundView.tag = 100;
    backGroundView.backgroundColor = [[UIColor alloc] initWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    backGroundView.layer.masksToBounds = YES;
    backGroundView.layer.borderColor = [[UIColor alloc] initWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1].CGColor;
    [self addSubview:backGroundView];
    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(49, 0, backGroundView.bounds.size.width-152, 44)];
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeySend;
    textView.tag = 101;
    textView.font = [UIFont systemFontOfSize:16];
    textView.text = @"hey jude";
    [backGroundView addSubview:textView];
    
    UIButton *imageBtn = [[UIButton alloc] init];
    imageBtn.frame = CGRectMake(backGroundView.frame.size.width - 39, 5, 34, 34);
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
#pragma mark   先不用弄点击事件 等数据传上来了再弄  下一步 传数据 看看有没有bug 空数据状态
    [imageBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    imageBtn.tag = 13;
    [backGroundView addSubview:imageBtn];
}

#pragma mark 每当dataArray 更新时 要reloadData
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DJSRewriteChatInterfaceTableViewCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"rewriteClass" forIndexPath:indexPath];
    if (_dataArray.count > 0) {
        cell.buttonAction = ^(UIButton *sender, NSString *idStr) {
            [self cellButtonClick:sender andGiveID:idStr];
        };
    DJSChatInterfaceModel * model = _dataArray[indexPath.row];
#pragma mark 在这里给model.imageImageSmall设置点击手势事件 然后进行block传值 还需用到该cell的自定义cell类来设置按钮点击事件，然后在这里主要是实现这个事件中需要做什么 :push的时候顺便把该用户id 传递到下一个界面中 以便能够获取到该用户的一些个人信息
    [cell setMessage:model];
    }
    return cell;
}

- (void) cellButtonClick:(UIButton *)button andGiveID:(NSString *)idStr
{
    NSLog(@"QSTSD");
    UIViewController * selfViewController = [self viewController:self];
    DJSChatOneMessageViewController * messageViewController = [[DJSChatOneMessageViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:messageViewController];
    nav.title = @"个人信息";
    messageViewController.idString = idStr;
    [selfViewController.navigationController pushViewController:messageViewController animated:YES];
}

//获取当前View的控制器
- (UIViewController *)viewController:(UIView *)view {
    for (UIView * next = [self superview]; next; next = next.superview) {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark  重新定位到问题！！！ cell没有申请到！！！
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJSChatInterfaceModel * model = self.dataArray[indexPath.row];
    NSLog(@"heith代理中model = %@",model);
    CGFloat height = [model cellHeight];
    NSLog(@"height = %f",height);
    return 200;
//    return [model cellHeight];
}

#pragma mark  这里 在哪个地方使用就在哪个地方进行方法调用

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //发送完消息肯定要按回车键 \n
    if ([text isEqualToString:@"\n"]) {
        if (textView.text.length == 0) {
            return NO;
        }
        //发送信息
        _webSocket = [DJSChatWithFriendManager sharedManager];
        [_webSocket SRWebSocketOpenWithURLString:@"ws://www.zhangshuo.fun:8080/chat/30"];
        [_webSocket sendData:textView.text];
        
        DJSChatInterfaceModel * model = [[DJSChatInterfaceModel alloc] init];
        model.messageType = messageTypeText;
        model.messageSenderType = messageSenderMe;
        model.messageTextStr = textView.text;
        model.messageTime = @"16:40";
#pragma mark 这是因为坐标没有设置 直接加上去了！！！ 要看看insert的样例
        [_dataArray addObject:model];
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:_dataArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        if ([self.tableView respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0]];
        }
        textView.text = @"";
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

-(void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘高度
    NSDictionary * userInfo = [aNotification userInfo];
    NSValue * aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect = [aValue CGRectValue];
    int height = keyBoardRect.size.height;
    _tableBottomConstraint.constant = 44 + height;
    //100是bottomView那个方法中 最大的那个backgroundView
    UIView * vi = [self viewWithTag:100];
    CGRect rec = vi.frame;
    rec.origin.y = self.tableView.frame.size.height - height;
    vi.frame = rec;
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    _tableBottomConstraint.constant = 44;
    UIView * vi = [self viewWithTag:100];
    vi.frame = CGRectMake(0, self.tableView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 44);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
