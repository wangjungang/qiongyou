//
//  RecommendController.m
//  QiongTreval
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "RecommendController.h"
#import "QYSeachBar.h"
#import "SearchViewContrl.h"
#import "SDCycleScrollView.h"
#import "RecomModel.h"
#import "RecomData.h"
#import "subjectData.h"
#import "CommentCell.h"
#import "FoundNextCell.h"
#import "QYGuangGaoVC.h"
#import "discountData.h"
#import "dissubData.h"
#import "DiscountCell.h"
#import "hotTravelModel.h"
#import "hotTravelData.h"
#import "hotTravelCell.h"
#import "hotCell.h"
#import "hotWebVC.h"
#import "SpecialVC.h"
#import "DiscountVC.h"
static  NSString  *const commentIdentifier= @"commentIdentifier";
static NSString *const foundIdentifier = @"foundIdentifier";
static NSString * const discountIdentifier = @"discountIdentifier";
static NSString * const hotTravelIdentifier = @"hotTravelIdentifier";
static NSString * const hotCellIdentifier = @"hotCellIdentifier";
@interface RecommendController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate,FoundCellDelegate,discountCellDelegate>
@property (nonatomic,strong)UIView * searchView;
@property (nonatomic,strong)UIImageView * leftImage;
@property (nonatomic,strong)UIButton * cancelBtn;
@property (nonatomic,strong)UISearchBar * searchBar;
@property (nonatomic,strong)SearchViewContrl * seachControl;
@property (nonatomic,strong)SDCycleScrollView * topScrollView;
@property (nonatomic,strong)UIView * topView;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)NSMutableArray * imageArray;
@property (nonatomic,strong)NSMutableArray * urlArray;
@property (nonatomic,strong)NSMutableArray * subjectArray;
@property (nonatomic,strong)NSMutableArray * discountArray;
@property (nonatomic,strong)NSMutableArray * dissubArray;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)int page;
@end

@implementation RecommendController{
    
    NSMutableArray * _scrollViewArray;
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.barTintColor = RGB(6, 173, 114);
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}

- (NSMutableArray *)imageArray{
    
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        //制造假数据 目的是为了保存cell的个数
        _dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    }
    return _dataArray;
}

- (NSMutableArray *)urlArray{
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(225, 225, 225);

    [self setupNavgationBar];
    [self creatTableView];
    [self setupTopHeaderView];
    
    [self requestData];
    _tableView.tableHeaderView = _topView;
    
    self.tableView.mj_header = [ChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    self.tableView.mj_footer = [ChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _page = 0;
}

- (void)setupNavgationBar{
    
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageV.layer.cornerRadius = 24;
    imageV.layer.masksToBounds = YES;
    imageV.image = [UIImage imageNamed:@"tab.jpg"];
    self.leftImage = imageV;
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:self.leftImage];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width-60, 25)];
    view.layer.cornerRadius = 25/2;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.backgroundColor = RGB(6, 173, 114);
    UISearchBar * search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 2, Screen_Width-60, 21)];
    search.placeholder = @"搜索目的地、帖子、特价、穷游er";
    search.delegate = self;
    for (UIView* subview in [[search.subviews lastObject] subviews]) {
        
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            
            //textField.textColor = [UIColor redColor];                         //修改输入字体的颜色
            [textField setBackgroundColor:[UIColor clearColor]];      //修改输入框的颜色
            
            [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
            [textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
            
        } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
        }
    }

    [view addSubview:search];
    self.searchBar = search;
    self.searchView = view;
    [self.searchBar resignFirstResponder];
    UIBarButtonItem * searchBartem = [[UIBarButtonItem alloc]initWithCustomView:self.searchView];
    
    self.navigationItem.leftBarButtonItems = @[bar,searchBartem];
    
    UIButton * quxiao = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    quxiao.backgroundColor = [UIColor clearColor];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    quxiao.titleLabel.font = [UIFont systemFontOfSize:13];
    [quxiao setTitleColor:RGB(6, 173, 114) forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn = quxiao;
    UIBarButtonItem * quxiaoBar = [[UIBarButtonItem alloc]initWithCustomView:self.cancelBtn];
    self.navigationItem.rightBarButtonItem = quxiaoBar;
    self.cancelBtn.hidden = YES;
}

