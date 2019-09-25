//
//  DJSSentenceView.h
//  ChatHan
//
//  Created by 萨缪 on 2019/4/17.
//  Copyright © 2019年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJSSentenceView : UIView

@property(nonatomic , strong)NSMutableArray *buttonArray;
@property(nonatomic , strong)UITextView *sentTextView;
@property(nonatomic , strong)UIButton *reloadButton;
@property(nonatomic , strong)UIButton *downButton;

-(void)typeSettingWordArray:(NSMutableArray *)wordArray WithbuttonWidth:(NSMutableArray *)buttonWidthArray;
-(void)ButtonremoveFromSuperView:(NSInteger)number WithAll:(BOOL)isRemove;

@end
