//
//  DJSSentenceModel.m
//  寒假项目
//
//  Created by 康思婉 on 2019/4/10.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSSentenceModel.h"
#import <UIKit/UIKit.h>

@implementation DJSSentenceModel

-(void)initWithModel{
    _wordArray = [[NSArray alloc]init];
    _wordArray = @[@"I",@"am",@"You",@"are",@"He",@"She",@"is",@"Success",@"Demo",@"beautifully",@"Sentence",@"Model",@"Word",@"Talk",@"single-morpheme",@"abcdefghijklmnopqrstuvwxyz"];
}
-(NSMutableArray *)buttonWithWidth:(NSMutableArray *)wordArray{
    NSMutableArray *buttonWidthArray = [[NSMutableArray alloc]init];
    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, [UIScreen mainScreen].bounds.size.height)];
    NSNumber *floatNumber;
    for (NSString *string in wordArray) {
        wordLabel.text = string;
        wordLabel.numberOfLines = 1;
        [wordLabel sizeToFit];
        floatNumber = [NSNumber numberWithFloat:wordLabel.frame.size.width + 20];
        [buttonWidthArray addObject:floatNumber ];
    }
    return buttonWidthArray;
}

@end