- (UIView *)seachControl{
    
    _seachControl =[[SearchViewContrl alloc]initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, Screen_Height-64)];
    
    return _seachControl;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.leftImage.hidden = YES;
        self.searchView.x -= 40 ;
        [self.view addSubview:self.seachControl];
        _seachControl.y = 64;

    } completion:^(BOOL finished) {
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.searchView.backgroundColor = [UIColor whiteColor];
        self.cancelBtn.hidden = NO;
        self.cancelBtn.x +=10;
       
    }];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (searchBar.text.length) {
        
        _seachControl.searchStr = searchBar.text;
        
    }
}

- (void)quxiao:(UIButton *)btn{
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.cancelBtn.hidden = YES;
        self.searchView.x += 40;
        self.cancelBtn.x -=10;
        _seachControl.y = Screen_Height;
        [self.searchBar resignFirstResponder];
    } completion:^(BOOL finished) {
        self.navigationController.navigationBar.barTintColor = RGB(6, 173, 114);
        self.searchView.backgroundColor = RGB(6, 173, 114);
        self.leftImage.hidden = NO;
        self.searchBar.text = nil;
        [_seachControl removeFromSuperview];
    }];
    
}

- (void)creatTableView{
    
    _tableView = ({
        UITableView * tableView = [UITableView new];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = RGB(225, 225, 225);
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:commentIdentifier];
        [tableView registerNib:[UINib nibWithNibName:@"FoundNextCell" bundle:nil] forCellReuseIdentifier:foundIdentifier];
        [tableView registerNib:[UINib nibWithNibName:@"hotTravelCell" bundle:nil] forCellReuseIdentifier:hotTravelIdentifier];
        [tableView registerNib:[UINib nibWithNibName:@"hotCell" bundle:nil] forCellReuseIdentifier:hotCellIdentifier];
        [tableView registerClass:[DiscountCell class] forCellReuseIdentifier:discountIdentifier];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(0);
            make.size.equalTo(self.view);
        }];
       
        tableView;
    });

}

- (void)setupTopHeaderView{
    
    _topView = ({
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 280)];
        view.backgroundColor = [UIColor clearColor];
         [self.view addSubview:view];
        view;
    });
   
    _topScrollView = ({
    
        SDCycleScrollView * cycleScrollView = [SDCycleScrollView new];
        cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeHolder.png"];
        cycleScrollView.delegate = self;
        cycleScrollView.autoScrollTimeInterval = 5;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
         cycleScrollView.currentPageDotColor = [UIColor whiteColor];
        [self.topView addSubview:cycleScrollView];
        [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.left.top.right.equalTo(self.topView);
            make.height.equalTo(@(200));
        }];
      
        cycleScrollView;
    });
    
    _imageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.topView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topScrollView.mas_bottom);
            make.left.right.bottom.equalTo(self.topView);
            make.size.sizeOffset(CGSizeMake(Screen_Width, 80));
        }];
        
        imageView;
    });
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, Screen_Width, 80);
    [_imageView addSubview:effectview];

    NSArray * btnarray = @[@"看锦囊",@"抢折扣",@"订酒店",@"旅途中"];
    for (int i =0; i<4; i++) {
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((i+1) *(Screen_Width-200)/5+(i%4)*50, 7, 50, 50)];
        btn.tag = 2000+i;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guoqi%d",i]] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 25;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [effectview.contentView addSubview:btn];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake((i+1) *(Screen_Width-200)/5+(i%4)*50, 60, 50, 20)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.text = btnarray[i];
        [effectview.contentView addSubview:label];
    }
    
}

- (void)btnClick:(UIButton *)btn{
    
    NSLog(@"%ld",btn.tag-2000);
}

