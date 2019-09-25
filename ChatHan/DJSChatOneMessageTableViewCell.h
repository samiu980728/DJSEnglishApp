//
//  DJSChatOneMessageTableViewCell.h
//  ChatHan
//
//  Created by 萨缪 on 2019/9/25.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJSChatOneMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UIImageView * labelImageView;

- (void)configData:(NSDictionary *)nameDic withIndexPath:(NSIndexPath *)indexPath;

@end
