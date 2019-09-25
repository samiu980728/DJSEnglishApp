//
//  DJSRewriteChatInterfaceTableViewCell.m
//  ChatHan
//
//  Created by 萨缪 on 2019/8/13.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSRewriteChatInterfaceTableViewCell.h"
#import <Masonry.h>

@implementation DJSRewriteChatInterfaceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];

    }
    return self;
}

//致敬去年的知乎日报
- (void)createUI {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changHeight:) name:@"changHeightNoti" object:nil];
    self.imageImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageImageView];
    
    self.logoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.logoImageView];
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
#pragma mark 问题 这个按钮就没有加上！！！ 看看是不是Masonry的问题
//    self.imageButton.hidden = YES;
    [self.imageButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.imageButton];
    
    //气泡
    self.bubbleImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bubbleImageView];
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.numberOfLines = 0;
    [self.contentView addSubview:self.messageLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(180);
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(250);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_right).offset(-50);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.logoImageView);
    }];
    
    //气泡和聊天内容可以先不用弄
}

- (void)buttonClick:(UIButton *)button {
    if (self.buttonAction) {
#pragma mark 这个30是暂时的 静态ID
        self.buttonAction(button, @"30");
    }
}

- (void)setMessage:(DJSChatInterfaceModel *)messageModel {
    self.bubbleImageView.image = [[UIImage imageNamed:@"me"] stretchableImageWithLeftCapWidth:20 topCapHeight:40];
    self.logoImageView.image = [UIImage imageNamed:@"w"];
    self.timeLabel.text = messageModel.messageTime;
    self.messageLabel.text = messageModel.messageTextStr;
    CGSize textSize = [self labelAutoCaculateRectWith:messageModel.messageTextStr Font:[UIFont systemFontOfSize:18] MaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.7 - 65, MAXFLOAT)];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.logoImageView.mas_left).offset(-10);
        make.width.mas_equalTo(textSize.width);
        make.height.mas_equalTo(textSize.height);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
    }];
    
    [self.bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.logoImageView.mas_left);
        make.width.mas_equalTo(textSize.width+20);
        make.height.mas_equalTo(textSize.height+5);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(8);
    }];
    
#pragma mark 在这里依靠姜凯文的那个demo给button添加点击事件
}

- (CGSize)labelAutoCaculateRectWith:(NSString *)textStr Font:(UIFont *)textFont MaxSize:(CGSize)maxSize {
    NSDictionary * attritues = @{NSFontAttributeName:textFont};
    CGRect rect = [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attritues context:nil];
    return rect.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
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