- (void)loadMoreData{
    
    _page ++;
    NSDictionary * parameters = @{@"page":@(_page)};
    
    [[AFHTTPSessionManager manager]GET:LoadMoreUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        hotTravelModel * hotModel = [hotTravelModel mj_objectWithKeyValues:responseObject];
        [self.dataArray addObjectsFromArray:hotModel.data];
        
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    
}

- (void)requestData{
    _page = 0;
    if (self.dataArray) {
        self.dataArray = [NSMutableArray arrayWithObjects:@"11",@"22",@"33", nil];
    }
    [_scrollViewArray removeAllObjects];
    [self.imageArray removeAllObjects];
    [self.urlArray removeAllObjects];
    
    [[AFHTTPSessionManager manager]GET:@"http://open.qyer.com/qyer/recommands/entry?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.01051300542242&lon=116.4625062742449&oauth_token=73a0d5197ceab969461b6ddb980e573a&page=1&track_app_channel=App%2520Store&track_app_version=6.9.2&track_device_info=iPhone8%2C1&track_deviceid=7931B9E3-0421-4170-821D-958F62A93A33&track_os=ios%25209.3.2&track_user_id=7917461&v=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        RecomModel * model = [RecomModel mj_objectWithKeyValues:responseObject];
        RecomData * data = [RecomData mj_objectWithKeyValues:model.data];
        
        _scrollViewArray = [NSMutableArray arrayWithArray:data.slide];
        for (NSDictionary * dic in _scrollViewArray) {
            [self.imageArray addObject:dic[@"photo"]];
            [self.urlArray addObject:dic[@"url"]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _topScrollView.imageURLStringsGroup = [NSArray arrayWithArray:self.imageArray];;
        });
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
        _subjectArray = [NSMutableArray arrayWithObject:data.subject];
        _discountArray = [NSMutableArray arrayWithArray:data.discount];
        _dissubArray = [NSMutableArray arrayWithArray:data.discount_subject];
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = RGB(225, 225, 225);;
    return cell;
        
    }else if(indexPath.row == 1){
        FoundNextCell * cell = [tableView dequeueReusableCellWithIdentifier:foundIdentifier forIndexPath:indexPath];
        NSMutableArray * array= [_subjectArray mutableCopy];
        cell.dataArray = [array mutableCopy];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGB(225, 225, 225);
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 2){
        
        DiscountCell * cell = [tableView dequeueReusableCellWithIdentifier:discountIdentifier forIndexPath:indexPath];
        [cell cellWithdiscountArray:_discountArray anddisSubArray:_dissubArray andIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGB(225, 225, 225);
        return cell;
    }else if (indexPath.row == 3){
        hotTravelCell * cell = [tableView dequeueReusableCellWithIdentifier:hotTravelIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGB(225, 225, 225);
        cell.hotData = self.dataArray[indexPath.row];
        return cell;
    }else{
        
        hotCell * cell = [tableView dequeueReusableCellWithIdentifier:hotCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGB(225, 225, 225);
        cell.hotData = self.dataArray[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 55;
    }else if (indexPath.row == 1){
        return 370;
    }else if (indexPath.row == 2){
        return 650;
    }
    else if (indexPath.row == 3){
        
        return 150;
    }else{
        
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row>=3) {
         hotTravelData * data = self.dataArray[indexPath.row];
        hotWebVC * web = [[hotWebVC alloc]init];
        web.data = data;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }
   
}

#pragma mark - FoundCellDelegate
- (void)tapImageViewWith:(subjectData *)data{
    
    QYGuangGaoVC * guanggao = [[QYGuangGaoVC alloc]init];
    guanggao.urlString = data.url;
    guanggao.titleString = data.title;
    guanggao.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:guanggao animated:YES];
}

- (void)seeMoreContentButtonClick{
    
    SpecialVC * vc = [[SpecialVC alloc]init];;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)seemoreDiscount{
    
    DiscountVC * vc = [[DiscountVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[index]] placeholderImage:nil];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    QYGuangGaoVC * guanggao = [[QYGuangGaoVC alloc]init];
    guanggao.urlString = _urlArray[index];
    guanggao.titleString = @"专题";
    guanggao.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:guanggao animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)dealloc{
    
    
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
