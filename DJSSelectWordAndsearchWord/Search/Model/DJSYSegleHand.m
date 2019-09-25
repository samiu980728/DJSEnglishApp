//
//  YSegleHand.m
//  寒假项目
//
//  Created by 康思婉 on 2019/1/29.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSYSegleHand.h"
#import <FMDB.h>

DJSYSegleHand *handle = nil;

@interface DJSYSegleHand(){
    FMDatabase *fmdb;
}
@end

@implementation DJSYSegleHand

+(instancetype)sharedSegleHandle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[DJSYSegleHand alloc]init];
    });
    return handle;
}

-(void)initDataBase{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"main.db"];
    fmdb = [FMDatabase databaseWithPath:filePath];
    if ([fmdb open]) {
        [self addMainCellTable];
        [self addMoveCollectionTable];
        [self addSentenceTable];
        NSLog(@"数据库打开");
        [fmdb close];
    }else{
        NSLog(@"数据库打开失败---%@",fmdb.lastErrorMessage);
    }
}
//创表Sentence
-(void)addSentenceTable{
    NSString *sentenceSQL = @"create table if not exists sentenceTable (id integer primary key autoincrement not null, sentence text not null)";
    BOOL Success = [fmdb executeUpdate:sentenceSQL];
    if (Success) {
        NSLog(@"sentence创表成功");
    }else{
        NSLog(@"sentence创表失败");
    }
}
//增加一个
-(void)insertIntoSentence:(NSString *)string{
    [fmdb open];
    NSString *SQL = @"insert into sentenceTable (sentence) values(?)";
    BOOL isAddSuccess = [fmdb executeUpdate:SQL,string];
    if (isAddSuccess) {
        NSLog(@"插入信息成功");
    }else{
        NSLog(@"插入信息失败");
    }
    [fmdb close];
}
//删除一个
-(void)deleteSentsnce:(NSString *)string{
    [fmdb open];
    NSString *SQL = @"delete from sentenceTable where sentence = ?";
    BOOL isSuccess = [fmdb executeUpdate:SQL,string];
    if (isSuccess) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    [fmdb close];
}
//查全部
-(NSMutableArray *)getSentence{
    NSMutableArray *allArray = [NSMutableArray array];
    [fmdb open];
    FMResultSet *result = [fmdb executeQuery:@"select *from sentenceTable"];
    while ([result next]) {
        NSString *wordString = [result stringForColumn:@"sentence"];
        [allArray addObject:wordString];
    }
    [fmdb close];
    NSLog(@"%@",allArray);
    return allArray;
}
//创表move
-(void)addMoveCollectionTable{
    NSString *moveCollSQL = @"create table if not exists moveCollTable1 (id integer primary key autoincrement not null, query text not null, explains text not null)";
    BOOL Success = [fmdb executeUpdate:moveCollSQL];
    if (Success) {
        NSLog(@"move创表成功");
    }else{
        NSLog(@"move创表失败");
    }
}
//增加一个
-(void)insertIntoMoveColl:(NSDictionary *)dic{
    NSString *query = dic[@"query"];
    NSString *explains = dic[@"explains"];
    [fmdb open];
    NSString *SQL = @"insert into moveCollTable1 (query, explains) values(?, ?)";
    BOOL isAddSuccess = [fmdb executeUpdate:SQL,query,explains];
    if (isAddSuccess) {
        NSLog(@"插入信息成功");
    }else{
        NSLog(@"插入信息失败");
    }
    [fmdb close];
}
//删除一个
-(void)deleteMoveCollTable:(NSDictionary *)dic{
    NSString *query = dic[@"query"];
    [fmdb open];
    NSString *SQL = @"delete from moveCollTable1 where query = ?";
    BOOL isSuccess = [fmdb executeUpdate:SQL,query];
    if (isSuccess) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    [fmdb close];
}
//查一个
-(BOOL)searchMoveCollTable:(NSString *)query{//查到了返回0，没查到返回1
    //    NSString *query = dic[@"query"];
    BOOL Success = 1;
    [fmdb open];
    FMResultSet *result = [fmdb executeQuery:@"select *from moveCollTable1 where query = ?",query];
    if (result) {
        while ([result next]) {
            //            NSString *query_ = [result stringForColumn:@"query"];
            //            NSString *phonetic = [result stringForColumn:@"phonetic"];
            //            NSString *translation = [result stringForColumn:@"translation"];
            //            NSString *exam = [result stringForColumn:@"exam"];
            //            NSLog(@"%@%@%@%@",query_,phonetic,translation,exam);
            Success = 0;
        }
    }else{
        Success = 1;
    }
    return Success;
}
//创表main
-(void)addMainCellTable{
    NSString *mainCellSQL = @"create table if not exists mainCellTable (id integer primary key autoincrement not null, query text not null, phonetic text not null, translation text not null, exam text not null)";
    BOOL Success = [fmdb executeUpdate:mainCellSQL];
    if (Success) {
        NSLog(@"mainCellTable创表成功");
    }else{
        NSLog(@"mainCellTable创表失败");
    }
}
//插入，增
-(void)insertIntoMainCell:(NSDictionary *)dic{
    NSString *query = dic[@"query"];
    NSString *phonetic = dic[@"phonetic"];
    NSString *translation = dic[@"translation"];
    NSString *exam = dic[@"exam_type"];
    [fmdb open];
    NSString *SQL = @"insert into mainCellTable(query, phonetic, translation, exam) values(?, ?, ?, ?)";
    BOOL isAddSuccess = [fmdb executeUpdate:SQL,query,phonetic,translation,exam];
    if (isAddSuccess) {
        NSLog(@"插入信息成功");
    }else{
        NSLog(@"插入信息失败");
    }
    [fmdb close];
}
//删除, 部分
-(void)deleteMainCellTable:(NSDictionary *)dic{
    NSString *query = dic[@"query"];
    [fmdb open];
    NSString *SQL = @"delete from mainCellTable where query = ?";
    BOOL isSuccess = [fmdb executeUpdate:SQL,query];
    if (isSuccess) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    [fmdb close];
}
//删除，全部
-(void)deleteMainCellTable{
    [fmdb open];
    NSString *SQL = @"DELETE FROM mainCellTable";
    BOOL isSuccess = [fmdb executeUpdate:SQL];
    if (isSuccess) {
        NSLog(@"全部删除成功");
    }else{
        NSLog(@"全部删除失败");
    }
}
//查，部分
-(BOOL)searchMainCellTable:(NSDictionary *)dic{
    NSString *query = dic[@"query"];
    BOOL Success = 1;
    [fmdb open];
    FMResultSet *result = [fmdb executeQuery:@"select *from mainCellTable where query = ?",query];
    if (result) {
        while ([result next]) {
            NSString *query_ = [result stringForColumn:@"query"];
            NSString *phonetic = [result stringForColumn:@"phonetic"];
            NSString *translation = [result stringForColumn:@"translation"];
            NSString *exam = [result stringForColumn:@"exam"];
            NSLog(@"%@%@%@%@",query_,phonetic,translation,exam);
            Success = 0;
        }
    }else{
        Success = 1;
    }
    return Success;
}
//查，全部
-(NSMutableArray *)getMainCellTable{
    NSMutableArray *allArray = [NSMutableArray array];
    NSDictionary *dic = [[NSDictionary alloc]init];
    [fmdb open];
    FMResultSet *result = [fmdb executeQuery:@"select *from mainCellTable"];
    while ([result next]) {
        NSString *query = [result stringForColumn:@"query"];
        NSString *phonetic = [result stringForColumn:@"phonetic"];
        NSString *translation = [result stringForColumn:@"translation"];
        NSString *exam = [result stringForColumn:@"exam"];
        dic = @{@"query":query,@"phonetic":phonetic,@"translation":translation,@"exam":exam};
        [allArray addObject:dic];
    }
    [fmdb close];
    return allArray;
}
@end

