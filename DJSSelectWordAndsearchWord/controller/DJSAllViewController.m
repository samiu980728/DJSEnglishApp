//
//  DJSAllViewController.m
//  ChatHan
//
//  Created by 萨缪 on 2019/4/17.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSAllViewController.h"
#import "DJSYView.h"
#import "Masonry.h"
#import "DJSYModel.h"
#import "DJSTableViewCell.h"
#import "DJSMoveView.h"
#import "DJSYWebView.h"
#import "DJSPart1_TableViewCell.h"
#import "DJSPart2_TableViewCell.h"
#import "DJSYSegleHand.h"
#import <WebKit/WebKit.h>
@interface DJSAllViewController ()

@end

@implementation DJSAllViewController
{
    BOOL translation;//1位英->中，0位中->英
    BOOL moveUpDown;//1在下，可以升，0在下，可以降
    BOOL postNotifiWithModel;//1可以发送，0之前发送过不可发送
    BOOL haveCollection;//1未收藏，0已收藏；
    DJSYView *mainView;
    DJSYModel *model;
    DJSMoveView *moveView;
    DJSYWebView *webView;
    NSDictionary *newDict;
    NSMutableArray *heightArray;
    UIAlertView *alert;
    NSMutableArray *historyArray;
    NSDictionary *simpleDic;
    NSMutableArray *mainCellArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Search";
    
    NSMutableArray *mutableArray;
    [mutableArray replaceObjectAtIndex:1 withObject:@"dog"];
    NSMutableDictionary *mutableDic;
    [mutableDic setObject:@"Galloway" forKey:@"lastName"];
    
    mutableArray[1] = @"dog";
    mutableDic[@"lastName"] = @"Galloway";
    
    newDict = [[NSDictionary alloc]init];
    heightArray = [NSMutableArray array];
    historyArray = [NSMutableArray array];
    simpleDic = [[NSDictionary alloc]init];
    mainCellArray = [NSMutableArray array];
    
    DJSYSegleHand *seg = [DJSYSegleHand sharedSegleHandle];
    [seg initDataBase];
    mainCellArray = [seg getMainCellTable];
    //    NSLog(@"mainCellArray : %@",mainCellArray);
    
    self->model = [[DJSYModel alloc]init];
    [model initWithModel];
    [self->model addObserver:self forKeyPath:@"postSimpleDict" options:NSKeyValueObservingOptionNew context:nil];//model返回值监听
    
    moveView = [[DJSMoveView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70)];
    moveView.backgroundColor = [UIColor grayColor];
    webView = [[DJSYWebView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, 0, self.view.frame.size.height)];
    [webView.backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [webView.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];//网络加载进度监听
    
    translation = 1;
    moveUpDown = 1;
    postNotifiWithModel = 1;
    haveCollection = 1;
    mainView = [[DJSYView alloc]init];
    [self.view addSubview:mainView];
    [self.view addSubview:moveView];
    [self.view addSubview:webView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    NSInteger i = arc4random()%6;
    NSLog(@"随机图片：%ld",i);
    mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg",(long)i]]];
    mainView.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg",(long)i]]];
    
    mainView.searchBar.delegate = self;
    mainView.tableView.delegate = self;
    mainView.tableView.dataSource = self;
    [mainView.tableView registerClass:[DJSTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    moveView.longTableView.delegate = self;
    moveView.longTableView.dataSource = self;
    moveView.longTableView.allowsSelection = NO;
    
    [moveView.longTableView registerClass:[DJSPart1_TableViewCell class] forCellReuseIdentifier:@"cellL"];
    [moveView.longTableView registerClass:[DJSPart2_TableViewCell class] forCellReuseIdentifier:@"cellM"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allDataFromModel:) name:@"allData" object:nil];
    
    alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"本词条未收入， 请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
}
-(void)clearHistory{
    DJSYSegleHand *seg = [DJSYSegleHand sharedSegleHandle];
    [seg deleteMainCellTable];
    mainCellArray = [seg getMainCellTable];
    [mainView.tableView reloadData];
    
    //@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initWithWidth: andHeight: instead." userInfo:nil];//抛出警告
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    if (scrollView.tag == 101 && postNotifiWithModel) {//加历史记录
        [model postAllData];
        postNotifiWithModel = 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2019) {
        DJSTableViewCell *Cell = nil;
        Cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (Cell == nil) {
            Cell = [[DJSTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        //存放历史记录
        if (mainCellArray.count) {
            Cell.queryLabel.text = mainCellArray[indexPath.row][@"query"];
            Cell.phoneticLabel.text = [NSString stringWithFormat:@"/%@/",mainCellArray[indexPath.row][@"phonetic"]];
            Cell.translationLabel.text = mainCellArray[indexPath.row][@"translation"];
            Cell.exam_typeLabel.text = mainCellArray[indexPath.row][@"exam"];
        }
        return Cell;
    }else{//101
        if(indexPath.section == 0){
            DJSPart1_TableViewCell *cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellL" forIndexPath:indexPath];
            if (newDict[@"part1"] != nil) {
                cell.queryLabel.text = newDict[@"part1"][@"query"];
                cell.phoneticLabel.text = [NSString stringWithFormat:@"   /%@/    ",newDict[@"part1"][@"phonetic"]];
                cell.translationLabel.text = newDict[@"part1"][@"translation"];
                cell.exam_typeLabel.text = newDict[@"part1"][@"exam_type"];
                cell.explainsLabel.text = newDict[@"part1"][@"explains"];
                cell.delegate = self;
                [cell.collectionButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"collection%i.png",haveCollection]] forState:UIControlStateNormal];
            }
            return cell;
        }else{
            DJSPart2_TableViewCell *cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellM" forIndexPath:indexPath];
            cell.webclick = ^(UIButton *webButtonTest) {
                [self buttonClick:webButtonTest];
            };
            return cell;
        }
    }
}
-(void)buttonClick:(UIButton *)button{
    if (button.tag == 119) {//webView降下去
        [UIView animateWithDuration:0.4 animations:^{
            self->webView.frame = CGRectMake(self.view.frame.size.width, 0, 0, self.view.frame.size.height);
        }];
    }else if (button.tag == 610){//web网络加载
        NSString *string = newDict[@"part2"][@"webdict"];
        [UIView animateWithDuration:0.5 animations:^{
            self->webView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20);
            [self->webView.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
        }];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2019) {
        return (self.view.frame.size.height * 0.155) ;
    }else{
        if (heightArray.count) {
            return [heightArray[indexPath.section] floatValue];
        }else{
            return 0.1;
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 101) {
        return 2;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 2019) {
        return mainCellArray.count;
    }
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView.tag == 2019 && mainCellArray.count) {
        UIView *view = [[UIView alloc]init];
        UIButton *button = [[UIButton alloc]init];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(10);
            make.bottom.equalTo(view.mas_bottom);
            make.centerX.equalTo(view.mas_centerX);
            make.width.equalTo(@150);
        }];
        button.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        [button setTitle:@"清空历史" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:23];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        return view;
    }
    return [[UIView alloc]init];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView.tag == 2019) {
        return 60;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(void)allDataFromModel:(NSNotification *)notification{
    simpleDic = notification.userInfo;
    DJSYSegleHand *seg = [DJSYSegleHand sharedSegleHandle];
    if ([seg searchMainCellTable:simpleDic]) {
        [seg insertIntoMainCell:simpleDic];
    }
    mainCellArray = [seg getMainCellTable];
    [mainView.tableView reloadData];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"postSimpleDict"]) {
        id newData = [change objectForKey:NSKeyValueChangeNewKey];
        newDict = newData;
        //        NSLog(@"newDict --- %@",newDict);
        NSString *error = [[NSString alloc]init];
        error = newData[@"error"];
        if (error.length) {
            [alert show];//加警示框//不弹出之前的view
        }else{
            [self moveViewUp];
            heightArray = [NSMutableArray array];
            [heightArray addObject:newDict[@"part1"][@"part1"]];
            [heightArray addObject:newDict[@"part1"][@"part2"]];
            
            NSArray *array = [NSArray array];
            array = newDict[@"part2"][@"web"];
            NSDictionary *dic = @{@"num":array};
            [[NSNotificationCenter defaultCenter]postNotificationName:@"numberofLabel" object:nil userInfo:dic];
            [moveView.longTableView reloadData];
        }
    }else if ([keyPath isEqualToString:@"estimatedProgress"]){
        if (object == webView.wkWebView) {
            webView.progressView.alpha = 1.0f;
            CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey]doubleValue];
            [webView.progressView setProgress:newProgress animated:YES];
            if (newProgress >= 1.0f) {
                [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self->webView.progressView.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    [self->webView.progressView setProgress:0 animated:NO];
                }];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}
-(BOOL)hasChinese:(NSString *)string{//1位英->中，0位中->英
    int a = [string characterAtIndex:string.length - 1];
    if (a > 0x4e00 && a < 0x9fff) {
        return NO;
    }
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2019) {
        NSString *string = mainCellArray[indexPath.row][@"query"];
        BOOL hasChinese = [self hasChinese:string];
        postNotifiWithModel = 0;
        mainView.searchBar.text = string;
        [model requestTranslation:hasChinese Text:string showTheView:1];
        DJSYSegleHand *seg = [DJSYSegleHand sharedSegleHandle];
        haveCollection = [seg searchMoveCollTable:string];
        [self moveViewUp];
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *string =[UIApplication sharedApplication].delegate.window.textInputMode.primaryLanguage;
    if ([string isEqualToString:@"zh-Hans"]) {
        translation = 0;
    }else if ([string isEqualToString:@"en-US"]){
        translation = 1;
    } //zh-Hans//en-US
    NSLog(@"searchText---%@ , %lu",searchText,(unsigned long)searchText.length);
    if (searchText.length != 0) {
        postNotifiWithModel = 1;
        [self->model requestTranslation:translation Text:searchText showTheView:1];
        DJSYSegleHand *seg = [DJSYSegleHand sharedSegleHandle];
        haveCollection = [seg searchMoveCollTable:searchText];
        //        [self moveViewUp];
    }else{
        [self moveViewDown];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)moveViewUp{
    if (moveUpDown) {
        [UIView animateWithDuration:0.5 animations:^{
            self->moveView.frame = CGRectMake(0, 50 + 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - (50 + 64));
        } completion:^(BOOL finished) {
            self->moveUpDown = 0;
        }];
    }
}
-(void)moveViewDown{
    if (moveUpDown == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self->moveView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0);
            self->mainView.searchBar.text = @"";
        } completion:^(BOOL finished) {
            self->moveUpDown = 1;
            [self.view endEditing:YES];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    [webView.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self->model removeObserver:self forKeyPath:@"postSimpleDict" context:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{//会在左滑前调用
    NSInteger section = indexPath.section;
    if (@available(iOS 11.0, *)) {
        //        NSLog(@"是iOS11");
        for (UIView *subView in mainView.tableView.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                subView.backgroundColor = [UIColor clearColor];
                for (UIView *sonView in subView.subviews) {
                    if ([sonView isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")] && sonView.frame.size.height > 73) {
                        CGRect cRect = sonView.frame;
                        cRect.origin.y = sonView.frame.origin.y + 10;
                        cRect.size.height = sonView.frame.size.height - 20;
                        sonView.frame = cRect;
                    }
                }
            }
            if (subView.subviews.count == 1 && section == 0) {//表示只有一个按钮
                UIButton *deleteButton = subView.subviews[0];
                [deleteButton setBackgroundColor:[UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f]];
                deleteButton.titleLabel.font = [UIFont systemFontOfSize:23];
                deleteButton.layer.masksToBounds = YES;
                deleteButton.layer.cornerRadius = 15;
                [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2019) {
        return YES;
    }
    return NO;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2019) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DJSYSegleHand *seg = [DJSYSegleHand sharedSegleHandle];
        [seg deleteMainCellTable: mainCellArray[indexPath.row]];
        [mainCellArray removeObjectAtIndex:indexPath.row];
        [mainView.tableView reloadData];
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除呐";
}
-(void)clickTest:(NSString *)tag{
    DJSYSegleHand *seg = [DJSYSegleHand sharedSegleHandle];
    if (haveCollection) {
        [seg insertIntoMoveColl:newDict[@"part1"]];
    }else{
        [seg deleteMoveCollTable:newDict[@"part1"]];
    }
    haveCollection = !haveCollection;
    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:0];
    [moveView.longTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end

