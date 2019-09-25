//
//  DJSChatInterfaceTableViewCell.m
//  ChatHan
//
//  Created by 萨缪 on 2019/8/9.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatInterfaceTableViewCell.h"
#import "UILabel+Han.h"
#import "UIImage+Han.h"
#import <Masonry.h>

@implementation DJSChatInterfaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView messageModel:(DJSChatInterfaceModel *)model {
    static NSString * identifier = @"WeChatCell";
    DJSChatInterfaceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DJSChatInterfaceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.interfaceModel = [[DJSChatInterfaceModel alloc] init];
    cell.interfaceModel = model;
    return cell;
}

#pragma mark 这个方法没有被调用！！！
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self textFont];
        [self messageLabel];
        [self timeLabel];
        [self logoImageView];
        [self imageImageView];
        [self bubbleImageView];
        [self interfaceModel];
    }
    return self;
}

- (UIFont *)textFont {
    if (_textFont == nil) {
        _textFont = [UIFont systemFontOfSize:16];
    }
    return _textFont;
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = _textFont;
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.hidden = YES;
        [self.contentView addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.hidden = YES;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.hidden = YES;
        [self.contentView addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (UIButton *)imageButton {
    if (!_imageButton) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.hidden = YES;
        [_imageButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_logoImageView addSubview:_imageButton];
    }
    return _imageButton;
}

- (void)buttonClick:(UIButton *)button {
    if (self.buttonAction) {
#pragma mark 这个30是暂时的 静态ID
        self.buttonAction(button, @"30");
    }
}

- (UIImageView *)imageImageView {
    if (_imageImageView == nil) {
        _imageImageView = [[UIImageView alloc] init];
        _imageImageView.hidden = YES;
        [self.contentView addSubview:_imageImageView];
    }
    return _imageImageView;
}

- (UIImageView *)bubbleImageView {
    if (_bubbleImageView == nil) {
        _bubbleImageView = [[UIImageView alloc] init];
        _bubbleImageView.hidden = YES;
        [self.contentView addSubview:_bubbleImageView];
    }
    return _bubbleImageView;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.timeLabel.backgroundColor = [UIColor greenColor];
    self.messageLabel.backgroundColor = [UIColor yellowColor];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).offset(30);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(200);
//    }];
//    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left
//    }];
}


#pragma mark 问题出在这！！！ 打断点_interfaceModel里面全是空的呢！！！
- (void)giveTheValueToInterfaceModel {
    _timeLabel.frame = [_interfaceModel timeFrame];
    _timeLabel.text = _interfaceModel.messageTime;
    
    _logoImageView.hidden = NO;
    _logoImageView.frame = [_interfaceModel logoFrame];
    _imageButton.frame = _logoImageView.frame;
    _imageButton.hidden = NO;
    
    _bubbleImageView.hidden = NO;
    _bubbleImageView.frame = [_interfaceModel bubbleFrame];
    
    if (_interfaceModel.messageSenderType == messageSenderMe) {
        _logoImageView.image = [UIImage imageNamed:@"w"];
        _bubbleImageView.image = [[UIImage imageNamed:@"me"] stretchableImageWithLeftCapWidth:20 topCapHeight:40];
        _messageLabel.textAlignment = NSTextAlignmentRight;
    } else {
        _logoImageView.image = [UIImage imageNamed:@"m"];
        _bubbleImageView.image = [[UIImage imageNamed:@"other"] stretchableImageWithLeftCapWidth:20 topCapHeight:40];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    switch (_interfaceModel.messageType) {
        case messageTypeText:
            _messageLabel.hidden = NO;
            _messageLabel.frame = [_interfaceModel messageFrame];
            _messageLabel.text = _interfaceModel.messageTextStr;
            break;
        case messageTypeImage:
            _imageImageView.hidden = NO;
            _imageImageView.frame = [_interfaceModel imageFrame];
            
            _imageImageView.image = _interfaceModel.messageImageSmall;
            CGSize imageSize = [_interfaceModel.messageImageSmall imageShowSize];
            UIImageView * imageViewMask = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:_interfaceModel.messageSenderType == messageSenderMe ? @"me" :@"other"] stretchableImageWithLeftCapWidth:20 topCapHeight:40]];
            imageViewMask.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
            _imageImageView.layer.mask = imageViewMask.layer;
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
