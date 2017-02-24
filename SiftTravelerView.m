//
//  SiftTravelerView.m
//  QiongTreval
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "SiftTravelerView.h"
#import "SiftModel.h"
#import "SiftDataModel.h"
#import "siftTimeData.h"
#import "siftPlaceData.h"
#import "rightTableCell.h"
#import "placeData.h"
#define timeandPlaceUrl @"http://open.qyer.com/qyer/community/company/filter?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.01050136099231&lon=116.4624765304091&oauth_token=73a0d5197ceab969461b6ddb980e573a&page=1&track_app_channel=App%2520Store&track_app_version=6.9.3&track_device_info=iPhone8%2C1&track_deviceid=7931B9E3-0421-4170-821D-958F62A93A33&track_os=ios%25209.3.2&track_user_id=7917461&v=1"
@interface SiftTravelerView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *timeView;
@property (nonatomic,strong)UITableView * timeTbleView;
@property (nonatomic,strong)UIButton * tmpBtn;
@property (nonatomic,strong)UIButton * timeBtn;
@property (nonatomic,strong)UIButton * placeBtn;
@property (nonatomic,strong)NSMutableArray * timeDataArray;
@property (nonatomic,strong)NSMutableArray * placeDataArray;
@property (nonatomic,strong)NSArray * timeAllArray;
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UITableView * rightTableView;
@property (nonatomic,strong)NSMutableArray * rightDataArray;
@property (nonatomic,strong)UIButton * placeTmpBtn;
@property (nonatomic,strong)UIButton * timeTmpBtn;
@property (nonatomic,strong)placeData * placedata;
@end

@implementation SiftTravelerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self= [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIButton * timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeButton.frame = CGRectMake(0, 0, self.width/2, self.height);
    [timeButton setTitle:@"出发时间 - 不限" forState:UIControlStateNormal];
    [timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [timeButton setTitleColor:RGB(6, 173, 114) forState:UIControlStateSelected];
    timeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    timeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    timeButton.backgroundColor = [UIColor whiteColor];
    [timeButton addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:timeButton];
    self.timeBtn = timeButton;
    
    UIButton * placeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    placeBtn.frame = CGRectMake(self.width/2, 0, self.width/2, self.height);
    [placeBtn setTitle:@"目的地 - 不限" forState:UIControlStateNormal];
    [placeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [placeBtn setTitleColor:RGB(6, 173, 114) forState:UIControlStateSelected];
    placeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    placeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    placeBtn.backgroundColor = [UIColor whiteColor];
    [placeBtn addTarget:self action:@selector(placeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:placeBtn];
    self.placeBtn = placeBtn;
    
    UIView * timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, Screen_Width, Screen_Height-64-49-50)];
    
    timeView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackGroundView:)];
    [timeView addGestureRecognizer:tap];
    self.timeView = timeView;
    
    UITableView * timeTbleView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.timeView.width, self.timeView.height-70) style:UITableViewStylePlain];
    timeTbleView.backgroundColor = [UIColor whiteColor];
    timeTbleView.dataSource = self;
    timeTbleView.delegate = self;
    timeTbleView.tableFooterView = [UIView new];
    self.timeTbleView = timeTbleView;
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 100, self.timeView.height-70)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    
    UITableView * rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 0, Screen_Width-100, self.timeView.height-70) style:UITableViewStylePlain];
    rightTableView.backgroundColor = [UIColor whiteColor];
    rightTableView.dataSource = self;
    rightTableView.delegate = self;
//    [rightTableView registerNib:[UINib nibWithNibName:@"rightTableCell" bundle:nil] forCellReuseIdentifier:@"rightTableCell"];
    self.rightTableView = rightTableView;
    
    
    [self requestSiftViewData];
    
}

