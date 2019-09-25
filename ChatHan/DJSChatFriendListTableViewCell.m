//
//  DJSChatFriendListTableViewCell.m
//  ChatHan
//
//  Created by 萨缪 on 2019/8/6.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatFriendListTableViewCell.h"
#import <Masonry.h>

@implementation DJSChatFriendListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        
        self.chatContentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.chatContentLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    [self.chatContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
