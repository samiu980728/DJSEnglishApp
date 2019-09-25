//
//  DJSTranslateAFNetworkingModel.h
//  ChatHan
//
//  Created by 萨缪 on 2019/4/18.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJSTranslateAFNetworkingModel : NSObject

@property (nonatomic, copy) NSArray * translateArray;

@property (nonatomic, copy) NSString * phoneticString;

@property (nonatomic, copy) NSString * failureString;
- (void)getTranslateNetworkingWithString:(NSString *)input;

@end