- (void)requestSiftViewData{
    
    [[AFHTTPSessionManager manager]GET:timeandPlaceUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        SiftModel * model = [SiftModel mj_objectWithKeyValues:responseObject];
        SiftDataModel * dataModel = [SiftDataModel mj_objectWithKeyValues:model.data];
        _timeDataArray = [NSMutableArray arrayWithArray:dataModel.times_range];
        _placeDataArray = [NSMutableArray arrayWithArray:dataModel.destination];
        siftPlaceData * place = _placeDataArray[0];
        _rightDataArray = [NSMutableArray arrayWithArray:place.place];
        NSMutableArray * time1 = [NSMutableArray array];
        NSMutableArray * time2 = [NSMutableArray array];
        NSMutableArray * time3 = [NSMutableArray array];
        for (siftTimeData * data in _timeDataArray) {
            if ([data.position isEqualToString:@"0"]) {
                [time1 addObject:data];
            }
            if ([data.position isEqualToString:@"1"]) {
                [time2 addObject:data];
            }
            if ([data.position isEqualToString:@"2"]) {
                [time3 addObject:data];
            }
        }
        
        _timeAllArray = @[time1,time2,time3];
        [self.timeTbleView reloadData];
        [self creatPlaceView];
        
        [self.rightTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"%@",error);
    }];
}

- (void)creatPlaceView{
    
    for (int i = 0; i<_placeDataArray.count; i++) {
        
        siftPlaceData * place = _placeDataArray[i];
        UIButton * zhouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zhouBtn.frame = CGRectMake(0, 50 *i, 100, 50);
        [zhouBtn setTitle:place.continent forState:UIControlStateNormal];
        [zhouBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [zhouBtn setTitleColor:RGB(6, 173, 114) forState:UIControlStateSelected];
        zhouBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [zhouBtn addTarget:self action:@selector(zhouBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            self.tmpBtn = zhouBtn;
            self.tmpBtn.selected = YES;
        }
        zhouBtn.tag = 1000+i;
        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(0, 49.5, 100, 0.5);
        layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [zhouBtn.layer addSublayer:layer];
        
        [self.scrollView addSubview:zhouBtn];
      
    }
    
}

- (void)zhouBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if(btn != self.tmpBtn){
        self.tmpBtn.selected = NO;
        self.tmpBtn = btn;
    }
    self.tmpBtn.selected = YES;
    
    siftPlaceData * place = _placeDataArray[btn.tag-1000];
    _rightDataArray = [NSMutableArray arrayWithArray:place.place];
    [self.rightTableView reloadData];
    
}

- (void)timeBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        if (self.placeBtn.isSelected&& self.timeView) {
            
            self.placeBtn.selected = NO;
            [self.timeView removeFromSuperview];
        }
        if (self.scrollView || self.rightTableView) {
            [self.scrollView removeFromSuperview];
            [self.rightTableView removeFromSuperview];
        }
        [self show];
        
    }else{
    
        [self hidd];
    }
}

- (void)placeBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
        if (self.timeBtn.isSelected && self.timeView) {
            
            self.timeBtn.selected = NO;
            [self.timeView removeFromSuperview];
            [self.timeTbleView removeFromSuperview];
        }
        [self placeBtnShow];
    }else{
        [self placeBtnHidden];
    }
}

- (void)placeBtnHidden{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.timeView.backgroundColor = [UIColor whiteColor];
        self.timeView.frame= CGRectMake(0, 50, Screen_Width, 0);
        self.scrollView.frame = CGRectMake(0, 0, 100, 0);
        self.rightTableView.frame = CGRectMake(100, 0, Screen_Width-100, 0);
    } completion:^(BOOL finished) {
        [self.rightTableView removeFromSuperview];
        [self.scrollView removeFromSuperview];
        [self.timeView removeFromSuperview];
        
    }];

}

- (void)placeBtnShow{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.superview addSubview:self.timeView];
        [self.timeView addSubview:self.scrollView];
        [self.timeView addSubview:self.rightTableView];
        self.timeView.frame= CGRectMake(0, 50, Screen_Width, Screen_Height-64-49-50);
        self.scrollView.frame = CGRectMake(0, 0, 100, self.timeView.height-70);
        self.rightTableView.frame = CGRectMake(100, 0, Screen_Width-100, self.timeView.height-70);
        self.timeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];

}

