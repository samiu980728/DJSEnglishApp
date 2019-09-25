//
//  DJSLoginScreenViewController.m
//  ChatHan
//
//  Created by 萨缪 on 2019/7/30.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSLoginScreenViewController.h"
#import "DJSChatViewController.h"
#import "DJSAllViewController.h"
#import "DJSSentenceViewController.h"
#import "DJSDailyyPushhViewController.h"
#import "DJSChatPeopleViewController.h"
#import <AFNetworking.h>

@interface DJSLoginScreenViewController ()

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILabel * passWordLabel;

@property (nonatomic, strong) UITextField * nameTextView;

@property (nonatomic, strong) UITextField * passWordTextView;

@property (nonatomic, strong) UIButton * signUpButton;

@property (nonatomic, strong) UIButton * registerAccountButton;

@property (nonatomic, strong) UIButton * forgetPassWordButton;

@property (nonatomic, strong) UIButton * changPassWordButton;

@property (nonatomic, strong) UIButton * signInButton;

@property (nonatomic, copy) NSString * tokenString;

@property (nonatomic, copy) NSString * statusString;

@property (nonatomic, assign) __block BOOL ok;


@end

@implementation DJSLoginScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人账户";
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(100, 100, 100, 30);
    self.nameLabel.text = @"用户名";
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.nameLabel];
    
    self.passWordLabel = [[UILabel alloc] init];
    self.passWordLabel.frame = CGRectMake(100, 160, 100, 30);
    self.passWordLabel.font = [UIFont systemFontOfSize:20];
    self.passWordLabel.text = @"密码";
    [self.view addSubview:self.passWordLabel];
    
    self.nameTextView = [[UITextField alloc] init];
    self.nameTextView.frame = CGRectMake(210, 100, 200, 30);
    self.nameTextView.placeholder = @"请输入用户名";
    [self.view addSubview:self.nameTextView];
    
    self.passWordTextView = [[UITextField alloc] init];
    self.passWordTextView.frame = CGRectMake(210, 160, 200, 30);
    self.passWordTextView.placeholder = @"请输入密码";
    [self.view addSubview:self.passWordTextView];
    
    self.signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signInButton.frame = CGRectMake(100, 200, 100, 30);
    [self.signInButton setTitle:@"登录" forState:UIControlStateNormal];
    self.signInButton.backgroundColor = [UIColor blackColor];
    //    [self.signInButton addTarget:self action:@selector(directSignUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.signInButton addTarget:self action:@selector(pressSignInButtonForAFNetworking:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signInButton];
    
    self.signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signUpButton.frame = CGRectMake(300, 200, 100, 30);
    [self.signUpButton setTitle:@"注册" forState:UIControlStateNormal];
    self.signUpButton.backgroundColor = [UIColor blackColor];
    [self.signUpButton addTarget:self action:@selector(pressSignUpButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpButton];
    
    self.changPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changPassWordButton.frame = CGRectMake(100, 250, 100, 30);
    [self.changPassWordButton setTitle:@"修改密码" forState:UIControlStateNormal];
    self.changPassWordButton.backgroundColor = [UIColor blackColor];
    [self.changPassWordButton addTarget:self action:@selector(pressChangePassWordButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changPassWordButton];
    
    self.forgetPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPassWordButton.frame = CGRectMake(300, 250, 100, 30);
    [self.forgetPassWordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.forgetPassWordButton.backgroundColor = [UIColor blackColor];
    [self.forgetPassWordButton addTarget:self action:@selector(pressForgetPassWordButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPassWordButton];
}

//AFNetworking
- (void)pressSignInButtonForAFNetworking:(UIButton *)button
{
    NSURL * url = [NSURL URLWithString:@"http://www.zhangshuo.fun/user/login.do"];
    NSString * urlStr = @"http://www.zhangshuo.fun/user/login.do";
    NSString * userNameStr = [NSString stringWithFormat:@"%@",self.nameTextView.text];
    NSString * passWordStr = [NSString stringWithFormat:@"%@",self.passWordTextView.text];
    NSDictionary * userDict = [[NSDictionary alloc] initWithObjects:@[userNameStr,passWordStr] forKeys:@[@"phoneNumber",@"password"]];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager POST:urlStr parameters:userDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        self.statusString = responseObject[@"status"];
        self.ok = [[NSString stringWithFormat:@"%@",self.statusString] isEqualToString:@"0"];
        self.tokenString = responseObject[@"data"][@"token"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"_statusString = %@",_statusString);
        if (self.ok) {
            //把这些加到登录时间按钮按下后的点击事件中去
            UITabBarController * tabBarController = [[UITabBarController alloc] init];
            DJSChatViewController * viewController = [[DJSChatViewController alloc] init];
            viewController.tabBarItem.image = [[UIImage imageNamed:@"voice.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:viewController];
            
            DJSAllViewController * kangViewController = [[DJSAllViewController alloc] init];
            kangViewController.tabBarItem.image = [[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:kangViewController];
            
            DJSSentenceViewController * sentenceViewController = [[DJSSentenceViewController alloc] init];
            sentenceViewController.tabBarItem.image = [[UIImage imageNamed:@"collection1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:sentenceViewController];
            
            DJSDailyyPushhViewController * dailyPushViewController = [[DJSDailyyPushhViewController alloc] init];
            dailyPushViewController.tabBarItem.image = [[UIImage imageNamed:@"1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:dailyPushViewController];
            
            DJSChatPeopleViewController * chatViewController = [[DJSChatPeopleViewController alloc] init];
            chatViewController.tabBarItem.image = [[UIImage imageNamed:@"1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UINavigationController * nav0 = [[UINavigationController alloc] initWithRootViewController:chatViewController];
            
            
            NSMutableArray * controllerArray = [NSMutableArray arrayWithObjects:nav4,nav3,nav2,nav0,nil];
            tabBarController.viewControllers = controllerArray;
            
            DJSChatPeopleViewController * homeSelfController = [[DJSChatPeopleViewController alloc] init];
            homeSelfController.tokenS = self.tokenString;
            //            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:homeSelfController];
            //block的错误用法
            if (self.submitCallBackBlock) {
                self.submitCallBackBlock(_tokenString);
            }
            
            [self presentViewController:tabBarController animated:YES completion:nil];
        }
    });
}

- (NSString *)paramStringFromParams:(NSDictionary *)params
{
    NSMutableString * returnValueStr = [[NSMutableString alloc] initWithCapacity:0];
    NSArray * paramsAllKeys = [params allKeys];
    for (int i = 0; i < paramsAllKeys.count; i++) {
        [returnValueStr appendFormat:@"%@=%@",[paramsAllKeys objectAtIndex:i],[self encodeURIComponent:[params objectForKey:[paramsAllKeys objectAtIndex:i]]]];
        if (i < paramsAllKeys.count) {
            [returnValueStr appendString:@"&"];
        }
    }
    return returnValueStr;
}

-(NSString*)encodeURIComponent:(NSString*)str{
    
        return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)str, NULL, (__bridge CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
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
