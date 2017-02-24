//
//  TravellerVC.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "TravellerVC.h"
#import "SiftTravelerView.h"
#import "TravelData.h"
#import "TravelModel.h"
#import "TravelerCell.h"
@interface TravellerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation TravellerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    SiftTravelerView * sift = [[SiftTravelerView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
    [self.view addSubview:sift];
    
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(0, 49.5, Screen_Width, 0.5);
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [sift.layer addSublayer:layer];
    
    CALayer * layer2 = [CALayer layer];
    layer2.frame = CGRectMake(Screen_Width/2, 0, 0.5, 50);
    layer2.backgroundColor = [UIColor lightGrayColor].CGColor;
    [sift.layer addSublayer:layer2];
    
    [self creatTabelView];
    [self requestData];
}

- (void)requestData{
    
    [[AFHTTPSessionManager manager]GET:@"http://open.qyer.com/qyer/company/search_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.01045667982755&lon=116.4627984494008&oauth_token=73a0d5197ceab969461b6ddb980e573a&page=1&track_app_channel=App%2520Store&track_app_version=6.9.3&track_device_info=iPhone8%2C1&track_deviceid=7931B9E3-0421-4170-821D-958F62A93A33&track_os=ios%25209.3.2&track_user_id=7917461&v=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        TravelModel * model = [TravelModel mj_objectWithKeyValues:responseObject];
        
        _dataArray = [NSMutableArray arrayWithArray:model.data];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}

- (void)creatTabelView{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, Screen_Width, Screen_Height-64-50-49) style:UITableViewStylePlain];
    tableView.backgroundColor = RGB(242, 242, 242);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"TravelerCell" bundle:nil] forCellReuseIdentifier:@"TravelerCell"];
    [self.view addSubview:tableView];
    self.tableView  = tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TravelerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TravelerCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = RGB(242, 242, 242);
    TravelData * data = _dataArray[indexPath.row];
    cell.data = data;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
