//
//  DJSChatWithPeopleView.h
//  ChatHan
//
//  Created by 萨缪 on 2019/8/7.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSChatFriendListTableViewCell.h"
#import "DJSChatWithPeopleModel.h"
@interface DJSChatWithPeopleView : UIView
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) DJSChatWithPeopleModel * messageModel;

- (void)initTableView;

@end
