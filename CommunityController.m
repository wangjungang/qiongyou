//
//  CommunityController.m
//  QiongTreval
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "CommunityController.h"
#import "ScroLabel.h"
#import "DiscussCell.h"
#import "PageCell.h"
#import "TravellerCell.h"
@interface CommunityController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UIScrollView * topScrollView;
@property (nonatomic,strong)UIView * yuanView;
@end

@implementation CommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self setScorllNav];
    [self creatCollectionView];
}

- (void)setScorllNav{
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    navView.backgroundColor = RGB(6, 173, 114);
    [self.view addSubview:navView];
    
    UIScrollView * topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(70, 30, Screen_Width-140, 25)];
    topScrollView.backgroundColor = [UIColor clearColor];
    topScrollView.delegate = self;
    topScrollView.scrollEnabled = NO;
    topScrollView.contentSize = CGSizeMake(Screen_Width-140, 25);
    topScrollView.showsVerticalScrollIndicator = NO;
    topScrollView.showsHorizontalScrollIndicator = NO;
    
    [navView addSubview:topScrollView];
    self.topScrollView = topScrollView;
    
    for (int i =0; i<3; i++) {
        
        ScroLabel * label = [[ScroLabel alloc]initWithFrame:CGRectMake(i*(Screen_Width-140)/3, -20, (Screen_Width-140)/3, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:14];
        label.tag = 2000+i;
        switch (i) {
            case 0:
                label.text = @"热议";
                label.textColor = [UIColor whiteColor];
                break;
            case 1:
                label.text = @"进入版面";
                break;
            case 2:
                label.text = @"找旅伴";
                
                break;
            default:
                break;
        }
        
        [topScrollView addSubview:label];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel:)];
        [label addGestureRecognizer:tap];
    }
    
    UIView * yuanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (Screen_Width-140)/3, 5)];
    yuanView.backgroundColor = [UIColor clearColor];
    [topScrollView addSubview:yuanView];
    
    UILabel * yuanLab = [[UILabel alloc]initWithFrame:CGRectMake(yuanView.width/2-2.5, 0, 5, 5)];
    yuanLab.layer.cornerRadius = 2.5;
    yuanLab.layer.masksToBounds = YES;
    yuanLab.backgroundColor = [UIColor whiteColor];
    [yuanView addSubview:yuanLab];
    self.yuanView = yuanView;
}

- (void)tapLabel:(UITapGestureRecognizer *)tap{
    ScroLabel * lab = (ScroLabel *)tap.view;
    CGFloat x = (lab.tag -2000) * Screen_Width;
    CGPoint contentOffset = CGPointMake(x, self.collectionView.contentOffset.y);
    [self.collectionView setContentOffset:contentOffset animated:YES];
    
    for (UIView * view in self.topScrollView.subviews) {
        if (view.tag == 2001 ||view.tag == 2002||view.tag == 2000) {
            ScroLabel * label = (ScroLabel*)view;
            if (self.yuanView.x == label.x) {
                label.scale = 1.0;
            }else{
                label.scale = 0.0;
            }
            
        }
        
    }
    
}
#pragma mark -- ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.width);
    self.yuanView.x = self.yuanView.width * value ;
    
    for (UIView * view in self.topScrollView.subviews) {
        if (view.tag == 2001 ||view.tag == 2002||view.tag == 2000) {
            ScroLabel * label = (ScroLabel*)view;
            if (self.yuanView.x == label.x) {
                label.scale = 1.0;
            }else{
                label.scale = 0.0;
            }

        }
        
    }
   
}

- (void)creatCollectionView{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(Screen_Width, Screen_Height-64-49);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49) collectionViewLayout:layout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.contentSize = CGSizeMake(Screen_Width * 3, Screen_Height-64-49);

    [collectionView registerClass:[DiscussCell class] forCellWithReuseIdentifier:@"DiscussCell"];
    [collectionView registerClass:[PageCell class] forCellWithReuseIdentifier:@"PageCell"];
    [collectionView registerClass:[TravellerCell class] forCellWithReuseIdentifier:@"TravellerCell"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        DiscussCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DiscussCell" forIndexPath:indexPath];
        
        if (![self.childViewControllers containsObject:cell.discuss]) {
            
            [self addChildViewController:cell.discuss];
            
        }
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        PageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PageCell" forIndexPath:indexPath];
        if (![self.childViewControllers containsObject:cell.page]) {
            
            [self addChildViewController:cell.page];
            
        }
        
        return cell;
    }else{
        
        TravellerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TravellerCell" forIndexPath:indexPath];
        if (![self.childViewControllers containsObject:cell.traveller]) {
            
            [self addChildViewController:cell.traveller];
            
        }
        return cell;

    }
  
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
