//
//  hotWebVC.m
//  QiongTreval
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 QCQ. All rights reserved.
//

#import "hotWebVC.h"
#import "SelectPageView.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#define webFirstPage @"http://appview.qyer.com/bbs/thread-%@-%ld.html?track_app_version=6.9.3"
@interface hotWebVC ()<UIGestureRecognizerDelegate,UIWebViewDelegate>
@property (nonatomic,strong)SelectPageView * selectView;
@property (nonatomic,strong)NSMutableArray * pageArray;
@property (nonatomic,strong)UIWebView * webView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)UIButton * pageBtn;
@property (nonatomic,strong)NSString * webString;
@property (nonatomic,strong)NSMutableArray * imagesArray;
@end

@implementation hotWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    [self setupNavgationBarAndTabBar];
    
    _page = 1;
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49)];
    [self.view addSubview:webView];
    
    if (self.data) {
        
        if ([QYUserDefaults objectForKey:self.data.id]) {
            
            NSString * pageSelect = [QYUserDefaults objectForKey:self.data.id];
            _webString= [NSString stringWithFormat:@"http://appview.qyer.com/bbs/thread-%@-%@.html?track_app_version=6.9.3",self.data.id,pageSelect];
        }else{
            
            _webString= [NSString stringWithFormat:@"http://appview.qyer.com/bbs/thread-%@-%ld.html?track_app_version=6.9.3",self.data.id,_page];
        }

    }else{
        
        if ([QYUserDefaults objectForKey:self.disData.id]) {
            
            NSString * pageSelect = [QYUserDefaults objectForKey:self.disData.id];
            _webString= [NSString stringWithFormat:@"http://appview.qyer.com/bbs/thread-%@-%@.html?track_app_version=6.9.3",self.disData.id,pageSelect];
        }else{
            
            _webString= [NSString stringWithFormat:@"http://appview.qyer.com/bbs/thread-%@-%ld.html?track_app_version=6.9.3",self.disData.id,_page];
        }

        
    }
    
    NSURL * url = [NSURL URLWithString:_webString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];
    self.webView = webView;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectViewDissmiss:)];
    tap.delegate = self;
    [self.webView addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WebRefresh:) name:@"refreshWebView" object:nil];
}

