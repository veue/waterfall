//
//  RootViewController.m
//  UICollectionView实现瀑布流
//
//  Created by yyp on 14-9-13.
//  Copyright (c) 2014年 ___Vampire___. All rights reserved.
//

#import "RootViewController.h"
#import "ImageModel.h"
#import "Mylayout.h"
#import "MyCell.h"
@interface RootViewController ()
{
    NSMutableArray* _dataArray;
    UICollectionView* _collectionView;
    NSMutableData* _data;
}
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _data=[[NSMutableData alloc]init];
    _dataArray=[[NSMutableArray alloc]init];
//    for (int i=0; i<40; i++)
//    {
//        ImageModel* model=[[ImageModel alloc]init];
//        model.height=(arc4random()%300)+50;
//        [_dataArray addObject:model];
//    }
    
    Mylayout * layout=[[Mylayout alloc]init];
    layout.images=_dataArray;
    _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate= self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor whiteColor];
    //传入一个cell类，由collectionview在需要的时候创建
    [_collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:_collectionView];
    
    
    [self loadData];
}
-(void)loadData
{
    NSURLConnection* conn=[[NSURLConnection alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://i.snssdk.com/gallery/1/top/?tag=ppmm&offset=1&count=30"]] delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id res=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary* dic=(NSDictionary*)res;
    NSArray* arr=dic[@"data"];
    for (NSDictionary* d in arr)
    {
        ImageModel* model=[[ImageModel alloc]init];
        model.height=[d[@"image_height"] doubleValue];
        model.width=[d[@"image_width"] doubleValue];
        model.imageUrl=d[@"middle_url"];
        [_dataArray addObject:model];
    }
    
    
      dispatch_apply(arr.count, dispatch_get_global_queue(0, 0), ^(size_t n) {
          ImageModel* model=_dataArray[n];
          model.cellHeight=140.0*model.height/model.width+20;
          
          
          
      });
    
    [_collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    
    [cell fillData:_dataArray[indexPath.row]];
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
