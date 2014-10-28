//
//  ImageModel.h
//  UICollectionView实现瀑布流
//
//  Created by yyp on 14-9-13.
//  Copyright (c) 2014年 ___Vampire___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject


@property(nonatomic,assign)float height;

@property(nonatomic,assign)float width;

@property(nonatomic,copy)NSString* imageUrl;

@property(nonatomic,assign)float cellHeight;


@end