- (void)show{
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.superview addSubview:self.timeView];
        self.timeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.timeView.frame= CGRectMake(0, 50, Screen_Width, Screen_Height-64-49-50);
        self.timeTbleView.frame = CGRectMake(0, 0, Screen_Width, self.timeView.height-70);
        [self.timeView addSubview:self.timeTbleView];
        
    }];

}

- (void)hidd{
    
    
    [UIView animateWithDuration:0.2 animations:^{
         self.timeView.backgroundColor = [UIColor whiteColor];
        self.timeTbleView.frame = CGRectMake(0, 0, Screen_Width, 0);
        self.timeView.frame= CGRectMake(0, 50, Screen_Width, 0);
        
    } completion:^(BOOL finished) {
        
        [self.timeTbleView removeFromSuperview];
        [self.timeView removeFromSuperview];
        
    }];

}

- (void)tapBackGroundView:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self.timeView];
    if(point.y>self.timeView.height-70){
    
    if (self.timeTbleView ) {
        
        [self hidd];
        self.timeBtn.selected = NO;
        self.placeBtn.selected = NO;
    }
    if (self.rightTableView) {
        
        [self placeBtnHidden];
        self.timeBtn.selected = NO;
        self.placeBtn.selected = NO;
    }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.timeTbleView) {
        if (indexPath.row == 0) {
            return 60;
        }
        if (indexPath.row == 1) {
            
            return 150;
        }
        return 105;

    }
    else {
        
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.timeTbleView) {
        
        return _timeAllArray.count;
    }
    return _rightDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.timeTbleView) {
        static NSString * siftTime = @"siftTime";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:siftTime];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:siftTime];
            NSArray * array = _timeAllArray[indexPath.row];
            for (int i =0; i<array.count; i++) {
                
                siftTimeData * timedata = array[i];
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(15+(i%3)*(Screen_Width-60)/3+15*(i%3), 15+i/3*30+i/3*15, (Screen_Width-60)/3, 30);
                [button setTitle:timedata.des forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                [button setTitleColor:RGB(4, 173, 119) forState:UIControlStateSelected];
                button.layer.cornerRadius = 4;
                button.layer.masksToBounds = YES;
                button.layer.borderColor = [UIColor lightGrayColor].CGColor;
                button.layer.borderWidth = 1;
                [button addTarget:self action:@selector(goTimeClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
            }

        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    static NSString * rightTableViewid = @"rightTableView";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rightTableViewid];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightTableViewid];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 0, cell.contentView.width-10, 50);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(6, 173, 114) forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn addTarget:self action:@selector(placeBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10;
        [cell.contentView addSubview:btn];
    }
    self.placedata = _rightDataArray[indexPath.row];
    UIButton * btn1 = (UIButton *)[cell viewWithTag:10];
    [btn1 setTitle:self.placedata.place_name forState:UIControlStateNormal];
    if ([self.placedata.place_id isEqualToString:@"0"]) {
        btn1.selected = YES;

    }else{
        btn1.selected = NO;
    }
    
//    rightTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rightTableCell" forIndexPath:indexPath];
//    placeData * placedata = _rightDataArray[indexPath.row];
//    cell.placedata = placedata;
    cell.backgroundColor = RGB(242, 242, 242);
    return cell;
}

- (void)placeBtn:(UIButton *)btn{
    
   // btn.selected = !btn.selected;
    self.placedata.isSelect = !self.placedata.isSelect;

    [self placeBtnHidden];
    self.timeBtn.selected = NO;
    self.placeBtn.selected = NO;
    
}

- (void)goTimeClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if(btn != self.timeTmpBtn){
        self.timeTmpBtn.selected = NO;
        self.timeTmpBtn = btn;
    }
    self.timeTmpBtn.selected = YES;
    [self hidd];
    self.timeBtn.selected = NO;
    self.placeBtn.selected = NO;
    
}

@end
