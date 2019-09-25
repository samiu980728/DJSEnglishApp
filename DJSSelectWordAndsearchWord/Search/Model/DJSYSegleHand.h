//
//  YSegleHand.h
//  ChatHan
//
//  Created by 萨缪 on 2019/4/17.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJSYSegleHand : NSObject

+(instancetype)sharedSegleHandle;
-(void)initDataBase;

-(void)insertIntoMainCell:(NSDictionary *)dic;
-(void)deleteMainCellTable:(NSDictionary *)dic;
-(void)deleteMainCellTable;
-(NSMutableArray *)getMainCellTable;
-(BOOL)searchMainCellTable:(NSDictionary *)dic;

-(void)insertIntoMoveColl:(NSDictionary *)dic;
-(void)deleteMoveCollTable:(NSDictionary *)dic;
-(BOOL)searchMoveCollTable:(NSString *)query;

-(void)insertIntoSentence:(NSString *)string;
-(void)deleteSentsnce:(NSString *)string;
-(NSMutableArray *)getSentence;

@end
