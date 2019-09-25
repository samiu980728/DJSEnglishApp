//
//  DJSChatWithPeopleView.m
//  ChatHan
//
//  Created by 萨缪 on 2019/8/7.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatWithPeopleView.h"
#import "DJSChatViewController.h"
#import "DJSReceiveChatViewController.h"

@implementation DJSChatWithPeopleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    
    [self.tableView registerClass:[DJSChatFriendListTableViewCell class] forCellReuseIdentifier:self.messageModel.cellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
}

- (DJSChatWithPeopleModel *)messageModel {
    if (_messageModel == nil) {
        _messageModel = [[DJSChatWithPeopleModel alloc] init];
        _messageModel.cellIdentifier = @"cellID";
        _messageModel.dicModel = [NSDictionary dictionaryWithObjects:@[@"m.png",@"kang",@"hello"] forKeys:@[@"icon",@"name",@"text"]];
        _messageModel.rowHeight = 150;
    }
    return _messageModel;
}

#pragma mark 建立一个通知 如果messageModel改变 传入通知中 调用reloadData
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DJSChatFriendListTableViewCell * cell = nil;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:self.messageModel.dicModel[@"icon"]];
    NSLog(@"self.messageModel.dicModel = %@",self.messageModel.dicModel);
    cell.nameLabel.text = self.messageModel.dicModel[@"name"];
    cell.chatContentLabel.text = self.messageModel.dicModel[@"text"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DJSChatViewController * viewController = [[DJSChatViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pushChatViewButton:)];
    nav.navigationController.navigationItem.leftBarButtonItem = barButtonItem;
    nav.title = @"聊天";
    UIViewController * superViewController = [self findViewController:self];
    
    if (indexPath.row != 2) {
    superViewController.hidesBottomBarWhenPushed = YES;
    [superViewController.navigationController pushViewController:viewController animated:YES];
    superViewController.hidesBottomBarWhenPushed = NO;
    } else {
        superViewController.hidesBottomBarWhenPushed = YES;
        DJSReceiveChatViewController * receiveViewController = [[DJSReceiveChatViewController alloc] init];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:nil];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:receiveViewController];
        nav.navigationController.navigationItem.leftBarButtonItem = item;
        [superViewController.navigationController pushViewController:receiveViewController animated:YES];
        superViewController.hidesBottomBarWhenPushed = NO;
    }
}

- (UIViewController *)findViewController:(UIView *)view {
    id responder = view;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageModel.dicModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.messageModel.rowHeight;
}



- (void)getModelMessage {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
