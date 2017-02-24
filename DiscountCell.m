//
//  DiscountCell.m
//  QiongTreval
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "DiscountCell.h"
#import "dissubData.h"
#import "DisCollectionViewCell.h"
@interface DiscountCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UILabel * labelTop;
@property (nonatomic,strong)UIImageView * topBigImageV;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UIButton * allBtn;

@end

@implementation DiscountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
    }
    return self;
}

- (void)setup{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = RGB(225, 225, 225);
    
    UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 640)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseView];
    
    self.labelTop = ({
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, Screen_Width-30, 20)];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"抢特价折扣";
        [baseView addSubview:label];
        label;
    });
    
    self.topBigImageV = ({
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.labelTop.frame)+10, Screen_Width-10, 150)];
        [baseView addSubview:imageView];
        imageView;
    });
    
    self.collectionView = ({
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(Screen_Width/2, 200);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBigImageV.frame), Screen_Width, 200*2) collectionViewLayout:layout];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.bounces = NO;
        collectionView.scrollEnabled  =NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.collectionViewLayout = layout;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerNib:[UINib nibWithNibName:@"DisCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DisCollectionViewCell"];
        [baseView addSubview:collectionView];
        collectionView;
    });
    
    UIView * shuXian = [[UIView alloc]initWithFrame:CGRectMake(Screen_Width/2-0.25, 10, 0.5, self.collectionView.height-10)];
    shuXian.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView addSubview:shuXian];
    
    UIView * heng1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.height/2-0.25, Screen_Width, 0.5)];
    heng1.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView addSubview:heng1];
    
    UIView * heng2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.height-0.25, Screen_Width, 0.5)];
    heng2.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView addSubview:heng2];
    
    _allBtn = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), Screen_Width, 50);
        [btn setTitle:@"查看全部特价折扣>" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:RGB(34, 169, 118) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(allDiscountClick:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn];
        btn;
    });
}

- (void)cellWithdiscountArray:(NSMutableArray *)discountArray anddisSubArray:(NSMutableArray *)disSubArray andIndexPath:(NSIndexPath *)indexPath{
    
    dissubData * data = disSubArray[0];
    [self.topBigImageV sd_setImageWithURL:[NSURL URLWithString:data.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    _dataArray = [discountArray mutableCopy];
    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DisCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DisCollectionViewCell" forIndexPath:indexPath];
    
    cell.disData = _dataArray[indexPath.row];
    
    return cell;
}

- (void)allDiscountClick:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(seemoreDiscount)]) {
        
        [self.delegate seemoreDiscount];
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
