//
//  DestinationController.m
//  QiongTreval
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "DestinationController.h"
#import "MDDModel.h"
#import "MDDData.h"
#import "YuanView.h"
#import "hotTableCell.h"
#import "countryCell.h"
#import "CountryVC.h"
@interface DestinationController ()<UITableViewDelegate,UITableViewDataSource,hotTabCellDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * hotCountry;
@property (nonatomic,strong)NSArray * ZhouArray;
@property (nonatomic,strong)NSMutableArray * country;
@property (nonatomic,strong)UIButton * temButton;
@property (nonatomic,strong)UIImageView * imageView;
@end

@implementation DestinationController

- (NSMutableArray *)country{
    
    if (_country) {
        _country = [NSMutableArray array];
    }
    return _country;
}

- (NSMutableArray *)hotCountry{
    
    if (!_hotCountry) {
        _hotCountry = [NSMutableArray array];
    }
    return _hotCountry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = RGB(6, 173, 114);
    
    [self setListView];
    [self setTableHeaderView];
    [self requestListData];
    
    NSLog(@"%@",_ZhouArray);
}

- (void)requestListData{
    
    [[AFHTTPSessionManager manager]GET:@"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.01059740820109&lon=116.4622249708943&oauth_token=73a0d5197ceab969461b6ddb980e573a&page=1&track_app_channel=App%2520Store&track_app_version=6.9.3&track_device_info=iPhone8%2C1&track_deviceid=7931B9E3-0421-4170-821D-958F62A93A33&track_os=ios%25209.3.2&track_user_id=7917461&v=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MDDModel * model = [MDDModel mj_objectWithKeyValues:responseObject];
        _ZhouArray = [NSArray arrayWithArray:model.data];
        [self shujuFenLei];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        
    }];
    
}

- (void)shujuFenLei{
    
    for (MDDData* mmdData in _ZhouArray) {
        if ([mmdData.cnname isEqualToString:@"亚洲"]) {
            _hotCountry = [mmdData.hot_country mutableCopy];
            _country = [mmdData.country mutableCopy];
            
        }
    }
    [_tableView reloadData];
}

