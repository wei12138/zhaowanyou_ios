//
//  AboutMeViewController.m
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "AboutMeViewController.h"
#import "LoginCheck.h"
#import "DXAlertView.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";
@interface AboutMeViewController ()<ASIHTTPRequestDelegate>

@end

#define Content @"User"
#define Method @"m"
#define Method_value @"getUser"
#define Post_value @"user_id"
@implementation AboutMeViewController
{
    LoginCheck* loginCheck;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我";
        self.tabBarItem.image = [UIImage  imageNamed:@"AboutMe24px"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"AboutMeSelected24px"];
    }
    return self;
}
-(void) viewDidAppear:(BOOL)animated
{
      self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self packegUserInfo];

    // Do any additional setup after loading the view from its nib.
}

-(void) packegUserInfo
{
    loginCheck  = [LoginCheck sharedLoginCheck];

    NSLog(@"xxdsadasd %@",[loginCheck getUserId]);
    NSDictionary* dic = @{Method: Method_value,Post_value:[loginCheck getUserId]};
     [self getUserInformationFromWeb:dic];
}

-(void) getUserInformationFromWeb:(NSDictionary*) dict
{
    NSURL* url = [NSURL URLWithString:[baseURL stringByAppendingString:Content]];
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    for (NSString *key in dict) {
        [request setPostValue:[dict objectForKey:key] forKey:key];
    }
    //设置响应时间为10秒
    request.delegate = self;
    [request setTimeOutSeconds:10];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];
    
    if (request.error) {
        NSLog(@"网络错误 ：%@",request.error);
    }
}

-(void) requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"用户数据为%@",[[request responseString] objectFromJSONString]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
