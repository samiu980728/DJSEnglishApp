//
//  DJSChatWithPeopleOneOnOneView.m
//  ChatHan
//
//  Created by 萨缪 on 2019/4/21.
//  Copyright © 2019年 lee. All rights reserved.
//

#import "DJSChatWithPeopleOneOnOneView.h"

@implementation DJSChatWithPeopleOneOnOneView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatCircle];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
-(void)creatCircle{
    float View_width = self.frame.size.width;
    float SCREEN_WIDTH = ([UIScreen mainScreen].bounds.size.width);
    
    //创建运动轨迹
    for (int i = 0; i < 3; i++) {
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];//帧动画
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.repeatCount = CGFLOAT_MAX;
        
        float ButtonWidth = 0.0;
        float radiuscale = 0.0;
        CGFloat origin_x = 0.0 ;
        CGFloat origin_y = 0.0;
        CGFloat radiusX = 0.0;
        float beginAng = M_PI;
        float endAng = M_PI;
        NSString *imageName = [NSString new];
        switch (i) {
            case 0:{
                pathAnimation.duration = 30.0;
                ButtonWidth = 40;
                radiuscale = (SCREEN_WIDTH/2.0)/View_width;
                origin_x = View_width/2.0;
                origin_y = SCREEN_WIDTH/2.0/2.0;
                radiusX = View_width/2.0;
                beginAng = M_PI / 6;
                endAng = M_PI/6 +M_PI*2;
                imageName = @"star";
            }
                break;
            case 1:{
                ButtonWidth = 40;
                pathAnimation.duration = 30.0;
                radiuscale = (SCREEN_WIDTH/2.0-50)/(SCREEN_WIDTH-40);
                origin_x = (SCREEN_WIDTH-40)/2+60;
                origin_y = (SCREEN_WIDTH/2-50)/2.0+25;
                radiusX = (SCREEN_WIDTH-40)/2;
                beginAng = M_PI  ;
                endAng = M_PI+M_PI*2;
                imageName = @"star2";
            }
                break;
            case 2:{
                pathAnimation.duration = 30.0;
                ButtonWidth = 40;
                radiuscale = (SCREEN_WIDTH/4.5)/(SCREEN_WIDTH/2);
                origin_x = (SCREEN_WIDTH/2)/2+SCREEN_WIDTH/4+40;
                origin_y = (SCREEN_WIDTH/4.5)/2.0+SCREEN_WIDTH/7;
                radiusX = (SCREEN_WIDTH/2)/2;
                beginAng = M_PI / 2;
                endAng = M_PI/2 +M_PI*2;
                imageName = @"star3";
            }
                break;
            default:
                break;
        }
        CGMutablePathRef ovalfromarc = CGPathCreateMutable();
        //CGAffineTransform实现平移
        //CGAffineTransformMakeScale实现缩放
        //http://www.cnblogs.com/yang-shuai/p/8487390.html
        CGAffineTransform t2 = CGAffineTransformConcat(CGAffineTransformConcat(
                                                                               CGAffineTransformMakeTranslation(-origin_x,-origin_y),
                                                                               CGAffineTransformMakeScale(1, radiuscale)),
                                                       CGAffineTransformMakeTranslation(origin_x, origin_y));
        CGPathAddArc(ovalfromarc, &t2, origin_x, origin_y, radiusX,beginAng,endAng, 0);
        pathAnimation.path = ovalfromarc;
        CGPathRelease(ovalfromarc);
        
        switch (i) {
            case 0:{//最外面
                _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [_centerButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                [_centerButton setTitle:@"已关注" forState:UIControlStateNormal];
                _centerButton.backgroundColor = [UIColor clearColor];
                _centerButton.frame = CGRectMake(0, 0,ButtonWidth, ButtonWidth);
                _centerButton.tag = i;
                
                [_centerButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_centerButton];
                [_centerButton.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
            }
                break;
            case 1:{//中间的
                _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [_middleButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                [_middleButton setTitle:@"已聊天" forState:UIControlStateNormal];
                _middleButton.backgroundColor = [UIColor clearColor];
                _middleButton.frame = CGRectMake(0, 0, ButtonWidth, ButtonWidth);
                _middleButton.tag = i;
                [_middleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_middleButton];
                [_middleButton.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
            }
                break;
            case 2:{//最里面的
                _outButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [_outButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                _outButton.titleLabel.font = [UIFont systemFontOfSize:20];
                [_outButton setTitle:@"随机匹配" forState:UIControlStateNormal];
                _outButton.backgroundColor = [UIColor clearColor];
                _outButton.frame = CGRectMake(0, 0, ButtonWidth, ButtonWidth);
                _outButton.tag = i;
                [_outButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_outButton];
                [_outButton.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
            }
                break;
            default:
                break;
        }
    }
}
-(void)drawRect:(CGRect)rect{
    float SCREEN_WIDTH = ([UIScreen mainScreen].bounds.size.width);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *ccc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/4+40,  SCREEN_WIDTH/7, SCREEN_WIDTH/2, SCREEN_WIDTH/4.5)];
    [[UIColor whiteColor] setStroke];
    [ccc stroke];
    
    UIBezierPath *arc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20+40, 25, SCREEN_WIDTH-40,SCREEN_WIDTH/2-50)];
    [[UIColor whiteColor] setStroke];
    [arc stroke];
    
    UIBezierPath *acc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, SCREEN_WIDTH+80, SCREEN_WIDTH/2)];
    [[UIColor whiteColor] setStroke];
    [acc stroke];
    
    CGContextRestoreGState(context);
}

-(void)buttonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(matchingViewButtonClick:)]) {
        [self.delegate matchingViewButtonClick:button.tag];
    }else{
        NSLog(@"未响应");
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self];
    
    CGPoint buttonPoition1 = [[_centerButton.layer presentationLayer] position];//当前button的位置，是中心点的位置，点击的话不精确，需要有一个范围
    //    NSLog(@"touchPoint:%f,%f----buttonPoint:%f,%f",touchPoint.x,touchPoint.y,buttonPoition1.x,buttonPoition1.y);
    if (touchPoint.x < buttonPoition1.x + 20 && touchPoint.x + 20 > buttonPoition1.x && touchPoint.y < buttonPoition1.y + 20 && touchPoint.y + 20 > buttonPoition1.y) {
        [self buttonClick:_centerButton];
    }
    
    CGPoint buttonPoition2 = [[_middleButton.layer presentationLayer]position];
    //    NSLog(@"touchPoint:%f,%f----buttonPoint:%f,%f",touchPoint.x,touchPoint.y,buttonPoition2.x,buttonPoition2.y);
    if (touchPoint.x < buttonPoition2.x + 20 && touchPoint.x + 20 > buttonPoition2.x && touchPoint.y < buttonPoition2.y + 20 && touchPoint.y + 20 > buttonPoition2.y) {
        [self buttonClick:_middleButton];
    }
    
    CGPoint buttonPoition3 = [[_outButton.layer presentationLayer]position];
    //    NSLog(@"touchPoint:%f,%f----buttonPoint:%f,%f",touchPoint.x,touchPoint.y,buttonPoition3.x,buttonPoition3.y);
    if (touchPoint.x < buttonPoition3.x + 20 && touchPoint.x + 20 > buttonPoition3.x && touchPoint.y < buttonPoition3.y + 20 && touchPoint.y + 20 > buttonPoition3.y) {
        [self buttonClick:_outButton];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