- (void)setTableHeaderView{
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 250)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:headerView.bounds];
    imageView.image = [UIImage imageNamed:@"map.png"];
    [headerView addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    [imageView addGestureRecognizer:tap];
    self.imageView = imageView;
    
    for (int i =0; i<7; i++) {
        
        YuanView * view = [[YuanView alloc]init];
        view.layer.cornerRadius = 3;
        view.layer.masksToBounds = YES;
        UIButton * zhouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [zhouBtn setBackgroundImage:[UIImage imageNamed:@"zhou1"] forState:UIControlStateNormal];
        [zhouBtn setBackgroundImage:[UIImage imageNamed:@"zhou2"] forState:UIControlStateSelected];
        [zhouBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [zhouBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        zhouBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        zhouBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        zhouBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 5, 5);
        zhouBtn.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        zhouBtn.layer.shadowOffset = CGSizeMake(1, 1);
        zhouBtn.layer.shadowOpacity = 0.8;
        zhouBtn.layer.shadowRadius = 2;
        zhouBtn.width = 50;
        zhouBtn.height = 40;
        zhouBtn.tag = 1000+i;
        [zhouBtn addTarget:self action:@selector(zhouButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (i) {
            case 0://亚洲
                view.frame = CGRectMake(300, 75, 6, 6);
                [imageView addSubview:view];
                [zhouBtn setTitle:@"亚洲" forState:UIControlStateNormal];
                zhouBtn.selected = YES;
                self.temButton = zhouBtn;
                zhouBtn.centerX = view.centerX;
                zhouBtn.centerY = view.centerY - 25;
                [imageView addSubview:zhouBtn];
             
                break;
            case 1:
                //欧洲
                view.frame = CGRectMake(215, 60, 6, 6);
                [imageView addSubview:view];
                [zhouBtn setTitle:@"欧洲" forState:UIControlStateNormal];
                zhouBtn.centerX = view.centerX;
                zhouBtn.centerY = view.centerY - 25;
                [imageView addSubview:zhouBtn];
                break;
            case 2:
                //北美洲
                view.frame = CGRectMake(60, 50, 6, 6);
                [imageView addSubview:view];
                [zhouBtn setTitle:@"北美洲" forState:UIControlStateNormal];
                zhouBtn.centerX = view.centerX;
                zhouBtn.centerY = view.centerY - 25;
                [imageView addSubview:zhouBtn];
                break;
            case 3:
                //南美洲
                view.frame = CGRectMake(115, 160, 6, 6);
                [imageView addSubview:view];
                [zhouBtn setTitle:@"南美洲" forState:UIControlStateNormal];
                zhouBtn.centerX = view.centerX;
                zhouBtn.centerY = view.centerY - 25;
                [imageView addSubview:zhouBtn];
                break;
            case 4:
                //大洋洲
                view.frame = CGRectMake(323, 160, 6, 6);
                [imageView addSubview:view];
                [zhouBtn setTitle:@"大洋洲" forState:UIControlStateNormal];
                zhouBtn.centerX = view.centerX;
                zhouBtn.centerY = view.centerY - 25;
                [imageView addSubview:zhouBtn];
               
                break;
            case 5:
                //非洲
                view.frame = CGRectMake(205, 150, 6, 6);
                [imageView addSubview:view];
                [zhouBtn setTitle:@"非洲" forState:UIControlStateNormal];
                zhouBtn.centerX = view.centerX;
                zhouBtn.centerY = view.centerY - 25;
                [imageView addSubview:zhouBtn];
                break;
            case 6:
                //南极洲
                view.frame = CGRectMake(258, 223, 6, 6);
                [imageView addSubview:view];
                [zhouBtn setTitle:@"南极洲" forState:UIControlStateNormal];
                zhouBtn.centerX = view.centerX;
                zhouBtn.centerY = view.centerY - 25;
                [imageView addSubview:zhouBtn];
                break;
            default:
                break;
        }
    }
    
    _tableView.tableHeaderView = headerView;
}

- (void)tapImage:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:tap.view];
    NSLog(@"X:%f,Y:%f",point.x,point.y);
}

- (void)zhouButtonClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if(btn != self.temButton){
        
        self.temButton.selected = NO;
        self.temButton = btn;
    }
    self.temButton.selected = YES;
    
    switch (btn.tag) {
        case 1000://亚洲
            for (MDDData* mmdData in _ZhouArray) {
                if ([mmdData.cnname isEqualToString:@"亚洲"]) {
                    _hotCountry = [mmdData.hot_country mutableCopy];
                    _country = [mmdData.country mutableCopy];
                    
                }
            }
            [_tableView reloadData];
            break;
        case 1001://欧洲
            for (MDDData* mmdData in _ZhouArray) {
                if ([mmdData.cnname isEqualToString:@"欧洲"]) {
                    _hotCountry = [mmdData.hot_country mutableCopy];
                    _country = [mmdData.country mutableCopy];
                    
                }
            }
            [_tableView reloadData];
            break;
        case 1002://北美洲
            for (MDDData* mmdData in _ZhouArray) {
                if ([mmdData.cnname isEqualToString:@"北美洲"]) {
                    _hotCountry = [mmdData.hot_country mutableCopy];
                    _country = [mmdData.country mutableCopy];
                    
                }
            }
            [_tableView reloadData];
            break;
        case 1003://南美洲
            for (MDDData* mmdData in _ZhouArray) {
                if ([mmdData.cnname isEqualToString:@"南美洲"]) {
                    _hotCountry = [mmdData.hot_country mutableCopy];
                    _country = [mmdData.country mutableCopy];
                    
                }
            }
            [_tableView reloadData];
            break;
        case 1004://大洋洲
            for (MDDData* mmdData in _ZhouArray) {
                if ([mmdData.cnname isEqualToString:@"大洋洲"]) {
                    _hotCountry = [mmdData.hot_country mutableCopy];
                    _country = [mmdData.country mutableCopy];
                    break;
                }
                
            }
            [_tableView reloadData];
            
            break;
        case 1005://非洲
            for (MDDData* mmdData in _ZhouArray) {
                if ([mmdData.cnname isEqualToString:@"非洲"]) {
                    _hotCountry = [mmdData.hot_country mutableCopy];
                    _country = [mmdData.country mutableCopy];
                    
                }
            }
            [_tableView reloadData];
            
            break;
        case 1006://南极洲
            for (MDDData* mmdData in _ZhouArray) {
                if ([mmdData.cnname isEqualToString:@"南极洲"]) {
                    _hotCountry = [mmdData.hot_country mutableCopy];
                    _country = [mmdData.country mutableCopy];
                    
                }
            }
            [_tableView reloadData];
            
            break;
        default:
            break;
    }
    
    
}


- (void)setListView{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[hotTableCell class] forCellReuseIdentifier:@"hotTableCell"];
    [tableView registerNib:[UINib nibWithNibName:@"countryCell" bundle:nil] forCellReuseIdentifier:@"countryCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _country.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        if (_country.count == 0) {
            
            return _hotCountry.count/2 * 250+50;
        }
        return _hotCountry.count/2 * 250+90;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        hotTableCell * cell = [[hotTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotTableCell" With:_hotCountry];
        for (UIView * view in self.imageView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton * btn = (UIButton *)view;
        
                if (btn.isSelected) {
                    MDDData * data = _ZhouArray[btn.tag - 1000];
                    cell.zhouname = data.cnname;
                }
            }
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    countryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"countryCell" forIndexPath:indexPath];
    CountryData * data = _country[indexPath.row-1];
    cell.data = data;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        CountryData * data = _country[indexPath.row-1];
        CountryVC * vc = [[CountryVC alloc]init];
        vc.countryId = data.id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - hotTableViewCellDelegate
- (void)collectionViewCellSelectedWith:(HotCountryData *)hotData{
    
    CountryVC * vc = [[CountryVC alloc]init];
    vc.countryId = hotData.id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
