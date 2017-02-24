//
//  SpecialVC.m
//  QiongTreval
//
//  Created by mac on 16/6/30.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "SpecialVC.h"
#import "SpecialData.h"
#import "SpecialModel.h"
#import "QYGuangGaoVC.h"
@interface SpecialVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)NSInteger page;
@end

@implementation SpecialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _page = 1;
    self.title = @"专题";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 21, 18);
    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self CRNetWork];
    
    self.tableView.mj_footer = [ChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)backButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray*)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)loadMoreData{
    
    _page ++;
    
    NSDictionary * dic = @{@"page":@(_page)};
    
    [[AFHTTPSessionManager manager]GET:SepecialUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        SpecialModel * model = [SpecialModel mj_objectWithKeyValues:responseObject];
        [self.dataArray addObjectsFromArray:model.data];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

    
}

- (void)CRNetWork{
    
    NSDictionary * dic = @{@"page":@(1)};
    
    [[AFHTTPSessionManager manager]GET:SepecialUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        SpecialModel * model = [SpecialModel mj_objectWithKeyValues:responseObject];
        [self.dataArray addObjectsFromArray:model.data];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SpecialCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SpecialCell"];
    }
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, Screen_Width-20, 220)];
    [cell.contentView addSubview:imageView];
    SpecialData * data = self.dataArray[indexPath.row];
    [imageView sd_setImageWithURL:[NSURL URLWithString:data.photo] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecialData * data = self.dataArray[indexPath.row];
    QYGuangGaoVC * vc = [[QYGuangGaoVC alloc]init];
    vc.titleString = data.title;
    vc.urlString = data.url;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
