//
//  DJSRewriteChatInterfaceTableViewCell.h
//  ChatHan
//
//  Created by 萨缪 on 2019/8/13.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSChatInterfaceModel.h"
@interface DJSRewriteChatInterfaceTableViewCell : UITableViewCell

typedef void(^ButtonClick)(UIButton *sender, NSString * idStr);

@property (nonatomic, copy) ButtonClick buttonAction;

@property (nonatomic, strong) UIButton * imageButton;

- (void)setMessage:(DJSChatInterfaceModel *)messageModel;

@property (nonatomic, strong) UIImageView * imageImageView;

@property (nonatomic, strong) UIImageView * bubbleImageView;

@property (nonatomic, strong) UIImageView * logoImageView;

@property (nonatomic, strong) UILabel * messageLabel;

@property (nonatomic, strong) UILabel * timeLabel;

@end
