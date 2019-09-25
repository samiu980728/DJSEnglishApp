//
//  Part2_TableViewCell.m
//  寒假项目
//
//  Created by 康思婉 on 2019/1/23.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSPart2_TableViewCell.h"
#import "Masonry.h"

@implementation DJSPart2_TableViewCell{
    NSInteger numberOfLabel;
    NSMutableArray *webArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _webButton = [[UIButton alloc]init];
        [self.contentView addSubview:_webButton];
        [_webButton setTitle:@" 网络释义 " forState:UIControlStateNormal];
        _webButton.titleLabel.font = [UIFont systemFontOfSize:25];
        _webButton.backgroundColor = [UIColor colorWithRed:0.93f green:0.83f blue:0.88f alpha:1.00f];
        [_webButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _webButton.layer.masksToBounds = YES;
        _webButton.layer.cornerRadius = 12;
        [_webButton addTarget:self action:@selector(webSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        _webButton.tag = 610;
        
        _labelArray = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(testSucceed:) name:@"numberofLabel" object:nil];
        webArray = [NSMutableArray array];
    }
    return self;
}

-(void)layoutSubviews{
    
    [_webButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self);
        make.height.mas_equalTo(@40);
    }];
    
    if (_labelArray.count == 0) {
        for (int i = 0; i < numberOfLabel; i++) {
            if (numberOfLabel > 10) {
                break;
            }
            UILabel *downLabel = [[UILabel alloc]init];
            [self.contentView addSubview:downLabel];
            downLabel.layer.masksToBounds = YES;
            downLabel.layer.cornerRadius = 25;
            if (i == 0) {
                [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(20);
                    make.right.equalTo(self).offset(-20);
                    make.top.equalTo(self->_webButton.mas_bottom).offset(10);
                }];
            }else{
                UILabel *beforeLabel = [[UILabel alloc]init];
                beforeLabel = _labelArray[i - 1];
                [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(20);
                    make.right.equalTo(self).offset(-20);
                    make.top.equalTo(beforeLabel.mas_bottom).offset(10);
                }];
            }
            
            UILabel *keyLabel = [[UILabel alloc]init];
            [downLabel addSubview:keyLabel];
            keyLabel.numberOfLines = 0;
            keyLabel.font = [UIFont systemFontOfSize:20];
            keyLabel.text = [NSString stringWithFormat:@"%@",webArray[i]];
            [keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(downLabel.mas_right).offset(-10);
                make.left.equalTo(downLabel.mas_left).offset(10);
                make.top.equalTo(downLabel.mas_top).offset(10);
                make.bottom.equalTo(downLabel.mas_bottom).offset(-10);
            }];
            downLabel.backgroundColor = [UIColor colorWithRed:0.93f green:0.83f blue:0.88f alpha:1.00f];
            [_labelArray addObject:downLabel];
        }
    }
}

-(void)testSucceed:(NSNotification *)notification{
    webArray = notification.userInfo[@"num"];
    numberOfLabel = webArray.count;
    
    UILabel *label = [[UILabel alloc]init];
    for (label in _labelArray) {
        [label removeFromSuperview];
    }
    _labelArray = [NSMutableArray array];
    
    //    NSNumber *intNumber = notification.userInfo[@"num"];
    //    numberOfLabel = [intNumber integerValue];
}

-(void)webSelectClick:(UIButton *)button{
    if (self.webclick) {
        self.webclick(button);
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

