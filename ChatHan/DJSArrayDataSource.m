//
//  DJSArrayDataSource.m
//  ChatHan
//
//  Created by 萨缪 on 2019/9/25.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSArrayDataSource.h"

@interface DJSArrayDataSource()

@property (nonatomic, copy) NSDictionary * items;

@property (nonatomic, copy) NSString * cellIdentifier;

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end;

@implementation DJSArrayDataSource

- (instancetype)init {
    return nil;
}

- (id)initWithItems:(NSDictionary *)anItemsDic cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfiguteCellBlock {
    self = [super init];
    if (self) {
        ///这个也有值了
        self.items = anItemsDic;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfiguteCellBlock;
    }
    return self;
}

#pragma mark 这个方法不是必要的吧？？？
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items;
//    return self.items[(NSUInteger) indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
#pragma mark 不用这个可不可以 直接用index.row
    //这个item是数据 所以不能够替换！！！
    id item = [self itemAtIndexPath:indexPath];
#pragma mark 在这里传入块参数
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

@end
