//
//  DiscountVC.m
//  QiongTreval
//
//  Created by mac on 16/6/30.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "DiscountVC.h"
#import "DiscountModel.h"
#import "dataData.h"
#import "Discount_topicModel.h"
#import "Discount_topicData.h"
#import "DisCountVCCell.h"
#import "hot_areaData.h"
#import "hot_areaPlaceData.h"
#import "hot_goodsData.h"
#import "hot_areaModel.h"
#import "GoodgoosCell.h"
#define btnWith 50
#define btnHeight 50
#define cellBtnH (Screen_Width -60)/4

@interface DiscountVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * topicArray;
@property (nonatomic,strong)NSMutableArray * hot_areaArray;
@property (nonatomic,strong)NSMutableArray * hot_goodsArray;
@property (nonatomic,strong)NSMutableArray * hotGoodArray;
@property (nonatomic,strong)UIView * topView;
@end

@implementation DiscountVC

- (NSMutableArray *)hotGoodArray{
    
    if (!_hotGoodArray) {
        _hotGoodArray = [NSMutableArray array];
    }
    return _hotGoodArray;
}

- (NSMutableArray *)hot_goodsArray{
    
    if (!_hot_goodsArray) {
        _hot_goodsArray = [NSMutableArray array];
    }
    return _hot_goodsArray;
}

- (NSMutableArray *)hot_areaArray{
    
    if (!_hot_areaArray ) {
        _hot_areaArray = [NSMutableArray array];
    }
    return _hot_areaArray;
}

- (NSMutableArray *)topicArray{
    
    if (!_topicArray) {
        _topicArray = [NSMutableArray array];
    }
    return _topicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"机酒自由行",@"机票",@"签证",@"WIFI/电话卡",@"当地游",@"景点门票",@"交通票券",@"包车/接送机"];
    [self setupNav];
    [self setTopView];
    [self creatTableView1];
    self.tableView.tableHeaderView = self.topView;
    
    [self requestTableViewData];
}

- (void)requestTableViewData{
    
    [[AFHTTPSessionManager manager]GET:MoreDisCountUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        DiscountModel * model = [DiscountModel mj_objectWithKeyValues:responseObject];
        dataData * data1 = [dataData mj_objectWithKeyValues:model.data];
        [self.topicArray addObjectsFromArray:data1.discount_topic];
        [self.hot_areaArray addObjectsFromArray:data1.hot_area];
        [self.hot_goodsArray addObjectsFromArray:data1.hot_goods];
        [self.hotGoodArray addObject:self.hot_goodsArray];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"%@",error);
    }];
    
}

- (void)creatTableView1{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[DisCountVCCell class] forCellReuseIdentifier:@"discountareaCell"];
    [tableView registerClass:[GoodgoosCell class] forCellReuseIdentifier:@"GoodgoosCell"];
    [self.view addSubview:tableView];
    self.tableView= tableView;
    
}

- (void)setupNav{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = RGB(6, 173, 114);
    self.navigationItem.hidesBackButton = YES;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 22);
    [button setImage:[UIImage imageNamed:@"baiback.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIView * textV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width-100, 30)];
    textV.userInteractionEnabled =YES;
    textV.backgroundColor = [UIColor whiteColor];
    textV.layer.cornerRadius = 15;
    textV.layer.masksToBounds = YES;
    UILabel * textF = [[UILabel alloc]initWithFrame:CGRectMake(28 ,8 , textV.width - 30, textV.height-16)];
    textF.backgroundColor = [UIColor whiteColor];
    textF.text = @"搜索折扣";
    textF.userInteractionEnabled = YES;
    textF.textColor = [UIColor lightGrayColor];
    textF.textAlignment = NSTextAlignmentLeft;
    textF.font = [UIFont systemFontOfSize:14];
    [textV addSubview:textF];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTextField:)];
    [textF addGestureRecognizer:tap];
    
    UIImageView * imageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"放大镜.png"]];
    imageV.frame = CGRectMake(7, 7, 15 , 15);
    [textV addSubview:imageV];
    
    UIBarButtonItem * textBar = [[UIBarButtonItem alloc]initWithCustomView:textV];
    
    self.navigationItem.leftBarButtonItems = @[bar,textBar];

}

- (void)setTopView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, 230)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    for (int i =0; i<8; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((Screen_Width - btnWith *4)/5+(i%4)*btnWith+(Screen_Width - btnWith *4)/5*(i%4), 33+(i/4)*btnHeight+(i/4)*33, btnWith, btnHeight);
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 25;
        btn.layer.masksToBounds = YES;
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake((Screen_Width - btnWith *4)/5+(i%4)*btnWith+(Screen_Width - btnWith *4)/5*(i%4)-10, 33+(i/4)*btnHeight+(i/4)*33+btnHeight+10, btnWith+20, 20)];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _titleArray[i];
        [view addSubview:label];
    }
    self.topView = view;
}

- (void)btnClick:(UIButton *)btn{
    

}

- (void)tapTextField:(UITapGestureRecognizer *)tap{
    
    NSLog(@"666666666");
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.hot_areaArray.count + self.topicArray.count+self.hotGoodArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DisCountVCCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discountareaCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = RGB(225, 225, 225);
    if (indexPath.row==0 ||indexPath.row == 1||indexPath.row == 2) {//前三个
        
        cell.isHiddenTopImageView = YES;
        cell.cellcount = SubCellCountTwo;
        hot_areaModel * Areamodel = self.hot_areaArray[indexPath.row];
        cell.model = Areamodel;
        
    }else if(indexPath.row==3 ||indexPath.row==4){
        
        cell.isHiddenButtonView = YES;
        cell.cellcount = SubCellCountThree;
        Discount_topicModel * topicModel = self.topicArray[indexPath.row-3];
        cell.topicModel = topicModel;
        
    }else{
        
        GoodgoosCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodgoosCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGB(225, 225, 225);
        cell.dataArray = [NSArray arrayWithArray:self.hotGoodArray[indexPath.row-5]];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0 ||indexPath.row == 1||indexPath.row == 2) {
        return 100+cellBtnH+cellBtnH*2+30+10;
    }
    else if (indexPath.row == 3 || indexPath.row == 4){
       return 50+((Screen_Width -60)/4) *3+45+100+50+10;
    }else{
        
        return 530;
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
