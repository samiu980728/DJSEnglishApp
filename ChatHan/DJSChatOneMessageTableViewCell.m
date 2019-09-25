//
//  DJSChatOneMessageTableViewCell.m
//  ChatHan
//
//  Created by 萨缪 on 2019/9/25.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatOneMessageTableViewCell.h"
#import <Masonry.h>

@implementation DJSChatOneMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.labelImageView = [[UIImageView alloc] init];
        self.nameLabel.backgroundColor = [UIColor grayColor];
        self.nameLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.labelImageView];
    }
    return self;
}

//在这里如何获取indexPath呢
- (void)configData:(NSDictionary *)nameDic withIndexPath:(NSIndexPath *)indexPath {
#pragma mark 在这里面应该获得一个数组 然后 根据当前indexPath.row给对应的label赋值text
    NSArray * nameArray = [nameDic objectForKey:@"name"];
    self.nameLabel.text = nameArray[indexPath.row];
    
    NSArray * imageArray = [nameDic objectForKey:@"image"];
    self.labelImageView.image = imageArray[indexPath.row];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.labelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labelImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(150);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
