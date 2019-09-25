//
//  DJSChatInterfaceTableViewCell.h
//  ChatHan
//
//  Created by 萨缪 on 2019/8/9.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSChatInterfaceModel.h"

@class DJSChatInterfaceTableViewCell;
@protocol DJSChatInterfaceDelegate <NSObject>

@optional
- (void)messageCellSingleClickedWith:(DJSChatInterfaceTableViewCell *)cell;

@end

@interface DJSChatInterfaceTableViewCell : UITableViewCell

typedef void(^ButtonClick)(UIButton *sender, NSString * idStr);

@property (nonatomic, copy) ButtonClick buttonAction;

@property (nonatomic, strong) DJSChatInterfaceModel * interfaceModel;

@property (nonatomic, strong) UIButton * imageButton;

@property (nonatomic, strong) UIImageView * imageImageView;

@property (nonatomic, strong) UIImageView * bubbleImageView;

@property (nonatomic, strong) UIImageView * logoImageView;

@property (nonatomic, strong) UILabel * messageLabel;

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UIFont * textFont;

@property (nonatomic, weak) id<DJSChatInterfaceDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView messageModel:(DJSChatInterfaceModel *)model;

- (void)giveTheValueToInterfaceModel;

@end
