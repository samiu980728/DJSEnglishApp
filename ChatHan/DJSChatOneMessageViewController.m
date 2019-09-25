//
//  DJSChatOneMessageViewController.m
//  ChatHan
//
//  Created by 萨缪 on 2019/9/24.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatOneMessageViewController.h"
#import "DJSChatOneMessageView.h"

@interface DJSChatOneMessageViewController ()

@end

@implementation DJSChatOneMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    DJSChatOneMessageView * messageView = [[DJSChatOneMessageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:messageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
