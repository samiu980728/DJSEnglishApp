//
//  YWebView.h
//  ChatHan
//
//  Created by 萨缪 on 2019/4/17.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface DJSYWebView : UIView

@property(nonatomic , strong)UILabel *youdaoLabel;
@property(nonatomic , strong)UIButton *backButton;
@property(nonatomic , strong)WKWebView *wkWebView;
@property(nonatomic , strong)UIProgressView *progressView;

@end
