//
//  DJSSentenceView.m
//  寒假项目
//
//  Created by 康思婉 on 2019/4/10.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSSentenceView.h"
#import <Masonry.h>

@implementation DJSSentenceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat textViewHeight = [UIScreen mainScreen].bounds.size.height / 3.5;
        NSNumber *number = [NSNumber numberWithFloat:textViewHeight];
        _sentTextView = [[UITextView alloc]init];
        [self addSubview:_sentTextView];
        [_sentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.bottom.equalTo(self).offset(-20);
            make.height.equalTo(number);
        }];
        _sentTextView.font = [UIFont systemFontOfSize:18];
        _sentTextView.backgroundColor = [UIColor colorWithRed:0.30f green:0.69f blue:0.64f alpha:1.00f];
        _sentTextView.layer.masksToBounds = YES;
        _sentTextView.layer.cornerRadius = (textViewHeight - 20) / 10;
        
        _reloadButton = [[UIButton alloc]init];
        _reloadButton.backgroundColor = [UIColor colorWithRed:0.30f green:0.69f blue:0.64f alpha:1.00f];
        [_reloadButton setTitle:@"R" forState:UIControlStateNormal];
        [self addSubview:_reloadButton];
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(- 20);
            make.bottom.equalTo(self->_sentTextView.mas_top).offset(-10);
            make.width.equalTo(@30);
        }];
        _reloadButton.layer.masksToBounds = YES;
        _reloadButton.layer.cornerRadius = 15;
        
        _downButton = [[UIButton alloc]init];
        _downButton.backgroundColor = [UIColor colorWithRed:0.30f green:0.69f blue:0.64f alpha:1.00f];
        [_downButton setTitle:@"D" forState:UIControlStateNormal];
        [self addSubview:_downButton];
        [_downButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.bottom.equalTo(self->_sentTextView.mas_top).offset(-10);
            make.width.equalTo(@30);
        }];
        _downButton.layer.masksToBounds = YES;
        _downButton.layer.cornerRadius = 15;
    }
    return self;
}

-(void)typeSettingWordArray:(NSMutableArray *)wordArray WithbuttonWidth:(NSMutableArray *)buttonWidthArray{
    _buttonArray = [[NSMutableArray alloc]init];
    
    CGFloat UISceen_Width = [UIScreen mainScreen].bounds.size.width;
    CGFloat xPositionWidth = 20;//x起始位置
    CGFloat yPositionHeight = 20;//y起始位置
    CGFloat xInterval = 20;//x单词间隔
    CGFloat yInterval = 30;//y单词间隔
    CGFloat wordHeight = 35;//单词高度
    int i = 0;
    
    for (int j = 0; j < 4; j++) {//san行单词
        xPositionWidth = 20;
        while (i < wordArray.count && xPositionWidth + [buttonWidthArray[i] floatValue] < UISceen_Width) {
            UIButton *wordButton = [[UIButton alloc]initWithFrame:CGRectMake(xPositionWidth, yPositionHeight, [buttonWidthArray[i] floatValue], wordHeight)];
            wordButton.tag = i;
            wordButton.backgroundColor = [UIColor colorWithRed:0.30f green:0.69f blue:0.64f alpha:1.00f];
            wordButton.layer.masksToBounds = YES;
            wordButton.layer.cornerRadius = wordHeight / 4;
            [wordButton setTitle:wordArray[i] forState:UIControlStateNormal];
            [self addSubview:wordButton];
            xPositionWidth += [buttonWidthArray[i] floatValue] + xInterval;
            i ++;
            [_buttonArray addObject:wordButton];
        }
        yPositionHeight += wordHeight + yInterval;
    }
}
-(void)ButtonremoveFromSuperView:(NSInteger)number WithAll:(BOOL)isRemove{
    UIButton *button;
    if (isRemove) {
        for (button in _buttonArray) {
            [button removeFromSuperview];
        }
    }else{
        button = _buttonArray[number];
        [button removeFromSuperview];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

