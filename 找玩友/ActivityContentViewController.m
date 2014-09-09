//
//  ActivityContentViewController.m
//  找玩友
//
//  Created by 军魏 on 14-9-2.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ActivityContentViewController.h"
#import "LoginCheck.h"
#import "getCurrentTime.h"
#import "localInformation.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@interface ActivityContentViewController ()<UITextViewDelegate,ASIHTTPRequestDelegate>

@end
#define Content @"Activity"
#define Method @"m"
#define Method_value @"post"
#define Data @"data"

static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";
@implementation ActivityContentViewController
{
    NSString* contentString;
    NSString* startTime;
    NSString* endTime;
    NSString* AssemPlace;
    NSString* limit;
    NSString* Cost;
    NSString* latitude;
    NSString* longtitude;
    NSString* address;
    NSString* cityCode;
    NSString* userID;
    NSString* currentTime;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"发布内容";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem* doneBar = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(ReActivity)];
    self.navigationItem.rightBarButtonItem = doneBar;
    // Do any additional setup after loading the view from its nib.
}

-(void) getDataFromReleaseActivityStartTime:(NSString *)Stime andEndtime:(NSString *)Etime andAssem:(NSString *)Place andLimited:(NSString *)limite andCost:(NSString *)cost
{
    LoginCheck* check = [LoginCheck sharedLoginCheck];
    localInformation* local = [localInformation shareLocalInformation];
    startTime = Stime;
    endTime = Etime;
    AssemPlace = Place;
    Cost = cost;
    limit = limite;
    address = [local getAddr];
    latitude = [local getLat];
    longtitude = [local getLon];
    userID = [check getUserId];
    currentTime = [getCurrentTime getCurrent];
    cityCode = @"75";
}

-(BOOL) checkNullAndBlank
{
    if (latitude == NULL || [latitude isEqualToString:@""]) {
        return false;
    }
    if (longtitude == NULL || [longtitude isEqualToString:@""]) {
        return false;
    }
    if (address == NULL || [address isEqualToString:@""]) {
        return false;
    }
    if (contentString == NULL || [contentString isEqualToString:@""]) {
        return false;
    }
    return true;
}

-(void) ReActivity
{
    [self.ContentTextView resignFirstResponder];
    contentString = self.ContentTextView.text;
    if ([self checkNullAndBlank]) {
      
        [self putActivityMessageToWeb];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"请完善信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) putActivityMessageToWeb
{
    NSDictionary*   postData = @{
                               @"user_id": userID,
                               @"post_time":currentTime,
                               @"post_addr":address,
                               @"activity_start_time":startTime,
                               @"activity_content":contentString,
                               @"limit_people_num":limit,
                               @"end_time":endTime,
                               @"activity_cost":Cost,
                               @"assembling_place":AssemPlace,
                               @"city_code" :cityCode,
                               @"activity_longitude":longtitude,
                               @"activity_latitude":latitude
                               };
    
    NSString* path = [baseURL stringByAppendingString:Content];
   
    NSString* postJson = [postData JSONString];
    NSDictionary* dict = @{Method: Method_value,Data:postJson};
    [self postRequestToWeb:path andDictionary:dict];
}

-(void) postRequestToWeb:(NSString*) path andDictionary:(NSDictionary*) dic
{
    NSURL *url = [NSURL URLWithString:path];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url] ;
    for (NSString *key in dic) {
        [request setPostValue:[dic objectForKey:key] forKey:key];
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
    //2表示成功登录
    if ([[request responseString] isEqualToString:@"2"]) {
        UIAlertView* Alert = [[UIAlertView alloc] initWithTitle:@"发布成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [Alert show];
        request.delegate = nil;
        self.ContentTextView.delegate = nil;
        //跳转到发布选择界面
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    //1表示登录失败
    if ([[request responseString] isEqualToString:@"1"]) {
        UIAlertView* Alert = [[UIAlertView alloc] initWithTitle:@"发布失败" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [Alert show];
        request.delegate = nil;
    }
}
@end
