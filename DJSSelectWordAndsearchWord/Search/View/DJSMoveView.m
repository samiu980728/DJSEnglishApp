//
//  MoveView.m
//  寒假项目
//
//  Created by 康思婉 on 2019/1/23.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSMoveView.h"
#import "Masonry.h"

@implementation DJSMoveView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _longTableView = [[UITableView alloc]init];
        [self addSubview:_longTableView];
        [_longTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        _longTableView.tag = 101;
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

