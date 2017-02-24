//
//  DiscussVC.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "DiscussVC.h"
#import "discussData.h"
#import "dicussModel.h"
#import "hotWebVC.h"
#import "DiscussTableCell.h"
#define listUrl @"http://open.qyer.com/qyer/community/hotbbs/index?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&lat=40.01050875736381&lon=116.4625973977446&oauth_token=73a0d5197ceab969461b6ddb980e573a&track_app_channel=App%2520Store&track_app_version=6.9.3&track_device_info=iPhone8%2C1&track_deviceid=7931B9E3-0421-4170-821D-958F62A93A33&track_os=ios%25209.3.2&track_user_id=7917461&v=1"
@interface DiscussVC ()<UITableViewDelegate,UITableViewDataSource,DiscussCellDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger page;
@end

@implementation DiscussVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initListView];
    [self requestListViewData];
    
    self.tableView.mj_header = [ChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestListViewData)];
    self.tableView.mj_footer = [ChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _page = 1;
}

- (void)loadMoreData{
    
    _page ++ ;
    
    NSDictionary * dict = @{@"page":@(_page)};
    
    [[AFHTTPSessionManager manager]GET:listUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dicussModel * model = [dicussModel mj_objectWithKeyValues:responseObject];
        [_dataArray addObjectsFromArray:model.data];;
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

    
}

- (void)requestListViewData{
    
    NSDictionary * dict = @{@"page":@(1)};
    
    [[AFHTTPSessionManager manager]GET:listUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dicussModel * model = [dicussModel mj_objectWithKeyValues:responseObject];
        _dataArray = [NSMutableArray arrayWithArray:model.data];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"%@",error);
    }];
}

- (void)initListView{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[DiscussTableCell class] forCellReuseIdentifier:@"DiscussTableCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     discussData *data = _dataArray[indexPath.row];
    if (data.bigpic_arr.count == 0) {
        
        return 140;
    }
    
    return 235;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _dataArray.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscussTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DiscussTableCell" forIndexPath:indexPath];
    cell.delegate =self;
    discussData *data = _dataArray[indexPath.row];
    cell.data = data;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    discussData *data = _dataArray[indexPath.row];
    hotWebVC * web = [[hotWebVC alloc]init];
    web.disData = data;
    web.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:web animated:YES];

}
#pragma mark - DiscussCelleDelegate
- (void)collectionViewCellDidselectWith:(discussData *)data{
    
    hotWebVC * web = [[hotWebVC alloc]init];
    web.disData = data;
    web.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:web animated:YES];
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
