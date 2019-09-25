//
//  YView.m
//  寒假项目
//
//  Created by 康思婉 on 2019/1/19.
//  Copyright © 2019年 康思婉. All rights reserved.
//
#import "Masonry.h"
#import "DJSYView.h"

@implementation DJSYView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(50);
            make.left.equalTo(self);
            make.bottom.equalTo(self);
            make.right.equalTo(self);
        }];
        _tableView.tag = 2019;
        
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.placeholder = @"请输入要查找的单词或中文";
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.showsCancelButton = YES;
        [self addSubview:_searchBar];
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.bottom.equalTo(self->_tableView.mas_top);
            make.right.equalTo(self);
        }];
        
    }
    return self;
}

@end

