//
//  Part2_TableViewCell.h
//  寒假项目
//
//  Created by 康思婉 on 2019/1/23.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebSelect)(UIButton *webButtonTest);

@interface DJSPart2_TableViewCell : UITableViewCell

@property(nonatomic , copy)WebSelect webclick;

@property(nonatomic , strong)NSMutableArray *labelArray;
@property(nonatomic , strong)UIButton *webButton;

@end

