//
//  CSMessageCell.h
//  XMPPChat
//
//  Created by 123 on 2017/12/14.
//  Copyright © 2017年 123. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CSMessageCell;
@protocol CSMessageCellDelegate <NSObject>

@optional
- (void)messageCellSingleClickedWith:(CSMessageCell *)cell;

@end

@class DJSChatMessageModel;

@interface CSMessageCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView messageModel:(DJSChatMessageModel *)model;

@property (nonatomic, strong) UIImageView *voiceAnimationImageView;
@property (nonatomic, strong) UIImageView *imageImageView;

@property (nonatomic, strong) DJSChatMessageModel* messageModel;
@property (nonatomic, weak) id<CSMessageCellDelegate> delegate;


-(void)stopVoiceAnimation;
-(void)startVoiceAnimation;
//-(void)startSentMessageAnimation;
//-(void)stopSentMessageAnimation;


@end
