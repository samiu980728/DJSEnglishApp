//
//  YModel.h
//  ChatHan
//
//  Created by 萨缪 on 2019/4/17.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJSYModel : NSObject

@property(nonatomic , strong)NSDictionary *postSimpleDict;
@property(nonatomic , strong)NSDictionary *allDataDic;
@property(nonatomic , strong)NSDictionary *simpleDic;

@property(nonatomic , strong)NSString *sentence;//sentence的翻译

//@property(nonatomic , strong)AllJson *allJson;

-(void)initWithModel;
-(void)requestTranslation:(BOOL)translation Text:(NSString *)textString showTheView:(BOOL)showTheView;
-(void)postAllData;

@end
