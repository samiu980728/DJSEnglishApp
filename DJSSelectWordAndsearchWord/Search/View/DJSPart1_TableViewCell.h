//
//  Part1_TableViewCell.h
//  寒假项目
//
//  Created by 康思婉 on 2019/1/23.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Part1_TableViewCellDelegate <NSObject>

-(void)clickTest:(NSString *)tag;

@end

@interface DJSPart1_TableViewCell : UITableViewCell

@property(nonatomic , strong)UILabel *queryLabel;
@property(nonatomic , strong)UILabel *phoneticLabel;
@property(nonatomic , strong)UILabel *uk_phoneticLabel;
@property(nonatomic , strong)UILabel *translationLabel;
@property(nonatomic , strong)UILabel *exam_typeLabel;
@property(nonatomic , strong)UIButton *collectionButton;
@property(nonatomic , strong)UIButton *voiceButton;
@property(nonatomic , strong)UILabel *explainsLabel;

@property(nonatomic , strong)NSString *ID;
@property(nonatomic , assign)id<Part1_TableViewCellDelegate> delegate;

@end

