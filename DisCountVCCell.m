//
//  DisCountVCCell.m
//  QiongTreval
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "DisCountVCCell.h"
#import "Hotbutton.h"
#import "discoutnSubCell.h"
#import "hot_areaData.h"
#import "Discount_topicData.h"
#import "ButtonView.h"
#define btnWith (Screen_Width -60)/4
#define btnHeight (Screen_Width -60)/4
@interface DisCountVCCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIImageView * topBaseimageV;
@property (nonatomic,strong)UIView * baseView;
@property (nonatomic,strong)NSMutableArray * btnArray;
@property (nonatomic,strong)NSMutableArray * listArray;
@property (nonatomic,strong)ButtonView * buttonView;
@property (nonatomic,strong)UILabel * titleLb;
@property (nonatomic,strong)UIButton * specialButton;
@property (nonatomic,strong)NSMutableArray * topicArray;
@end
@implementation DisCountVCCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 100+btnHeight+btnHeight*2+30)];//有大图360 没有325
    baseView.userInteractionEnabled = YES;
    baseView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseView];
    
    UILabel * titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, Screen_Width, 20)];
    titleLb.backgroundColor = [UIColor whiteColor];
    titleLb.centerX = baseView.centerX;
    titleLb.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    titleLb.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:titleLb];
    self.titleLb = titleLb;
    
    
    UIImageView * topBaseimageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(titleLb.frame)+15, Screen_Width-24, 100)];
    topBaseimageV.layer.cornerRadius = 3;
    topBaseimageV.layer.masksToBounds = YES;
    [baseView addSubview:topBaseimageV];
    self.topBaseimageV = topBaseimageV;
    
    ButtonView * buttonView = [[ButtonView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(titleLb.frame)+15 , btnWith, btnHeight)];
    [baseView addSubview:buttonView];
    self.buttonView = buttonView;
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.buttonView.frame), Screen_Width, btnHeight *2+35) style:UITableViewStylePlain];
    tableView.bounces = NO;
    tableView.scrollEnabled = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate =self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"discoutnSubCell" bundle:nil] forCellReuseIdentifier:@"discoutnSubCell"];
    [baseView addSubview:tableView];
    self.tableView = tableView;
    
    UIButton * sepcial = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), Screen_Width, 45)];
    [sepcial setTitle:@"查看完整专题>" forState:UIControlStateNormal];
    sepcial.titleLabel.font = [UIFont systemFontOfSize:13];
    sepcial.titleLabel.textAlignment = NSTextAlignmentCenter;
    [sepcial setTitleColor:RGB(34, 169, 118) forState:UIControlStateNormal];
    [sepcial addTarget:self action:@selector(sepicalButtn:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:sepcial];
    self.specialButton = sepcial;
    
    self.baseView = baseView;
    self.baseView.height = 50+self.tableView.height+btnHeight+45;
}

- (void)setTopicModel:(Discount_topicModel *)topicModel{
    
    _topicModel = topicModel;
    _topicArray = [NSMutableArray arrayWithArray:topicModel.list];
    [self.topBaseimageV sd_setImageWithURL:[NSURL URLWithString:topicModel.topic[@"photo"]] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.titleLb.text = topicModel.topic[@"title"];
    
    [self.tableView reloadData];
}

- (void)setModel:(hot_areaModel *)model{
    
    _model = model;
    if ([model.type isEqualToString:@"gat"]) {
        self.titleLb.text = @"港澳台";
    }
    else if ([model.type isEqualToString:@"dny"]){
        self.titleLb.text = @"东南亚";
    }else if([model.type isEqualToString:@"om"]){
        self.titleLb.text = @"欧洲美国";
    }else if ([model.type isEqualToString:@"rh"]){
        self.titleLb.text = @"日韩";
    }
    _listArray = [NSMutableArray arrayWithArray:model.list];
    self.buttonView.DataArray = [NSArray arrayWithArray:model.place];
    [self.tableView reloadData];
}

- (void)setIsHiddenButtonView:(BOOL)isHiddenButtonView{
    
    _isHiddenButtonView = isHiddenButtonView;
    self.buttonView.hidden = isHiddenButtonView;
    self.topBaseimageV.hidden = !isHiddenButtonView;
    
    self.tableView.y = CGRectGetMaxY(self.topBaseimageV.frame);
    self.tableView.height = btnHeight *3+50;
    self.baseView.height = 50+self.tableView.height+100+45;
    self.specialButton.y = CGRectGetMaxY(self.tableView.frame);
}

- (void)setIsHiddenTopImageView:(BOOL)isHiddenTopImageView{
    
    _isHiddenTopImageView = isHiddenTopImageView;
    self.topBaseimageV.hidden = isHiddenTopImageView;
    self.buttonView.hidden = !isHiddenTopImageView;
    self.tableView.height = btnHeight *2+35;
    self.tableView.y = CGRectGetMaxY(self.buttonView.frame);
    self.baseView.height = 50+self.tableView.height+btnHeight+45;
    self.specialButton.y = CGRectGetMaxY(self.tableView.frame);
}


- (void)sepicalButtn:(UIButton *)btn{
    
    
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.cellcount == SubCellCountTwo) {
        return _listArray.count;
    }else if (self.cellcount == SubCellCountThree){
        return _topicArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    discoutnSubCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discoutnSubCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.cellcount == SubCellCountTwo) {
        hot_areaData * data = _listArray[indexPath.row];
        cell.areadata = data;
    }
    else if (self.cellcount == SubCellCountThree){
        
        Discount_topicData * data = _topicArray[indexPath.row];
        cell.topicData = data;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (Screen_Width -60)/4+15;
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
