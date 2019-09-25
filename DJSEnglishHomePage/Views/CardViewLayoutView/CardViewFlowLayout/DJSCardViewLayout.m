//
//  DJSCardViewLayout.m
//  DJSEnglishApp
//
//  Created by 萨缪 on 2019/4/15.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSCardViewLayout.h"

@implementation DJSCardViewLayout
{
    CGFloat previousOffset;
    NSIndexPath *mainIndexPath;
    NSIndexPath *movingInIndexPath;
    CGFloat difference;
}

// 系统在准备对item进行布局前会调用这个方法,我们重写这个方法之后可以在方法里面预先设置好需要用到的变量属性
- (void)prepareLayout
{
    [self setupLayout];
    [super prepareLayout];
}

- (void)setupLayout
{
    CGFloat inset  = self.collectionView.bounds.size.width * (6/64.0f);
    inset = floor(inset);
    
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width - (2 *inset), self.collectionView.bounds.size.height * 3/4);
    self.sectionInset = UIEdgeInsetsMake(0,inset, 0,inset);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self applyTransformToLayoutAttributes:attributes];
    
    return attributes;
}

// indicate that we want to redraw as we scroll
//判定为布局需要被无效化并重新计算的时候,布局对象会被询问以提供新的布局。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    //获取UICollectionCell的indexPath 获取当前正在展示的位置
    NSArray *cellIndices = [self.collectionView indexPathsForVisibleItems];
    //    NSInteger item = cellIndices.
    if (cellIndices.count == 0 )
    {
        return attributes;
    }
    //当UICollectionView 无限滑动时用此方法
    else if (cellIndices.count == 1)
    {
        mainIndexPath = cellIndices.firstObject;
        NSLog(@"");
        movingInIndexPath = nil;
    }
    else if(cellIndices.count > 1)
    {
        NSIndexPath *firstIndexPath = cellIndices.firstObject;
        NSLog(@"exPathItem = %ld",(long)firstIndexPath.item);
        NSLog(@"firstIndexPath = %@",firstIndexPath);
        if(firstIndexPath == mainIndexPath)
        {
            movingInIndexPath = cellIndices[1];
        }
        else
        {
            movingInIndexPath = cellIndices.firstObject;
            NSLog(@"movingInIndexPath = %@",movingInIndexPath);
            mainIndexPath = cellIndices[1];
            NSLog(@"mainIndexPath = %@",mainIndexPath);
        }
        
    }
    
    //根据滑动减速停止时的位置计算当前需要居中的页面。
    //偏移量 - 上一个cell的坐标 就是又偏移的坐标
    difference =  self.collectionView.contentOffset.x - previousOffset;
    
    previousOffset = self.collectionView.contentOffset.x;
    
    for (UICollectionViewLayoutAttributes *attribute in attributes)
    {
        [self applyTransformToLayoutAttributes:attribute];
    }
    return  attributes;
}

- (void)applyTransformToLayoutAttributes:(UICollectionViewLayoutAttributes *)attribute
{
    if(attribute.indexPath.section == mainIndexPath.section)
    {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:mainIndexPath];
        attribute.transform3D = [self transformFromView:cell];
        
    }
    else if (attribute.indexPath.section == movingInIndexPath.section)
    {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:movingInIndexPath];
        attribute.transform3D = [self transformFromView:cell];
    }
}

#pragma mark - Transform Related Calculation

- (CATransform3D)transformFromView:(UIView *)view
{
    CGFloat angle = [self angleForView:view];
    CGFloat height = [self heightOffsetForView:view];
    BOOL xAxis = [self xAxisForView:view];
    //最后返回在X轴 Y轴 的 旋转角度
    return [self transformfromAngle:angle height:height xAxis:xAxis];
}

#pragma mark - Logica  恒等于 self.collectionView.bounds.size.width
- (CGFloat)baseOffsetForView:(UIView *)view
{
    UICollectionViewCell *cell = (UICollectionViewCell *)view;
    CGFloat offset =  ([self.collectionView indexPathForCell:cell].section) * self.collectionView.bounds.size.width;
    
    return offset;
}

- (CGFloat)heightOffsetForView:(UIView *)view
{
    CGFloat height;
    CGFloat baseOffsetForCurrentView = [self baseOffsetForView:view ];
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat scrollViewWidth = self.collectionView.bounds.size.width;
    //TODO:make this constant a certain proportion of the collection view
    height = 120 * (currentOffset - baseOffsetForCurrentView)/scrollViewWidth;
    if(height < 0 )
    {
        height = - 1 * height;
    }
    return height;
}

- (CGFloat)angleForView:(UIView *)view
{
    CGFloat baseOffsetForCurrentView = [self baseOffsetForView:view ];
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat scrollViewWidth = self.collectionView.bounds.size.width;
    //偏移量 - width
    CGFloat angle = (currentOffset - baseOffsetForCurrentView)/scrollViewWidth;
    return angle;
}

- (BOOL)xAxisForView:(UIView *)view
{
    CGFloat baseOffsetForCurrentView = [self baseOffsetForView:view ];
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat offset = (currentOffset - baseOffsetForCurrentView);
    if(offset >= 0)
    {
        return YES;
    }
    return NO;
}


//#pragma mark - Transform Related Calculation
//
//- (CATransform3D)transformFromView:(UIView *)view
//{
//    CGFloat angle = [self angleForView:view];
//    CGFloat height = [self heightOffsetForView:view];
//    BOOL xAxis = [self xAxisForView:view];
//    return [self transformfromAngle:angle height:height xAxis:xAxis];
//}

- (CATransform3D)transformfromAngle:(CGFloat)angle height:(CGFloat)height xAxis:(BOOL)axis
{
    //单位矩阵
    CATransform3D t = CATransform3DIdentity;
    t.m34  = 1.0/-500;
    
    //向X轴/Y轴 方向 旋转的角度
    if (axis)
    {
        t = CATransform3DRotate(t,angle, 1, 1, 0);
    }
    else
    {
        t = CATransform3DRotate(t,angle, -1, 1, 0);
    }
    
    return t;
}

@end

