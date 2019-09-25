//
//  DJSChatWithPeopleModel.m
//  ChatHan
//
//  Created by 萨缪 on 2019/8/7.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatWithPeopleModel.h"

@implementation DJSChatWithPeopleModel

- (instancetype)initWithDic:(NSDictionary *)dic rowHeight:(CGFloat)rowHeight identifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        self.dicModel = dic;
        self.rowHeight = rowHeight;
        self.cellIdentifier = identifier;
    }
    return self;
}

@end
