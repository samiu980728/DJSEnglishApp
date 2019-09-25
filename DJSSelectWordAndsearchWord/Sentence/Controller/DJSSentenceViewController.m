//
//  DJSSentenceViewController.m
//  寒假项目
//
//  Created by 康思婉 on 2019/4/10.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSSentenceViewController.h"
#import "DJSSentenceModel.h"
#import "DJSSentenceView.h"
#import <Masonry.h>
#import "DJSYModel.h"
#import "DJSYSegleHand.h"

@interface DJSSentenceViewController ()<UITextViewDelegate>

@end

@implementation DJSSentenceViewController{
    DJSSentenceModel *sentModel;
    DJSSentenceView *sentView;
    NSString *textViewString;
    DJSYModel *yModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sentence";
    
    //数据库测试，完成插入，查找，删除
    DJSYSegleHand *seg = [DJSYSegleHand sharedSegleHandle];
    [seg insertIntoSentence:@"i am model"];
    [seg getSentence];
    [seg deleteSentsnce:@"i am model"];
    
    yModel = [[DJSYModel alloc]init];
    [yModel addObserver:self forKeyPath:@"sentence" options:NSKeyValueObservingOptionNew context:nil];
    
    textViewString = [[NSString alloc]init];
    sentModel = [[DJSSentenceModel alloc]init];
    [sentModel initWithModel];
    
    sentView = [[DJSSentenceView alloc]init];
    [self.view addSubview:sentView];
    [sentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    [sentView.reloadButton addTarget:self action:@selector(refreshSentView) forControlEvents:UIControlEventTouchUpInside];
    [sentView.downButton addTarget:self action:@selector(downLoadSentence) forControlEvents:UIControlEventTouchUpInside];
    sentView.sentTextView.delegate = self;
    
    textViewString = @"";
    sentView.sentTextView.text = @"";
    [self refreshSentView];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"sentence"]){
        id newData = [change objectForKey:NSKeyValueChangeNewKey];
        NSLog(@"%@",newData);
        sentView.sentTextView.text = [NSString stringWithFormat:@"%@\n%@",textViewString,newData];
    }
}
-(void)downLoadSentence{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认保存" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"保存按钮");
        //还应该添加查重，但是我懒
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"删除");
        
        self->textViewString = @"";
        self->sentView.sentTextView.text = @"";
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alertController addAction:action];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)refreshSentView{
    NSInteger i = 0;
    [sentView ButtonremoveFromSuperView:i WithAll:YES];
    
    //向model任意取十个单词，存在array里
    NSMutableArray *showWordArray = [[NSMutableArray alloc]init];
    NSInteger count = sentModel.wordArray.count;
    NSInteger number;
    for (int i = 0; i < 10; i ++) {
        number = arc4random()%count;
        [showWordArray addObject:sentModel.wordArray[number]];
    }
    //求宽度
    NSMutableArray *buttonWidthArray = [[NSMutableArray alloc]init];
    buttonWidthArray = [sentModel buttonWithWidth:showWordArray];
    //给View
    [sentView typeSettingWordArray:showWordArray WithbuttonWidth:buttonWidthArray];
    for (UIButton *wordButton in sentView.buttonArray) {
        [wordButton addTarget:self action:@selector(buttonSlideDown:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)buttonSlideDown:(UIButton *)button{
    //消失动画
    [self animatedWithButton:button];
    
    NSLog(@"%ld.%@",(long)button.tag,button.titleLabel.text);
    textViewString = [NSString stringWithFormat:@"%@ %@",textViewString,button.titleLabel.text];
    sentView.sentTextView.text = [NSString stringWithFormat:@"%@",textViewString];
    
    //加翻译
    [yModel requestTranslation:YES Text:textViewString showTheView:NO];
    
}
-(void)animatedWithButton:(UIButton *)button{
    CGPoint point = button.center;
    //    NSLog(@"%f,%f",point.x,point.y);
    [UIView animateWithDuration:0.5 animations:^{
        button.frame = CGRectMake(point.x, point.y, 0, 0);
    } completion:^(BOOL finished) {
        [self->sentView ButtonremoveFromSuperView:button.tag WithAll:NO];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [self->yModel removeObserver:self forKeyPath:@"sentence" context:nil];
}

@end

