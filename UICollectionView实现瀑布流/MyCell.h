//
//  MyCell.h
//  UICollectionView实现瀑布流
//
//  Created by yyp on 14-9-13.
//  Copyright (c) 2014年 ___Vampire___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
@interface MyCell : UICollectionViewCell


-(void)fillData:(ImageModel*)model;

@end
