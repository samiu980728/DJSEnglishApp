//
//  DJSChatPeopleViewController.h
//  ChatHan
//
//  Created by 萨缪 on 2019/4/18.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSChatWithPeopleView.h"
#import "DJSChatFriendListTableViewCell.h"

@interface DJSChatPeopleViewController : UIViewController

//用户token
@property (nonatomic, copy) NSString * tokenS;

//数据源
@property (nonatomic, strong) NSMutableArray * dataSouceArray;

//请求参数
@property (nonatomic, strong) NSMutableDictionary * parameterDict;

//view
@property (nonatomic, strong) DJSChatWithPeopleView * chatListView;

@end
