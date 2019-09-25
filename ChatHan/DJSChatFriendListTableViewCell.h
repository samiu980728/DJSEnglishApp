//
//  DJSChatFriendListTableViewCell.h
//  ChatHan
//
//  Created by 萨缪 on 2019/8/6.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSChatWithPeopleModel.h"

@protocol DJSTableViewCellDelegate <NSObject>

//刷新某一行数据
- (void)reloadWithModel:(DJSChatWithPeopleModel * )model indexPath:(NSIndexPath *)indexPath;

//增加一行
- (void)addWithModel:(DJSChatWithPeopleModel *)model indexPath:(NSIndexPath *)indexPath;

//删除一行
- (void)removeWithModel:(DJSChatWithPeopleModel *)model idnexPath:(NSIndexPath *)indexPath;



@end

@interface DJSChatFriendListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * iconImageView;

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILabel * chatContentLabel;

@property (nonatomic, weak) id <DJSTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath * indexPath;

@end
