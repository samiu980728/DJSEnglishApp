//
//  DJSArrayDataSource.h
//  ChatHan
//
//  Created by 萨缪 on 2019/9/25.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TableViewCellConfigureBlock)(id cell, id items, NSIndexPath * indexPath);

@interface DJSArrayDataSource : NSObject <UITableViewDataSource>
- (id)initWithItems:(NSDictionary *)anItemsDic cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfiguteCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;



@end
