//
//  DJSLoginScreenViewController.h
//  ChatHan
//
//  Created by 萨缪 on 2019/7/30.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJSLoginScreenViewController : UIViewController

@property (nonatomic, copy) void(^submitCallBackBlock)(NSString * tokenIdStr);


@end
