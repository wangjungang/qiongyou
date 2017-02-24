//
//  hotTableCell.m
//  QiongTreval
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "hotTableCell.h"
#import "hotConllectionCell.h"
#import "HotCountryData.h"
@interface hotTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UILabel * topLab;
@property (nonatomic,strong)UILabel * buttomLb;
@end

@implementation hotTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier With:(NSMutableArray *)array{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _dataArray = array.mutableCopy;
        
        if (_dataArray) {
            [self setup];
        }
        
    }
    return self;
}

- (void)setZhouname:(NSString *)zhouname{
    
    _zhouname = zhouname;
    self.topLab.text = [NSString stringWithFormat:@"%@热门目的地",zhouname];
    self.buttomLb.text = [NSString stringWithFormat:@"%@其他目的地",zhouname];
}

- (void)setup{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, Screen_Width-30, 20)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:label];
    self.topLab = label;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((Screen_Width-40)/2, 240);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame)+15, Screen_Width-30, _dataArray.count>1?_dataArray.count/2*250:_dataArray.count%2*250) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = NO;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"hotConllectionCell" bundle:nil] forCellWithReuseIdentifier:@"hotConllectionCell"];
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
    
    UILabel * buttomLb = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.collectionView.frame)+15, 200, 20)];
    buttomLb.textColor = [UIColor blackColor];
    buttomLb.textAlignment = NSTextAlignmentLeft;
    buttomLb.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:buttomLb];
    self.buttomLb = buttomLb;
    
    UILabel * rightLb = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-15-80, CGRectGetMaxY(self.collectionView.frame)+15, 80, 20)];
    rightLb.textColor = [UIColor lightGrayColor];
    rightLb.textAlignment = NSTextAlignmentRight;
    rightLb.font = [UIFont systemFontOfSize:11];
    rightLb.text = @"拼音首字母排序";
    [self.contentView addSubview:rightLb];
    
    if (_dataArray.count == 1 ) {
        self.buttomLb.hidden = YES;
        rightLb.hidden = YES;
    }
}

#pragma mark -- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    hotConllectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotConllectionCell" forIndexPath:indexPath];
    HotCountryData * data = _dataArray[indexPath.row];
    cell.data = data;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
     HotCountryData * data = _dataArray[indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewCellSelectedWith:)]) {
        [self.delegate collectionViewCellSelectedWith:data];
    }
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
