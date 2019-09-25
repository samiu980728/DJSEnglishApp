//
//  DJSSentenceModel.h
//  ChatHan
//
//  Created by 萨缪 on 2019/4/17.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJSSentenceModel : NSObject

@property(nonatomic , strong)NSArray *wordArray;

-(void)initWithModel;
-(NSMutableArray *)buttonWithWidth:(NSMutableArray *)wordArray;

@end
