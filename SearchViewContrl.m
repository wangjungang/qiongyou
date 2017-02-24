//
//  SearchViewContrl.m
//  QiongTreval
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "SearchViewContrl.h"
#import "SearchCell.h"
#import "SearchModel.h"
#import "JCTagListView.h"
#define Search_URL @"http://open.qyer.com/qyer/search/hot_history?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=40.01259304990385&lon=116.4602651432521&oauth_token=73a0d5197ceab969461b6ddb980e573a&page=1&track_app_channel=App%2520Store&track_app_version=7.0.1&track_device_info=iPhone8%2C1&track_deviceid=7931B9E3-0421-4170-821D-958F62A93A33&track_os=ios%25209.3.4&track_user_id=7917461&v=1"
@interface SearchViewContrl ()<searchDelegate>
@property (nonatomic,strong)JCTagListView * listView_top;
@property (nonatomic,strong)JCTagListView * listView_down;
@property (nonatomic,strong)NSMutableArray * historyArray;
@property (nonatomic,strong)NSMutableArray * hotArray;
@property (nonatomic,strong)NSArray *sectionArray;;
@end


NSString * const cellIdentifier = @"searchCell";
@implementation SearchViewContrl

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.width =Screen_Width;
        self.height = Screen_Height -64;
        self.backgroundColor = [UIColor whiteColor];

        [self setup];
        [self requestData];
    }
    return self;
}

- (NSMutableArray *)historyArray{
    
    if (!_historyArray) {
        _historyArray = [NSMutableArray arrayWithContentsOfFile:QYSearchHistoryPath];
        if (_historyArray == nil) {
            _historyArray = [NSMutableArray array];
        }
    }
    return _historyArray;
}


- (void)requestData{
    
    [[AFHTTPSessionManager manager]GET:Search_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@ %@",responseObject,task.response.URL);
        SearchModel * model = [SearchModel mj_objectWithKeyValues:responseObject];
        self.hotArray = [NSMutableArray arrayWithArray:model.data] ;
        self.sectionArray = @[self.historyArray,self.hotArray];
        self.listView_top.tags = [NSMutableArray arrayWithArray:self.historyArray];
        [self.listView_top.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)setSearchStr:(NSString *)searchStr{
    
    _searchStr = searchStr;
    for (NSString * str in self.historyArray) {
        if ([str isEqualToString:searchStr]) {
            return ;
        }
    }
    [self.historyArray insertObject:searchStr atIndex:0];
    if (self.historyArray.count > 6) {
        [self.historyArray removeLastObject];
    }
    [self.historyArray writeToFile:QYSearchHistoryPath atomically:YES];
    self.listView_top.tags = self.historyArray;
    [self.listView_top.collectionView reloadData];
}

- (void)setup{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 60, 15)];
    label.text = @"历史记录";
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    
    UIButton * qingchu = [UIButton buttonWithType:UIButtonTypeCustom];
    qingchu.frame = CGRectMake(Screen_Width-45, 15, 30, 15);
    [qingchu setTitle:@"清除" forState:UIControlStateNormal];
    [qingchu setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [qingchu addTarget:self action:@selector(qingchuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    qingchu.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:qingchu];

    UIView * lineV = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame)+15, Screen_Width-30, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineV];
    
    JCTagListView * listView = [[JCTagListView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lineV.frame)+15, Screen_Width-30, 200)];
    listView.tagStrokeColor = [UIColor lightGrayColor];
    listView.tagBackgroundColor = [UIColor lightGrayColor];
    listView.tagCornerRadius = 8;
    [self addSubview:listView];
    self.listView_top = listView;
   
    
}

- (void)qingchuBtnClick:(UIButton *)btn{
    
    [self.historyArray removeAllObjects];
    [self.historyArray writeToFile:QYSearchHistoryPath atomically:NO];
    self.listView_top.tags = self.historyArray;
    [self.listView_top.collectionView reloadData];
}





@end
