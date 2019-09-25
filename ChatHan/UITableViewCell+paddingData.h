//
//  UITableViewCell+paddingData.h
//  ChatHan
//
//  Created by 萨缪 on 2019/8/7.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSChatWithPeopleModel.h"

@interface UITableViewCell (paddingData)

- (void)paddingDataModel:(DJSChatWithPeopleModel *)model indexPath:(NSIndexPath *)indexPath delegate:(id)delegate;

@end
