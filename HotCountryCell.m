//
//  HotCountryCell.m
//  QiongTreval
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "HotCountryCell.h"
#import "HotCountryCVCell.h"

@interface HotCountryCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UILabel * countryName;
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong)UICollectionView * collectionV;
@end

@implementation HotCountryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        
        [self initOrigial];
        
    }
    return  self;
}

- (NSArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)initOrigial{
    
    self.contentView.backgroundColor = RGB(231, 231, 231);
    
    UIView * baseView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 272)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseView];
    
    UILabel * countryName = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 20)];
    countryName.textColor = [UIColor lightGrayColor];
    countryName.font = [UIFont systemFontOfSize:15];
    countryName.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:countryName];
    self.countryName = countryName;
    
    UILabel * allLabel = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-94, 15, 60, 20)];
    allLabel.text = @"查看全部";
    allLabel.textColor = [UIColor darkGrayColor];
    allLabel.font = [UIFont systemFontOfSize:14];
    allLabel.textAlignment = NSTextAlignmentRight;
    [baseView addSubview:allLabel];
    
    UIImageView * youImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allLabel.frame)+2, 17.5, 17, 16)];
    youImage.image = [UIImage imageNamed:@"右右"];
    [baseView addSubview:youImage];
    
    UIView * lineV = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(countryName.frame)+15, Screen_Width-30, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [baseView addSubview:lineV];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((Screen_Width-40)/2, 95);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    UICollectionView * collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lineV.frame)+10, Screen_Width-30, 200) collectionViewLayout:layout];
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.bounces = NO;
    collectionV.showsVerticalScrollIndicator = NO;
    collectionV.showsHorizontalScrollIndicator = NO;
    collectionV.scrollEnabled = NO;
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [collectionV registerNib:[UINib nibWithNibName:@"HotCountryCVCell" bundle:nil] forCellWithReuseIdentifier:@"HotCountryCVCell"];
    [baseView addSubview:collectionV];
    self.collectionV = collectionV;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HotCountryCVCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCountryCVCell" forIndexPath:indexPath];
    if (self.dataArray.count) {
        
        NSDictionary * dic = self.dataArray[indexPath.row];
        [cell.baseImageV sd_setImageWithURL:[NSURL URLWithString:dic[@"photo"]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        cell.CNLabel.text = dic[@"cnname"];
        cell.ENLabel.text = dic[@"enname"];
    }
   
    return cell;
}

- (void)cellLoadData:(DetailSubModel *)model andWithIndex:(NSIndexPath *)indexPath{
    
    self.countryName.text = [NSString stringWithFormat:@"%@城市",model.cnname];
    self.dataArray = [NSArray arrayWithArray:model.hot_city];
 
    [self.collectionV reloadData];
}


@end
