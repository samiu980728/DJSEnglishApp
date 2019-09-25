//
//  DJSChatOneMessageView.m
//  ChatHan
//
//  Created by 萨缪 on 2019/9/25.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatOneMessageView.h"
#import "DJSArrayDataSource.h"
#import "DJSChatOneMessageTableViewCell.h"

@interface DJSChatOneMessageView ()

@property (nonatomic, strong) NSDictionary * messageDic;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) DJSArrayDataSource * dataSource;

@end

@implementation DJSChatOneMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createTableView];
    }
    return self;
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[DJSChatOneMessageTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //这样就不用设置高度代理啦
    self.tableView.rowHeight = 70;
    [self addSubview:self.tableView];
    
    TableViewCellConfigureBlock configureCell = ^(DJSChatOneMessageTableViewCell * cell, NSDictionary * dic, NSIndexPath * indexPath) {
        [cell configData:dic withIndexPath:indexPath];
    };
    
    
    
#pragma mark  现在的问题是 现在好像没问题了 .... 就剩下把dic字典赋值了
    
    
    
    self.dataSource = [[DJSArrayDataSource alloc] initWithItems:self.messageDic cellIdentifier:@"cell" configureCellBlock:configureCell];
    //这里直接赋值dataSource数据源就可以了
    self.tableView.dataSource = self.dataSource;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
