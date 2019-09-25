//
//  YWebView.m
//  寒假项目
//
//  Created by 康思婉 on 2019/2/13.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSYWebView.h"
#import "Masonry.h"

@implementation DJSYWebView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _wkWebView = [[WKWebView alloc]init];
        _wkWebView.autoresizesSubviews = YES;
        [self addSubview:_wkWebView];
        [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(50);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        _progressView = [[UIProgressView alloc]init];
        _progressView.tintColor = [UIColor colorWithRed:0.93f green:0.83f blue:0.88f alpha:1.00f];
        _progressView.trackTintColor = [UIColor whiteColor];
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(50);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@5);
        }];
        
        _backButton = [[UIButton alloc]init];
        [_backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [self addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.bottom.equalTo(self->_wkWebView.mas_top);
        }];
        _backButton.tag = 119;
        
        _youdaoLabel = [[UILabel alloc]init];
        _youdaoLabel.text = @"感谢有道词典提供API";
        _youdaoLabel.font = [UIFont systemFontOfSize:25];
        [self addSubview:_youdaoLabel];
        [_youdaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_backButton.mas_right).offset(20);
            make.top.equalTo(self);
            make.bottom.equalTo(self->_wkWebView.mas_top);
        }];
    }
    return self;
}
@end

