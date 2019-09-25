//
//  DJSReceiveChatViewController.m
//  ChatHan
//
//  Created by 萨缪 on 2019/8/8.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSReceiveChatViewController.h"

@interface DJSReceiveChatViewController ()

@end

@implementation DJSReceiveChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.receiveView = [[DJSReceiveChatView alloc] initWithFrame:self.view.bounds];
//    [self.receiveView initWithTableView];
    [self.view addSubview:self.receiveView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    [self.receiveView bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
