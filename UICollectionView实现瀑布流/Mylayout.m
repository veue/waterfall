//
//  Mylayout.m
//  UICollectionView实现瀑布流
//
//  Created by yyp on 14-9-13.
//  Copyright (c) 2014年 ___Vampire___. All rights reserved.
//

#import "Mylayout.h"
#import "ImageModel.h"
@implementation Mylayout


-(CGSize)collectionViewContentSize
{
    float leftHeight=0.0;
    float rightHeight=0.0;
    for (int i=0;i<_images.count;i++)
    {
        if (leftHeight<=rightHeight)
        {
            leftHeight+=[_images[i] cellHeight];
        }else
        {
            rightHeight+=[_images[i] cellHeight];
            
        }
        
    }

    return CGSizeMake(320, leftHeight>rightHeight?leftHeight:rightHeight);
}

//UICollectionViewLayoutAttributes是指第一个cell的属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建一个属性，并指向对应的cell
    UICollectionViewLayoutAttributes* attr=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    float leftHeight=0.0;
    float rightHeight=0.0;
    for (int i=0;i<indexPath.row;i++)
    {
        if (leftHeight<=rightHeight)
        {
            leftHeight+=[_images[i] cellHeight];
        }else
        {
            rightHeight+=[_images[i] cellHeight];
            
        }

    }
    if (leftHeight<=rightHeight)
    {
        attr.center=CGPointMake(80, leftHeight+[_images[indexPath.row] cellHeight]/2);
    }else
    {
        attr.center=CGPointMake(240, rightHeight+[_images[indexPath.row] cellHeight]/2);

    }
    attr.size=CGSizeMake(160, [_images[indexPath.row]cellHeight]);
    return attr;
}
//返回所有cell的属性的数组
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* arr=[[NSMutableArray alloc]init];
    for (int i=0; i<[self.collectionView numberOfItemsInSection:0]; i++)
    {
        NSIndexPath* indexPath=[NSIndexPath indexPathForItem:i inSection:0];
        [arr addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        
        
    }
    return arr;
}



@end
