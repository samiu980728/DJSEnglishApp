//
//  DJSCardViewCollectionViewCell.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/4/15.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSCardViewCollectionViewCell.h"

@implementation DJSCardViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[DJSEnglishCardImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        self.imageView.image = [UIImage imageNamed:@"i11.png"];
        //        self.mainLabel = [[UILabel alloc] init];
        //        [self addSubview:self.mainLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    //    self.imageView.frame = CGRectMake(0, 0, 360, 600);
}

@end

