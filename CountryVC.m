//
//  CountryVC.m
//  QiongTreval
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "CountryVC.h"
#import "CountryDetailModel.h"
#import "DetailSubModel.h"
#import "SDCycleScrollView.h"
#import "TitleView.h"
#import "HotCountryCell.h"
#import "FreeTravelCell.h"
#import "FreeCell.h"
#import "UINavigationBar+NavAlpha.h"
#define dataurl @"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.01048675218904&lon=116.4627165639485&oauth_token=73a0d5197ceab969461b6ddb980e573a&page=1&track_app_channel=App%2520Store&track_app_version=6.9.3&track_device_info=iPhone8%2C1&track_deviceid=7931B9E3-0421-4170-821D-958F62A93A33&track_os=ios%25209.3.2&track_user_id=7917461&v=1&country_id="
#define topScrollHeight 230
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
@interface CountryVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray * photoArray;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)SDCycleScrollView * topScrollView;
@property (nonatomic,strong)UIImageView * topImageView;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,assign) CGFloat halfHeight;
@property (nonatomic,strong)UIButton * backBtn;
@property (nonatomic,strong)UIButton * dituBtn;
@property (nonatomic,strong)UILabel * cnLabel;
@property (nonatomic,strong)UILabel * enLabel;
@property (nonatomic,strong)UILabel * descriLb;
@property (nonatomic,strong)UILabel * guidLabel;
@property (nonatomic,strong)UILabel * allGuidLb;
@property (nonatomic,strong)UIView * guidView;
@property (nonatomic,strong)UIImageView * guidImage;
@property (nonatomic,strong)CAGradientLayer* gradientLayer;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)NSArray * hot_Array;
@property (nonatomic,strong)DetailSubModel * subModel;
@end

@implementation CountryVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏的背景色是黑色, 字体为白色

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
    UIColor * color= [UIColor whiteColor];
    [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
    
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar cnReset];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavgationBar];
    [self configeScrollView];
    [self configeTableView];
    [self requestListData];
    self.index = 0;
    _halfHeight = (kScreenHeight) * 0.5 - 64;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (NSArray *)hot_Array{
    
    if (_hot_Array == nil) {
        _hot_Array = [NSArray array];
    }
    return _hot_Array;
}

- (void)initNavgationBar{
    
    self.navigationItem.hidesBackButton = YES;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setBackgroundImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = btn;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn ];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton * right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 25, 22);
    [right setBackgroundImage:[UIImage imageNamed:@"ditu.png"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(dituClick) forControlEvents:UIControlEventTouchUpInside];
    self.dituBtn = right;
    UIBarButtonItem * dituBar = [[UIBarButtonItem alloc]initWithCustomView:self.dituBtn];
    self.navigationItem.rightBarButtonItem = dituBar;

}

- (void)requestListData{
    
    [[AFHTTPSessionManager manager]GET:[NSString stringWithFormat:@"%@%@",dataurl,self.countryId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@%@",responseObject,task.response.URL);
        CountryDetailModel * model = [CountryDetailModel mj_objectWithKeyValues:responseObject];
       
        DetailSubModel * subModel= [DetailSubModel mj_objectWithKeyValues:model.data];
       
        NSDictionary * hot_dic = model.data;
        self.hot_Array = [NSArray arrayWithArray:hot_dic[@"new_discount"]];
        
        self.subModel =subModel;
        _photoArray = [NSMutableArray arrayWithArray:subModel.photos];
        
        if (_photoArray.count ==0) {
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.topScrollView.imageURLStringsGroup =_photoArray;
            [self.topImageView sd_setImageWithURL:[NSURL URLWithString:_photoArray[0]] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
            self.cnLabel.text = subModel.cnname;
            self.enLabel.text = subModel.enname;
            self.descriLb.text = subModel.entryCont;
            if (![subModel.guide_num isEqualToString:@"0"]) {
                self.guidLabel.text = [NSString stringWithFormat:@"%@锦囊",subModel.cnname];
                self.allGuidLb.text = [NSString stringWithFormat:@"全部%@本",subModel.guide_num];
               self.guidImage.image = [UIImage imageNamed:@"锦囊"];
                self.guidView.hidden = NO;
                
            }else{
                self.topView.height = topScrollHeight;
                self.guidView.hidden = YES;
                self.tableView.tableHeaderView = self.topView;
            }
        });
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (void)configeScrollView{
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, topScrollHeight+54)];
    [self.view addSubview:topView];
    self.topView = topView;
    
    SDCycleScrollView * scrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, topScrollHeight)];
    scrollView.autoScrollTimeInterval = 3;
    scrollView.showPageControl = NO;
    scrollView.placeholderImage = [UIImage imageNamed:@"placeHolder.png"];
    scrollView.delegate = self;
    self.topScrollView = scrollView;
    [self.topView addSubview:self.topScrollView];
    
    UIImageView * layerView = [[UIImageView alloc]initWithFrame:self.topScrollView.bounds];
