//
//  GoodgoosCell.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "GoodgoosCell.h"
#import "GoosCell.h"
#import "hot_goodsData.h"
@interface GoodgoosCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray * collectionArray;
@property (nonatomic,strong)UICollectionView * collectionView;
@end

@implementation GoodgoosCell

- (NSMutableArray *)collectionArray{
    
    if(!_collectionArray){
        
        _collectionArray = [NSMutableArray array];
    }
    return _collectionArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 520)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    UILabel * titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, Screen_Width, 20)];
    titleLb.backgroundColor = [UIColor whiteColor];
    titleLb.text = @"有好货";
    titleLb.centerX = view.centerX;
    titleLb.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    titleLb.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLb];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 12;
    layout.minimumInteritemSpacing = 12;
    layout.itemSize = CGSizeMake((Screen_Width-36)/2, 150);
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(titleLb.frame)+10, Screen_Width-24, view.height-45) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.bounces = NO;
    collectionView.scrollEnabled = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"GoosCell" bundle:nil] forCellWithReuseIdentifier:@"GoosCell"];
    [view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    self.collectionArray = [dataArray mutableCopy];
    [self.collectionView reloadData];
}

#pragma  mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoosCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoosCell" forIndexPath:indexPath];
    hot_goodsData * data = self.collectionArray[indexPath.row];
    cell.goodData = data;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
