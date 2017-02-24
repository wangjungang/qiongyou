//
//  PageVC.m
//  QiongTreval
//
//  Created by mac on 16/7/6.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "PageVC.h"
#import "PageModel.h"
#import "dataModel.h"
#import "pageData.h"
#import "groupData.h"
#import "pageTableVCell.h"
@interface PageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSMutableArray * nameArray;
@property (nonatomic,strong)NSMutableArray * listArray;
@property (nonatomic,strong)UITableView * leftTableView;
@property (nonatomic,strong)UIButton * tmpButton;
@end

@implementation PageVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _nameArray = [NSMutableArray array];
    
    [self creatLeftListView];
    [self requestData];
    
    
}

- (void)creatLeftScrolleView{
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 100, Screen_Height-64-49)];
    scrollView.contentSize = CGSizeMake(100, 70*_nameArray.count);
    [self.view addSubview:scrollView];
    
    for (int i =0; i<_nameArray.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 70*i, 100, 70);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(6, 173, 114) forState:UIControlStateSelected];
        [btn setBackgroundImage:[self imageWithColor:RGB(238, 238, 238)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:RGB(255, 255, 255)] forState:UIControlStateSelected];
        [btn setTitle:_nameArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        
        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(0, btn.height-0.5, 100, 0.5);
        layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [btn.layer addSublayer:layer];
        
        [scrollView addSubview:btn];
        if (i==0) {
            btn.selected = YES;
            self.tmpButton = btn;
        }
    }
}

- (void)leftBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if(btn != self.tmpButton){
        self.tmpButton.selected = NO;
        self.tmpButton = btn;
    }
    self.tmpButton.selected = YES;
    
    pageData * pagedata = _dataArray[btn.tag-100];
    if (pagedata.name == _nameArray[btn.tag-100]) {
            _listArray = [NSMutableArray arrayWithArray:pagedata.group];
        }
    [self.leftTableView reloadData];
    
}

- (void)creatLeftListView{
    
    UITableView * tableView= [[UITableView alloc]initWithFrame:CGRectMake(100   , 0, Screen_Width-100, Screen_Height-64-49) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate =self;
    [tableView registerNib:[UINib nibWithNibName:@"pageTableVCell" bundle:nil] forCellReuseIdentifier:@"pageTableVCell"];
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    self.leftTableView = tableView;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listArray.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    pageTableVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pageTableVCell" forIndexPath:indexPath];
    groupData * data = _listArray[indexPath.row];
    cell.page = data;
    
    return cell;
   
}

- (void)requestData{
    
    [[AFHTTPSessionManager manager]GET:@"http://open.qyer.com/qyer/bbs/entry?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.01068475024194&lon=116.4621018119749&oauth_token=73a0d5197ceab969461b6ddb980e573a&page=1&track_app_channel=App%2520Store&track_app_version=6.9.3&track_device_info=iPhone8%2C1&track_deviceid=7931B9E3-0421-4170-821D-958F62A93A33&track_os=ios%25209.3.2&track_user_id=7917461&v=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PageModel * model = [PageModel mj_objectWithKeyValues:responseObject];
        dataModel * dataM = [dataModel mj_objectWithKeyValues:model.data];
        _dataArray = [NSMutableArray arrayWithArray:dataM.forum_list];
        
        for (pageData * data in _dataArray) {
            [_nameArray addObject:data.name];
           
        }
        pageData * data = _dataArray[0];
        _listArray = [NSMutableArray arrayWithArray:data.group];
        
        [self creatLeftScrolleView];
        [self.leftTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"%@",error);
    }];
    
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