//    CAGradientLayer* gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
//    gradientLayer.bounds = layerView.bounds;
//    gradientLayer.borderWidth = 0;
//    gradientLayer.frame = layerView.bounds;
//    gradientLayer.colors = [NSArray arrayWithObjects:
//                             (id)[[UIColor clearColor] CGColor],
//                             (id)[[UIColor blackColor] CGColor], nil];
//    gradientLayer.startPoint = CGPointMake(0.1, 0.7);
//    gradientLayer.endPoint = CGPointMake(0.1, 1.0);
//    
//    [layerView.layer addSublayer:gradientLayer];
    layerView.hidden = YES;
    [scrollView addSubview:layerView];
    self.topImageView = layerView;
    
    UILabel * cnlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 150, 20)];
    cnlabel.textColor = [UIColor whiteColor];
    cnlabel.font = [UIFont systemFontOfSize:20];
    cnlabel.textAlignment = NSTextAlignmentLeft;
    [self.topView addSubview:cnlabel];
    self.cnLabel = cnlabel;
    
    UILabel * enLb = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.cnLabel.frame)+7, 150, 15)];
    enLb.textColor = RGB(217, 217, 217);
    enLb.font = [UIFont systemFontOfSize:14];
    enLb.textAlignment = NSTextAlignmentLeft;
    [self.topView addSubview:enLb];
    self.enLabel = enLb;
    
    UILabel * desLb = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.enLabel.frame)+10, Screen_Width-40, 40)];
    desLb.textColor = RGB(217, 217, 217);
    desLb.numberOfLines = 0;
    desLb.font = [UIFont systemFontOfSize:14];
    desLb.lineBreakMode = NSLineBreakByWordWrapping;
    [self.topView addSubview:desLb];
    self.descriLb = desLb;
    
    UIView * guid_View = [[UIView alloc]initWithFrame:CGRectMake(0, topScrollHeight, Screen_Width, 54)];
    guid_View.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:guid_View];
    self.guidView = guid_View;
    self.guidView.hidden = YES;
    
    UIImageView * guidImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 19, 17, 17)];
    [guid_View addSubview:guidImage];
    self.guidImage = guidImage;
   
    UILabel * guidLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(guidImage.frame)+5, 20, 150, 15)];
    guidLb.textColor = [UIColor darkGrayColor];
    guidLb.font = [UIFont systemFontOfSize:14];
    guidLb.textAlignment = NSTextAlignmentLeft;
    [guid_View addSubview:guidLb];
    self.guidLabel = guidLb;
    
    UILabel * allLabel = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-94, 15, 60, 20)];
    
    allLabel.textColor = [UIColor darkGrayColor];
    allLabel.font = [UIFont systemFontOfSize:14];
    allLabel.textAlignment = NSTextAlignmentRight;
    [guid_View addSubview:allLabel];
    self.allGuidLb = allLabel;
    
    UIImageView * youImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allLabel.frame)+3, 17.5, 17, 16)];
    youImage.image = [UIImage imageNamed:@"右右"];
    [guid_View addSubview:youImage];

}




- (void)configeTableView{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[HotCountryCell class] forCellReuseIdentifier:@"HotCountryCell"];
    [tableView registerNib:[UINib nibWithNibName:@"FreeTravelCell" bundle:nil] forCellReuseIdentifier:@"FreeTravelCell"];
    [tableView registerNib:[UINib nibWithNibName:@"FreeCell" bundle:nil] forCellReuseIdentifier:@"FreeCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableHeaderView = self.topView;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = RGB(6, 173, 114);
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < 0) {
        // 拉伸后图片的高度
        CGFloat totalOffset = topScrollHeight - Offset_y;
        // 图片放大比例
        CGFloat scale = totalOffset / topScrollHeight;
        CGFloat width = Screen_Width;
        // 拉伸后图片位置
        self.topImageView.frame = CGRectMake(-(width * scale - width) / 2, Offset_y, width * scale, totalOffset);
        self.topScrollView.autoScroll = NO;
        self.topImageView.hidden = NO;
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
        
    }else{
        self.topImageView.hidden = YES;
        CGFloat alpha = MIN(1, ( 64 + Offset_y)/64-1);
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        self.topScrollView.autoScroll = YES;
    }
    
  
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.hot_Array.count ==0) {
        return 1;
    }
    return self.hot_Array.count+2;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        HotCountryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotCountryCell" forIndexPath:indexPath];
        
        [cell cellLoadData:self.subModel andWithIndex:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        
        FreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FreeCell" forIndexPath:indexPath];
        
        return cell;

    }else{
        
        FreeTravelCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FreeTravelCell"];
        
        [cell assignmentCellWith:self.hot_Array WithIndexPath:indexPath];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        return 285;
    }else if (indexPath.row == 1){
        
        return 63;
    }
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
    }else{
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark -- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    
}


/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.index = index;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:_photoArray[index]] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dituClick{
    
    
}

@end
