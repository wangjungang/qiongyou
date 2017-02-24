//
//  QYIntroduceController.m
//  QiongTreval
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "QYIntroduceController.h"
#import "AppDelegate.h"
@interface QYIntroduceController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIPageControl * pageControl;
@property (nonatomic,strong)UIButton * enterButton;
@end

@implementation QYIntroduceController{
    
    NSArray * imageArray;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self setupSubView];
}

- (void)initData{
    
    imageArray = @[@"userGuide0.jpg",@"userGuide1.jpg",@"userGuide2.jpg",@"userGuide3.jpg",@"userGuide4.jpg"];
    
}

- (void)setupSubView{
    
    _scrollView = ({
       
        UIScrollView * scrollView = [UIScrollView new];
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(Screen_Width * imageArray.count, Screen_Height);
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        scrollView;
    });
    
    for (int i =0; i<imageArray.count; i++) {
        
        UIImageView * imageView = [UIImageView new];
        imageView.frame = CGRectMake(i*Screen_Width, 0, Screen_Width, Screen_Height);
        imageView.image = [UIImage imageNamed:imageArray[i]];
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
        //加了上面这句话图片的位置就变形了
        
        [_scrollView addSubview:imageView];
        
        if (i== imageArray.count-1) {
            imageView.userInteractionEnabled = YES;
            _enterButton = ({
                
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setBackgroundImage:[UIImage imageNamed:@"guideEnterBtn"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(enterApp:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerX.equalTo(imageView);
                    make.size.sizeOffset(CGSizeMake(150, 47));
                    make.bottom.equalTo(imageView).offset(-65);
                }];
                
                btn;
                
            });

        }
    }
    
    _pageControl = ({
        UIPageControl * pageControl = [UIPageControl new];
        pageControl.pageIndicatorTintColor = RGB(231, 231, 231);
        pageControl.currentPageIndicatorTintColor = RGB(26, 165, 50);
        pageControl.numberOfPages = imageArray.count;
        [self.view addSubview:pageControl];
        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-40);//距离self.view底部40
        }];
        
        pageControl;
    });
    
    
}

- (void)enterApp:(UIButton *)btn{
    
    [QYUserDefaults setObject:@"1" forKey:@"FirstIn"];
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate showTabBarController];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger currentPage = scrollView.contentOffset.x/Screen_Width;
    BOOL hasGreatThanHalfScreen = scrollView.contentOffset.x > (currentPage + 0.5) * Screen_Width;
     _pageControl.currentPage = currentPage + (hasGreatThanHalfScreen ? 1 : 0);
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
