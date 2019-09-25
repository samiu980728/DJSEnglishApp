//
//  TableViewCell.m
//  寒假项目
//
//  Created by 康思婉 on 2019/1/22.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSTableViewCell.h"
#import <Masonry.h>

@implementation DJSTableViewCell

-(void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 20;
        self.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        
        _queryLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_queryLabel];
        _queryLabel.tintColor = [UIColor blackColor];
        _queryLabel.text = @"单词";
        _queryLabel.font = [UIFont systemFontOfSize:30];
        
        _phoneticLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_phoneticLabel];
        _phoneticLabel.tintColor = [UIColor grayColor];
        _phoneticLabel.text = @"音标";
        _phoneticLabel.textAlignment = NSTextAlignmentRight;
        _phoneticLabel.font = [UIFont systemFontOfSize:25];
        
        _translationLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_translationLabel];
        _translationLabel.tintColor = [UIColor grayColor];
        //        _translationLabel.text = @"翻译";
        _translationLabel.font = [UIFont systemFontOfSize:25];
        //        _translationLabel.backgroundColor = [UIColor redColor];
        
        _exam_typeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_exam_typeLabel];
        _exam_typeLabel.tintColor = [UIColor grayColor];
        _exam_typeLabel.text = @"四级";
        _exam_typeLabel.font = [UIFont systemFontOfSize:25];
        _exam_typeLabel.textAlignment = NSTextAlignmentRight;
        //        _exam_typeLabel.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_phoneticLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self->_translationLabel.mas_top);
    }];
    
    [_queryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self->_phoneticLabel.mas_left).offset(-10);
        make.bottom.equalTo(self->_translationLabel.mas_top);
    }];
    
    [_translationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self->_queryLabel.mas_bottom);
        make.right.equalTo(self->_exam_typeLabel.mas_left);
        make.bottom.equalTo(self);
    }];
    
    [_exam_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self->_translationLabel.mas_right);
        make.top.equalTo(self->_queryLabel.mas_bottom);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom);
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

