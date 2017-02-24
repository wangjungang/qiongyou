//
//  QYGuangGaoVC.m
//  QiongTreval
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "QYGuangGaoVC.h"

@interface QYGuangGaoVC ()

@end

@implementation QYGuangGaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    NSURL * url = [NSURL URLWithString:self.urlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [webView loadRequest:request];
    
    [self setupNavgationBarAndTabBar];
    self.title = self.titleString;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)setupNavgationBarAndTabBar{
    
    UIView * buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-49, Screen_Width, 49)];
    buttomView.backgroundColor = RGBAlpha(255, 255, 255, 0.7);
    [self.view addSubview:buttomView];
    
    UIButton * share = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,  Screen_Width, 49)];
    [share setTitle:@"分享" forState:UIControlStateNormal];
    share.titleLabel.font = [UIFont systemFontOfSize:12];
    share.backgroundColor = [UIColor clearColor];
    [share setTitleColor:RGB(6, 173, 114) forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareguanggao) forControlEvents:UIControlEventTouchUpInside];
    [buttomView addSubview:share];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 21, 18);
    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
}

- (void)backButton{
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  分享
 */
- (void)shareguanggao{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