- (void)WebRefresh:(NSNotification *)noti{
    
    NSLog(@"%@",noti.object);
    NSString * str = noti.object;
//    if (_page == [str integerValue]||_page != 1) {
//        return;
//    }
    _page = [str integerValue];
    if (self.data) {
        [QYUserDefaults setObject:@(_page) forKey:self.data.id];
        [QYUserDefaults synchronize];
        [self.pageBtn setTitle:[NSString stringWithFormat:@"%ld/%ld页",_page,[self.data.replys integerValue]>9?[self.data.replys integerValue]%9==0?[self.data.replys integerValue]/9:[self.data.replys integerValue]/9+1:1] forState:UIControlStateNormal];
        
        NSString * strUrl= [NSString stringWithFormat:@"http://appview.qyer.com/bbs/thread-%@-%ld.html?track_app_version=6.9.3",self.data.id,_page];
        NSURL * url = [NSURL URLWithString:strUrl];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else{
        
        [QYUserDefaults setObject:@(_page) forKey:self.disData.id];
        [QYUserDefaults synchronize];
        [self.pageBtn setTitle:[NSString stringWithFormat:@"%ld/%ld页",_page,[self.disData.reply_num integerValue]>9?[self.disData.reply_num integerValue]%9==0?[self.disData.reply_num integerValue]/9:[self.disData.reply_num integerValue]/9+1:1] forState:UIControlStateNormal];
        
        NSString * strUrl= [NSString stringWithFormat:@"http://appview.qyer.com/bbs/thread-%@-%ld.html?track_app_version=6.9.3",self.disData.id,_page];
        NSURL * url = [NSURL URLWithString:strUrl];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
   
}

- (NSMutableArray *)pageArray{
    
    if (!_pageArray) {
        _pageArray = [NSMutableArray array];
    }
    return _pageArray;
}

- (NSMutableArray *)imagesArray{
    
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (void)setupNavgationBarAndTabBar{
    
    UIView * buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-49, Screen_Width, 49)];
    buttomView.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:buttomView];
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, buttomView.width, 1);
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [buttomView.layer addSublayer:layer];
    
    UIButton * pageBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 10,  50, 29)];
    pageBtn.backgroundColor = [UIColor whiteColor];
    pageBtn.layer.cornerRadius = 4;
    pageBtn.layer.masksToBounds = YES;
    pageBtn.layer.borderWidth = 1;
    pageBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    if (self.data) {
        
        if ([QYUserDefaults objectForKey:self.data.id]) {
            
            NSString * pageSelect = [QYUserDefaults objectForKey:self.data.id];
            [pageBtn setTitle:[NSString stringWithFormat:@"%@/%ld页",pageSelect,[self.data.replys integerValue]>9?[self.data.replys integerValue]%9==0?[self.data.replys integerValue]/9:[self.data.replys integerValue]/9+1:1] forState:UIControlStateNormal];
        }else
        {
            [pageBtn setTitle:[NSString stringWithFormat:@"%d/%ld页",1,[self.data.replys integerValue]>9?[self.data.replys integerValue]%9==0?[self.data.replys integerValue]/9:[self.data.replys integerValue]/9+1:1] forState:UIControlStateNormal];
        }

    }else{
        
        if ([QYUserDefaults objectForKey:self.disData.id]) {
            
            NSString * pageSelect = [QYUserDefaults objectForKey:self.disData.id];
            [pageBtn setTitle:[NSString stringWithFormat:@"%@/%ld页",pageSelect,[self.disData.reply_num integerValue]>9?[self.disData.reply_num integerValue]%9==0?[self.disData.reply_num integerValue]/9:[self.disData.reply_num integerValue]/9+1:1] forState:UIControlStateNormal];
        }else
        {
            [pageBtn setTitle:[NSString stringWithFormat:@"%d/%ld页",1,[self.disData.reply_num integerValue]>9?[self.disData.reply_num integerValue]%9==0?[self.disData.reply_num integerValue]/9:[self.disData.reply_num integerValue]/9+1:1] forState:UIControlStateNormal];
        }

    }
    pageBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    pageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [pageBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [pageBtn addTarget:self action:@selector(pageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttomView addSubview:pageBtn];
    self.pageBtn = pageBtn;
    
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 21, 18);
    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = bar;
    
    
}

- (void)pageButtonClick:(UIButton *)btn{
    
    _selectView = [[SelectPageView alloc]initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, 200)];
    if (self.data) {
        _selectView.hotData = self.data;
    }else{
        _selectView.disData = self.disData;
    }
    
   // _selectView.pageList = [self.pageArray mutableCopy];
    [self.view addSubview:_selectView];
    [_selectView show];
    
}

- (void)selectViewDissmiss:(UITapGestureRecognizer *)tap{
    
    if ([self.view.subviews containsObject:_selectView]) {
        [_selectView dissmiss];
    }

}

#pragma mark - WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.navigationItem.backBarButtonItem.enabled = self.webView.canGoBack;
    //self.forawrdItem.enabled = self.webView.canGoForward;
    
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName('img');\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    _pageArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
//    if (_pageArray.count >= 2) {
//        [_pageArray removeLastObject];
//    }
    //urlResurlt 就是获取到得所有图片的url的拼接；_pageArray就是所有Url的数组
    
    //添加图片可点击js
    [webView stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     img.onclick=function(){\
     window.location.href='image-preview:'+this.src}\
     }\
     }"];
     
   [webView stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
    
    NSLog(@"%@",_pageArray);
    
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}

//在这个方法中捕获到图片的点击事件和被点击图片的url
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //path 就是被点击图片的url
        JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
        imageInfo.imageURL = [NSURL URLWithString:path];
        
        // Setup view controller
        JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                               initWithImageInfo:imageInfo
                                               mode:JTSImageViewControllerMode_Image
                                               backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
        
        // Present the view controller.
        [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
       // NSLog(@"%@",path);
        [self.imagesArray addObject:path];
        return NO;
    }
    return YES;
}

#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}


- (void)backButton{
    
    [self.navigationController popViewControllerAnimated:YES];
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
