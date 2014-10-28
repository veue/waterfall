//
//  MyCell.m
//  UICollectionView实现瀑布流
//
//  Created by yyp on 14-9-13.
//  Copyright (c) 2014年 ___Vampire___. All rights reserved.
//

#import "MyCell.h"
#import "UIImageView+WebCache.h"
@implementation MyCell
{
    UIImageView* _view;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self cellConfig];
    }
    return self;
}
-(void)cellConfig
{
    _view=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)];
    [self.contentView addSubview:_view];
    //_view.backgroundColor=[UIColor colorWithRed:(arc4random()%10)*0.1 green:(arc4random()%10)*0.1 blue:(arc4random()%10)*0.1 alpha:1];
    
}


-(void)fillData:(ImageModel *)model
{
    _view.frame=CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20);
    [_view setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        //_view.backgroundColor=[UIColor colorWithRed:(arc4random()%10)*0.1 green:(arc4random()%10)*0.1 blue:(arc4random()%10)*0.1 alpha:1];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
