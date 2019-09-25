//
//  DJSReceiveChatView.h
//  ChatHan
//
//  Created by 萨缪 on 2019/8/8.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBigView.h"
#import "DJSChatInterfaceTableViewCell.h"
#import "DJSChatInterfaceModel.h"
#import "DJSRewriteChatInterfaceTableViewCell.h"
#import "DJSChatWithFriendManager.h"
//个人信息界面
#import "DJSChatOneMessageViewController.h"

typedef void(^DJSReceiveMessageHandle)(id message);

typedef void(^ErrorHandle)(NSError * error);

@interface DJSReceiveChatView : UIView <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, DJSChatInterfaceDelegate, SRWebSocketDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSLayoutConstraint * tableBottomConstraint;

@property (nonatomic, strong) DJSChatWithFriendManager * webSocket;
//@property (nonatomic, strong) UITableView * tableView;
- (void)initWithTableView;

- (void)fetchReceiveMessage:(id)message
                    succeed:(DJSReceiveMessageHandle)succeedBlock
                      error:(ErrorHandle)errorBlock;

- (void)bottomView;

@end
