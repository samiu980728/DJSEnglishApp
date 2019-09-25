//
//  DJSChatWithPeopleModel.h
//  ChatHan
//
//  Created by 萨缪 on 2019/8/7.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DJSChatWithPeopleModel : NSObject


@property (nonatomic, strong) NSDictionary * dicModel;

//cell复用标识
@property (nonatomic, strong) NSString * cellIdentifier;

//行高
@property (nonatomic, assign)  CGFloat rowHeight;


//存字典
- (instancetype)initWithDic:(NSDictionary *)dic rowHeight:(CGFloat)rowHeight identifier:(NSString *)identifier;

@end
