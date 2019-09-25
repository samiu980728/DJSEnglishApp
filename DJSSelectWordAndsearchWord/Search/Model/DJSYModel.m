//
//  YModel.m
//  寒假项目
//
//  Created by 康思婉 on 2019/1/19.
//  Copyright © 2019年 康思婉. All rights reserved.
//

#import "DJSYModel.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"

@implementation DJSYModel

-(void)initWithModel{
    _allDataDic = [[NSDictionary alloc]init];
    _postSimpleDict = [[NSDictionary alloc]init];
    _simpleDic = [[NSDictionary alloc]init];
}
-(void)changeName:(NSDictionary *)dic{
    self.postSimpleDict = dic;
}
-(void)sentence:(NSString *)String{
    self.sentence = String;
    NSLog(@"%@",self.sentence);
}
//request//q:要翻译的文本////from源语言////to目标语言////salt随机数////appKey应用ID////sign签名md5产生//
-(void)requestTranslation:(BOOL)translation Text:(NSString *)textString showTheView:(BOOL)showTheView{
    NSString *appKey = @"21b561135fddf97e";
    NSString *salt = @"2";
    NSString *key = @"JQHkTNdBlnBEDYC5SOGV6ESDibPFaasf";
    NSString *from;
    NSString *to;
    if (translation) {
        from = @"EN";
        to = @"zh-CHS";
    }else{
        from = @"zh-CHS";
        to = @"EN";
    }
    NSString *String = [NSString stringWithFormat:@"%@%@%@%@",appKey,textString,salt,key];
    NSString *sign = [self getMD5HashWithMessage:String];
    NSString *urlString = [NSString stringWithFormat:@"https://openapi.youdao.com/api?q=%@&from=%@&to=%@&appKey=%@&salt=%@&sign=%@",textString,from,to,appKey,salt,sign];
    NSLog(@"------- %@",urlString);
    [self testAFGet:urlString showTheView:showTheView];
}
-(NSString *)getMD5HashWithMessage:(NSString *)message{
    //MD5加密，网络请求需要
    const char *cStr = [message UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,(unsigned)strlen(cStr),result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

-(void)testAFGet:(NSString *)urlString showTheView:(BOOL)showTheView{
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dict = @{@"STORIES":@"wei"};
    [manager GET:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"success--%@--%@--%@",[responseObject class],responseObject,responseObject[@"basic"][@"exam_type"]);
        
        NSString *string = responseObject[@"errorCode"];
        NSLog(@"%@,%i",string,showTheView);
        if ([string isEqualToString:@"0"] && !showTheView) {
            NSString *translation = [[NSString alloc]init];
            if (responseObject[@"translation"] == nil) {
                translation = @"无翻译";
            }else{
                NSMutableArray *transArray = [NSMutableArray array];
                transArray = responseObject[@"translation"];
                for (int i = 0; i < transArray.count; i++) {
                    NSString *string = transArray[i];
                    translation = [translation stringByAppendingString:string];
                    NSLog(@"%@",translation);
                    if (i != transArray.count - 1) {
                        translation = [translation stringByAppendingFormat:@"，"];
                    }
                }
            }
            self->_sentence = translation;//Sentence
            [self sentence:translation];
        }
        
        NSDictionary *basic = [[NSDictionary alloc]init];
        if (![string isEqualToString:@"0"] || [responseObject[@"basic"] isEqual: [NSNull null]]) {
            self->_allDataDic = @{@"error":string};
            if (showTheView) {
                [self changeName:self->_allDataDic];
            }
        }else{
            basic = responseObject[@"basic"];
            
            NSDictionary *basic = [[NSDictionary alloc]init];
            if (responseObject[@"basic"] == [NSNull null]) {
                basic = nil;
            }else{
                basic = responseObject[@"basic"];
            }
            NSString *exam_type = [[NSString alloc]init];
            if (basic[@"exam_type"] == nil) {
                exam_type = @"四级";
            }else{
                NSArray *examArray = [NSArray array];
                examArray = basic[@"exam_type"];
                for (int i = 0; i < examArray.count; i++) {
                    NSString *string = examArray[i];
                    exam_type = [exam_type stringByAppendingString:string];
                    if (i != examArray.count - 1) {
                        exam_type = [exam_type stringByAppendingString:@"/"];
                    }
                }
            }
            
            NSString *phonetic;
            if (basic[@"phonetic"] == nil) {
                phonetic = @"无标准音标";
            }else{phonetic = basic[@"phonetic"];}
            NSMutableArray *us_phonetic = [NSMutableArray array];
            if (basic[@"us-phonetic"] == nil) {
                [us_phonetic addObject:@"无美式音标"];
            }else{us_phonetic = basic[@"us-phonetic"];}
            NSMutableArray *uk_phonetic = [NSMutableArray array];
            if (basic[@"uk-phonetic"] == nil) {
                [uk_phonetic addObject:@"无英式音标"];
            }else{uk_phonetic = basic[@"uk-phonetic"];}
            
            NSString *explains = [[NSString alloc]init];
            if (basic[@"explains"] == nil) {
                explains = @"无基本释义";
            }else{
                NSArray *explainsArray = [NSArray array];
                explainsArray = basic[@"explains"];
                for (int i = 0 ; i < explainsArray.count; i++) {
                    NSString *string = explainsArray[i];
                    explains = [explains stringByAppendingString:string];
                    if (i != explainsArray.count - 1) {
                        explains = [explains stringByAppendingString:@"\n"];
                    }
                }
            }
            
            NSString *query = responseObject[@"query"];
            NSString *translation = [[NSString alloc]init];
            if (responseObject[@"translation"] == nil) {
                translation = @"无翻译";
            }else{
                NSMutableArray *transArray = [NSMutableArray array];
                transArray = responseObject[@"translation"];
                for (int i = 0; i < transArray.count; i++) {
                    NSString *string = transArray[i];
                    translation = [translation stringByAppendingString:string];
                    NSLog(@"%@",translation);
                    if (i != transArray.count - 1) {
                        translation = [translation stringByAppendingFormat:@"，"];
                    }
                }
            }
            
            NSMutableArray *web = [NSMutableArray array];
            if (responseObject[@"web"] == nil) {
                [web addObject:@"无网络释义"];
            }else{
                NSArray *webArray = [NSArray array];
                webArray = responseObject[@"web"];
                for (int i = 0; i < webArray.count; i++) {
                    NSDictionary *dic = [[NSDictionary alloc]init];
                    dic = webArray[i];
                    NSString *string = [[NSString alloc]init];
                    string = [string stringByAppendingString:dic[@"key"]];
                    string = [string stringByAppendingString:@"\n\n"];
                    
                    NSArray *valueArray = [NSArray array];
                    valueArray = dic[@"value"];
                    for (int j = 0 ; j < valueArray.count; j++) {
                        NSString *tString = valueArray[j];
                        string = [string stringByAppendingString:tString];
                        if (j != valueArray.count - 1) {
                            string = [string stringByAppendingString:@"\n"];
                        }
                    }
                    [web addObject:string];
                }
            }
            
            NSString *webdict = responseObject[@"webdict"][@"url"];
            NSString *resString = [webdict substringToIndex:5];
            if ([resString isEqualToString:@"http:"]) {
                webdict = [NSString stringWithFormat:@"https:%@",[webdict substringFromIndex:5]];
            }
            
            //计算cell高度
            NSString *part1String = [[NSString alloc]init];
            part1String = [NSString stringWithFormat:@"%@\n%@%@\n%@\n%@",query,phonetic,translation,exam_type,explains];
            CGFloat part1Height;
            part1Height = [self heightWithCell:part1String];
            
            CGFloat part2Height;
            part2Height = [self heightWithPart2:web];
            
            NSNumber *part1Float = [NSNumber numberWithFloat:part1Height];
            NSNumber *part2Float = [NSNumber numberWithFloat:part2Height];
            
            
            self->_simpleDic = @{@"query":query,@"translation":translation,@"phonetic":phonetic,@"exam_type":exam_type};//tableview显示部分
            
            NSDictionary *part1 = @{@"query":query,@"translation":translation,@"phonetic":phonetic,@"us-phonetic":us_phonetic,@"exam_type":exam_type,@"explains":explains,@"part1":part1Float,@"part2":part2Float};
            NSDictionary *part2 = @{@"web":web,@"webdict":webdict};
            self->_allDataDic = @{@"part1":part1,@"part2":part2};
            if (showTheView) {
                [self changeName:self->_allDataDic];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure--%@",error);
    }];
}
-(void)postAllData{//添加方法，点击cell返回allDataDic，通知或返回值
    [[NSNotificationCenter defaultCenter]postNotificationName:@"allData" object:nil userInfo:_simpleDic];
}
-(CGFloat)heightWithCell:(NSString *)oldString{
    CGFloat height = 0.0;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    label.text = oldString;
    label.font = [UIFont systemFontOfSize:25];
    label.numberOfLines = 0;
    [label sizeToFit];
    height = label.frame.size.height;
    return height + 50;
}
-(CGFloat)heightWithPart2:(NSMutableArray *)array{
    CGFloat height = 0.0;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 60, 0)];
    
    NSString *newString = [[NSString alloc]init];
    for (NSString *string in array) {
        newString = [newString stringByAppendingString:string];
    }
    label.text = newString;
    label.font = [UIFont systemFontOfSize:20];
    label.numberOfLines = 0;
    [label sizeToFit];
    
    height = label.frame.size.height;
    NSInteger num = array.count;
    height = height + 40 + num * 10 + num * 20 + 50;
    return height;
}


@end

