//
//  QYTabBarController.m
//  QiongTreval
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "QYTabBarController.h"
#import "RecommendController.h"
#import "DestinationController.h"
#import "CommunityController.h"
#import "MineViewController.h"
#import "QYNavViewController.h"
@interface QYTabBarController ()

@end

@implementation QYTabBarController

- (instancetype)init{
    
    if (self = [super init]) {
        
        RecommendController * recommend = [[RecommendController alloc]init];
        QYNavViewController * reNav = [[QYNavViewController alloc]initWithRootViewController:recommend];
        reNav.title = RecommendTitle;
        
        DestinationController * des = [[DestinationController alloc]init];
        QYNavViewController * desNav = [[QYNavViewController alloc]initWithRootViewController:des];
        desNav.title = DestinationTitle;
        
        CommunityController * community = [[CommunityController alloc]init];
        QYNavViewController * comNav = [[QYNavViewController alloc]initWithRootViewController:community];
        comNav.title = CommunityTitle;
        
        MineViewController * mine = [[MineViewController alloc]init];
        QYNavViewController * mineNav = [[QYNavViewController alloc]initWithRootViewController:mine];
        mineNav.title = MineTitle;
        self.viewControllers = @[reNav,desNav,comNav,mineNav];
        
        
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    NSArray * images = @[@"推荐",@"目的地",@"社区",@"我的"];
    
    NSInteger index = 0;
    
    for (UIViewController * vc in self.viewControllers) {
        
        NSString * normalImage = [NSString stringWithFormat:@"%@1",images[index]];
        
        NSString * selectImage = [NSString stringWithFormat:@"%@2",images[index]];
        vc.tabBarItem.image = [UIImage imageNamed:normalImage];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
       // vc.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        index++;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
