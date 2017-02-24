//
//  DiscussTableCell.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "DiscussTableCell.h"

@interface DiscussTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView * baseView;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)UIImageView * iconImageView;
@property (nonatomic,strong)UILabel * nameLb;
@property (nonatomic,strong)UILabel * titleLb;
@property (nonatomic,strong)UILabel * fromLb;
@property (nonatomic,strong)UILabel * timeLb;
@property (nonatomic,strong)UILabel * countLb;
@property (nonatomic,strong)UILabel * jinghuaLb;
@property (nonatomic,strong)UILabel * reyiLb;
@property (nonatomic,strong)NSArray * photoArray;
@property (nonatomic,strong)UIImageView * biao;
@property (nonatomic,strong)UIImageView * taolun;
@end

@implementation DiscussTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    
    return  self;
}


- (void)setup{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = RGB(225, 225, 225);
    
    UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseView];
    
    
    UIImageView * iconImage= [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
    iconImage.layer.cornerRadius = 20;
    iconImage.layer.masksToBounds = YES;
    [baseView addSubview:iconImage];
    self.iconImageView = iconImage;
    
    UILabel * nameLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame)+5, 15, 200, 15)];
    nameLb.textColor = [UIColor lightGrayColor];
    nameLb.font = [UIFont systemFontOfSize:11];
    nameLb.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:nameLb];
    self.nameLb = nameLb;
    
    UILabel * titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame)+5, CGRectGetMaxY(nameLb.frame)+10, Screen_Width -80, 40)];
    titleLb.textColor = [UIColor blackColor];
    titleLb.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.numberOfLines = 0;
    [baseView addSubview:titleLb];
    self.titleLb = titleLb;
    
    UILabel * jinghua = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-60, 12, 40, 20)];
    jinghua.backgroundColor = RGB(252, 92, 83);
    jinghua.textColor = [UIColor whiteColor];
    jinghua.font = [UIFont systemFontOfSize:12];
    jinghua.textAlignment = NSTextAlignmentCenter;
    jinghua.text = @"精华";
    jinghua.layer.cornerRadius = 2;
    jinghua.layer.masksToBounds = YES;
    jinghua.hidden = YES;
    [baseView addSubview:jinghua];
    self.jinghuaLb = jinghua;
    
    UILabel * reyi = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-60, 12, 40, 20)];
    reyi.backgroundColor = RGB(253, 172, 9);
    reyi.textColor = [UIColor whiteColor];
    reyi.font = [UIFont systemFontOfSize:12];
    reyi.textAlignment = NSTextAlignmentCenter;
    reyi.text = @"热议";
    reyi.layer.cornerRadius = 2;
    reyi.layer.masksToBounds = YES;
    reyi.hidden = YES;
    [baseView addSubview:reyi];
    self.reyiLb = reyi;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake((Screen_Width -100)/3, (Screen_Width -100)/3);
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame)+5, CGRectGetMaxY(titleLb.frame)+10, Screen_Width-80, (Screen_Width -100)/3) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.scrollEnabled = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cvtabCell"];
    [baseView addSubview:collectionView];
    self.collectionView = collectionView;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(collectionDidselect:)];
    [self.collectionView addGestureRecognizer:tap];
    
    
    UILabel * fromLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame)+5, CGRectGetMaxY(collectionView.frame)+15, 180, 15)];
    fromLb.textColor = RGB(6, 173, 114);
    fromLb.font  =[UIFont systemFontOfSize:11];
    fromLb.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:fromLb];
    self.fromLb = fromLb;
    
    UIImageView * biao = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fromLb.frame)+10, CGRectGetMaxY(collectionView.frame)+15, 15, 15)];
    [biao setImage:[UIImage imageNamed:@"shoubiao.png"]];
    [baseView addSubview:biao];
    self.biao = biao;
    
    UILabel * timeLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(biao.frame)+5, CGRectGetMaxY(collectionView.frame)+15, 50, 15)];
    timeLb.textColor = [UIColor lightGrayColor];
    timeLb.font = [UIFont systemFontOfSize:11];
    timeLb.textAlignment = NSTextAlignmentLeft;
    [baseView addSubview:timeLb];
    self.timeLb = timeLb;
    
    UIImageView * taolun = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLb.frame)+5, CGRectGetMaxY(collectionView.frame)+15, 15, 15)];
    [taolun setImage:[UIImage imageNamed:@"taolun.png"]];
    [baseView addSubview:taolun];
    self.taolun = taolun;
    
    UILabel * sayCountLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(taolun.frame)+5, CGRectGetMaxY(collectionView.frame)+15, 40, 15)];
    sayCountLb.textColor = [UIColor lightGrayColor];
    sayCountLb.textAlignment = NSTextAlignmentLeft;
    sayCountLb.font = [UIFont systemFontOfSize:12];
    [baseView addSubview:sayCountLb];
    self.countLb = sayCountLb;
    self.baseView = baseView;
    
    self.baseView.height = CGRectGetMaxY(sayCountLb.frame)+20;
    
    
}

- (void)setData:(discussData *)data{
    
    _data = data;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.avatar] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.nameLb.text = data.author;
    self.titleLb.text = data.title;
    self.fromLb.text = data.forum;
    self.timeLb.text = data.reply_time;
    self.countLb.text = data.reply_num;
    
    if ([data.is_hot isEqualToString:@"0"]) {
        self.reyiLb.hidden = YES;
    }else{
        self.reyiLb.hidden= NO;
    }
    
    if ([data.is_best isEqualToString:@"0"]) {
        self.jinghuaLb.hidden = YES;
    }else{
        self.jinghuaLb.hidden = NO;
    }
    
    CGSize lbsize = [data.title sizeWithFont:self.titleLb.font constrainedToSize:CGSizeMake(Screen_Width-80, 40) lineBreakMode:NSLineBreakByWordWrapping];
    self.titleLb.height = lbsize.height;
    
    _photoArray = [data.bigpic_arr copy];
    if (_photoArray.count == 0) {
        
        self.collectionView.hidden = YES;
        self.titleLb.height = 40;
        self.fromLb.y = CGRectGetMaxY(self.titleLb.frame)+20;
        self.biao.y = CGRectGetMaxY(self.titleLb.frame)+20;
        self.timeLb.y = CGRectGetMaxY(self.titleLb.frame)+20;
        self.taolun.y = CGRectGetMaxY(self.titleLb.frame)+20;
        self.countLb.y = CGRectGetMaxY(self.titleLb.frame)+20;
        self.baseView.height = CGRectGetMaxY(self.countLb.frame)+15;
        NSLog(@"%f",self.baseView.height);
    }else{
        self.collectionView.hidden = NO;
        self.fromLb.y = CGRectGetMaxY(self.collectionView.frame)+15;
        self.biao.y = CGRectGetMaxY(self.collectionView.frame)+15;
        self.timeLb.y = CGRectGetMaxY(self.collectionView.frame)+15;
        self.taolun.y = CGRectGetMaxY(self.collectionView.frame)+15;
        self.countLb.y = CGRectGetMaxY(self.collectionView.frame)+15;
        self.baseView.height = CGRectGetMaxY(self.countLb.frame)+15;
         [self.collectionView reloadData];
    }

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvtabCell" forIndexPath:indexPath];
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.width, cell.contentView.height)];
    [imageV sd_setImageWithURL:[NSURL URLWithString:_photoArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    [cell.contentView addSubview:imageV];
    return cell;
}

- (void)collectionDidselect:(UITapGestureRecognizer *)tap{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewCellDidselectWith:)]) {
        [self.delegate collectionViewCellDidselectWith:self.data];
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
