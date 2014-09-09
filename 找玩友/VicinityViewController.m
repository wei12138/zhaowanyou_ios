//
//  VicinityViewController.m
//  找玩友
//
//  Created by 军魏 on 14-8-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "VicinityViewController.h"
#import "CircleImage.h"
#import "LoginCheck.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
#import "AboutMeViewController.h"
#import "localInformation.h"
@interface VicinityViewController ()

@end
#define Content @"Activity"
#define Method @"m"
#define UserID @"user_id"
#define ActivityID @"activity_id"
#define PostData @"data"
#define Method_post @"post"
#define Method_getList @"getList"

static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";

@implementation VicinityViewController
{
    NSArray* dataArray;
    cellViewSetup* cellViewArray;
    UITextView* ActivityText;
    NSArray* imageArray;
    LoginCheck* loginCheck;
    UIImageView* views[100]; //UIimgeView数组 用来给单元格加上UIImageView 方便接收回调数据
    localInformation* localInfo;
}
-(void) viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [bmkl setup];
    [bmkl start];  //开启定位服务与地理反编码协议;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"附近";
        self.tabBarItem.image = [UIImage imageNamed:@"Vcinity24px"];
        
    }
    return self;
}
-(void) setupAlertView
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"登录提醒" contentText:@"请您先登录,再查看" leftButtonTitle:@"去登录" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        NSLog(@"left button clicked");
        LoginViewController* loginView = [[LoginViewController alloc] init];
        [self presentViewController:loginView animated:YES completion:^{NSLog(@"登录界面打开");}];
       
    };
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
    };
}

-(void) viewDidDisappear:(BOOL)animated
{
    [bmkl down];
    //关闭定位服务与地理反编码协议;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // headImage = [[UIImageView alloc] init];
    self.ActivityListView.delegate = self;
    self.ActivityListView.dataSource = self;
    self.ActivityListView.separatorStyle =UITableViewCellSeparatorStyleNone;
     bmkl = [[bmkLoction alloc] init];
    bmkl.delegate = self;
    [bmkl setup];
    loginCheck = [LoginCheck sharedLoginCheck];  //登录检测单例
    localInfo = [localInformation shareLocalInformation]; //定位信息传递类
      // Do any additional setup after loading the view from its nib.
}

#pragma 获取地理坐标
-(void)  getLocData:(NSString *)locaString
{
    self.LocalMessageLable.text = locaString;
    self.LocalMessageLable.font = [UIFont systemFontOfSize:15.0f];
    [localInfo setLocalInfoAddress:locaString];
}

-(void) getlatitude:(NSString *)latitude andlongtitude:(NSString *)longtitude
{
    [localInfo setLocalInfolatitude:latitude andlongtitude:longtitude];
     NSLog(@"经纬度是 %@ %@",latitude,longtitude);
}

-(IBAction) ClickFrinds
{
    if ([loginCheck returnCheckValue] == true) {
        
    AboutMeViewController *me = [[AboutMeViewController alloc] init];
    [self.navigationController pushViewController:me animated:YES];
    }
    else
    {
        [self setupAlertView];
    }
}

#pragma 表格视图
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [dataArray count]) {
        [self getActivityListWithCityCode:@"75" andLatitude:@"30.893223" andLongitude:@"103.60196"];
        return;
    }
    else
    {
        ActivityDeatailViewController* detailView = [[ActivityDeatailViewController alloc] init];
        [detailView reciveDict:[dataArray objectAtIndex:indexPath.section]];
        [self.navigationController pushViewController:detailView animated:YES];
    }    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return [dataArray count] +1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  ];
    
    for(UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.textLabel.text = nil;
    if (cell == nil) {
        
              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selected = NO;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
   
    if(indexPath.section == [dataArray count])
    {
        cell.textLabel.text = @"点击查看更多";
     
        cell.textAlignment = UITextAlignmentCenter;
        return cell;
    }

     [cell.contentView addSubview:[cellViewArray setupCellView:indexPath.section andCellFrame:cell.frame ]];
    NSLog(@"cell width is %f",cell.frame.size.width);
      //为每一个单元格添加一个UIimgeview  用来接收下载的图片
    views[indexPath.section] = [[UIImageView alloc] init ];
     views[indexPath.section].frame = CGRectMake(10, 8, 50, 50);
    [views[indexPath.section] sd_setImageWithURL:[[dataArray objectAtIndex:indexPath.section] valueForKey:@"photo"] placeholderImage:[UIImage imageNamed:@"gray_logo.png"]];
    views[indexPath.section] = [CircleImage returnCircleImageView:views[indexPath.section] andFrame:views[indexPath.section].frame];
    //   NSLog(@"head image number is %i   and section number %i",headImage.tag,indexPath.section);
    [cell.contentView addSubview:views[indexPath.section]];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [dataArray count]) {
        return 58;
    }
    
    ActivityText = [[UITextView alloc] init];
    ActivityText.text = [[dataArray objectAtIndex:indexPath.section] valueForKey:@"activity_content"];
    [ActivityText sizeToFit]; //根据内容计算单元格高度
    
       return 110+ActivityText.frame.size.height;
}
#pragma ActivityButton协议

-(void) activityGood
{
    NSLog(@"good caiwei love weijun");
}
#pragma 获得异步请求
- (void)postJsonDataToServerWithPath:(NSString *)path postKeyValueDict:(NSDictionary *)dict
{
    NSURL *url = [NSURL URLWithString:path];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url] ;
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
- (void)getActivityListWithCityCode:(NSString *)cityCode andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    NSDictionary *postData = @{
                               @"city_code": cityCode,
                               @"latitude": latitude,
                               @"longitude": longitude,
                               };
    NSString *path = [baseURL stringByAppendingString:Content];
    //发送的json数据
    NSString *postJson = [postData JSONString];
    NSDictionary *dict = @{Method: Method_getList,PostData:postJson};
     [self postJsonDataToServerWithPath:path postKeyValueDict:dict];
    
}

#pragma  异步请求完成 数据回调
-(void) requestFinished:(ASIHTTPRequest *)request
{
    
    dataArray = [[request responseString]objectFromJSONString];
  //  NSLog(@"%@",dataArray);
    cellViewArray = [[cellViewSetup alloc] init];
  //  NSLog(@"photo  is  %@",[[dataArray objectAtIndex:0]valueForKey:@"photo"]);
    cellViewArray.delegate = self;
    [cellViewArray getData:dataArray];
      
    [self.ActivityListView reloadData];
    request.delegate = nil;
        return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
