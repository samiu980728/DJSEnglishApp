//
//  Part1_TableViewCell.m
//  寒假项目
//
//  Created by 康思婉 on 2019/1/23.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSPart1_TableViewCell.h"
#import "Masonry.h"

@implementation DJSPart1_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _queryLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_queryLabel];
        
        _voiceButton = [[UIButton alloc]init];
        [self.contentView addSubview:_voiceButton];
        
        _collectionButton = [[UIButton alloc]init];
        [self.contentView addSubview:_collectionButton];
        
        _phoneticLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_phoneticLabel];
        
        _translationLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_translationLabel];
        
        _uk_phoneticLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_uk_phoneticLabel];
        
        _exam_typeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_exam_typeLabel];
        
        _explainsLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_explainsLabel];
        
        _ID = [[NSString alloc]init];
        _ID = @"123456789";
    }
    return self;
}
-(void)layoutSubviews{
    [self.queryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self->_voiceButton.mas_left);
    }];
    _queryLabel.font = [UIFont systemFontOfSize:35];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self->_queryLabel.mas_right);
        make.height.mas_equalTo(self->_queryLabel.mas_height);
    }];
    //    _voiceButton.backgroundColor = [UIColor yellowColor];
    [_voiceButton setImage:[UIImage imageNamed:@"voice.png"] forState:UIControlStateNormal];
    
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self->_voiceButton.mas_right).offset(10);
        make.height.mas_equalTo(self->_queryLabel.mas_height);
        make.right.equalTo(self).offset(-10);
    }];
    [_collectionButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.phoneticLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_queryLabel.mas_bottom);
        make.left.equalTo(self);
        make.height.mas_equalTo(self->_queryLabel.mas_height);
        make.right.equalTo(self->_translationLabel.mas_left);
    }];
    _phoneticLabel.font = [UIFont systemFontOfSize:25];
    
    [self.translationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_queryLabel.mas_bottom);
        make.left.mas_equalTo(self->_phoneticLabel.mas_right);
        make.height.mas_equalTo(self->_queryLabel.mas_height);
        make.right.equalTo(self);
    }];
    _translationLabel.font = [UIFont systemFontOfSize:25];
    
    [self.exam_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_phoneticLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(self->_queryLabel.mas_height);
        make.right.equalTo(self);
    }];
    _exam_typeLabel.font = [UIFont systemFontOfSize:25];
    
    _explainsLabel.numberOfLines = 0;
    [self.explainsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_exam_typeLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    _explainsLabel.font = [UIFont systemFontOfSize:25];
}

-(void)click{
    if ([self.delegate respondsToSelector:@selector(clickTest:)]) {
        [self.delegate clickTest:_ID];
        //        NSLog(@"%@",_ID);
    }else{
        NSLog(@"未响应");
    }
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

