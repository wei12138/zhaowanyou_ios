//
//  ShowPlayViewController.m
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ShowPlayViewController.h"
#import "ShowPlayCellView.h"
#import "AboutMeViewController.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
#import "LoginCheck.h"

static NSString* baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";

@interface ShowPlayViewController ()

@end

@implementation ShowPlayViewController
{
    NSArray* dataArray;
    ShowPlayCellView* showPlayCellView;
    UIImageView* views[100];    //图片匹配模式
    bmkLoction* bmkl;
    LoginCheck* loginCheck;
}
//POST 参数宏定义
#define Content @"Interest"
#define Method @"m"
#define Method_newest @"newest"
#define postData_city_code @"city_code"
#define postData_longitude @"longitude"
#define postData_latitude  @"latitude"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"晒玩点";
        self.tabBarItem.image = [UIImage imageNamed:@"ShowPlay24px"];
        self.tabBarItem.tag = 1;
       // self.view.backgroundColor = [UIColor  yellowColor];
       
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.LocationLabel.text = @"";
    [bmkl setup];
    [bmkl start];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [bmkl down];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //刷新
    self.ShowPlayTableView.delegate = self;
    self.ShowPlayTableView.dataSource = self;
    self.ShowPlayTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
   bmkl = [[bmkLoction alloc] init];
   bmkl.delegate = self;
   [bmkl setup];
    loginCheck = [LoginCheck sharedLoginCheck];
    // Do any additional setup after loading the view from its nib.
}

-(void) getlatitude:(NSString *)latitude andlongtitude:(NSString *)longtitude
{
    
}

#pragma 定位数据回调
-(void) getLocData:(NSString *)locaString
{
    self.LocationLabel.text = locaString;
}

-(IBAction) clickFriends
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

-(void) turnToSceneryDetail
{
    SceneryDetailViewController* sceneryDetailView = [[SceneryDetailViewController alloc] init];
    [self.navigationController pushViewController:sceneryDetailView animated:YES];
   
}

#pragma 表格视图布局
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3+[dataArray count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     表格布局分为三节
     第一节为背景图片  高度128 宽度320
     第二节为Segement选择器节  高度43 宽度320
     第三节为玩点信息节 高度根据玩点内容进行调整
     */
    
    
    if (indexPath.section == 0) {
        return 128;
    }
    if (indexPath.section == 1) {
        return 43;
    }
    if (indexPath.section == 2+[dataArray count]) {
        return 58;
    }
    
    UITextView* ActivityText = [[UITextView alloc] init];
    ActivityText.text = [[dataArray objectAtIndex:indexPath.section-2] valueForKey:@"in_content"];
    [ActivityText sizeToFit]; //根据内容计算单元格高度
    
    return 110+ActivityText.frame.size.height;

    
}



-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     表格布局分为三节
     第一节为背景图片  高度128 宽度320
     第二节为Segement选择器节  高度43 宽度320
     第三节为玩点信息节 高度根据玩点内容进行调整
     */
     //第一节
    UITableViewCell* cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selected = NO;
    }

    for(UIView *view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
        
    }
    cell.textLabel.text = nil;
    cell.backgroundView = nil;
    
    if (indexPath.section == 0) {
        
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beijing.jpeg"]];
        return cell;
    }
    //第二节
    if (indexPath.section == 1) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"segment"];
        
        self.segementControl.frame = CGRectMake(cell.frame.size.width/2-self.segementControl.frame.size.width/2, cell.frame.size.height/2-self.segementControl.frame.size.height/2, 161, 30);
        [cell.contentView addSubview:self.segementControl];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selected = NO;
        return cell;
    }
    if (indexPath.section == [dataArray count]+2) {
        UIButton* moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 58)];
        [moreButton addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:moreButton];
        cell.textLabel.text = @"点击查看更多";
        cell.textAlignment = UITextAlignmentCenter;
       
        return cell;
    }
    //第三节
    int index = (int)indexPath.section-2;
    
    [cell.contentView addSubview:[showPlayCellView createShowPlayCellView:index andCellFrame:cell.frame]];
    views[index] = [[UIImageView alloc] init];
    views[index].frame = CGRectMake(10, 8, 50, 50);
    views[index] = [CircleImage returnCircleImageView:views[index] andFrame:views[index].frame];
    [views[index] sd_setImageWithURL:[[dataArray objectAtIndex:index] valueForKey:@"photo"] placeholderImage:[UIImage imageNamed:@"gray_logo.png"]];
    //   NSLog(@"head image number is %i   and section number %i",headImage.tag,indexPath.section);
    [cell.contentView addSubview:views[index]];
    
    return cell;
    
}
-(void) Click
{
  
      [self getShowPlayListWithCityCode:@"75" andLatitude:@"12.21212" andLongitude:@"12.13322"];
}

#pragma 网络请求
- (void)getShowPlayListWithCityCode:(NSString *)cityCode andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
   
    NSString *path = [baseURL stringByAppendingString:Content];
   
    NSDictionary *dict = @{Method: Method_newest,postData_city_code:cityCode,postData_latitude:latitude,postData_longitude:longitude};
    
    [self postJsonDataToServerWithPath:path postKeyValueDict:dict];
    
}


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

-(void) requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"showplay  data is  %@",[[request responseString] objectFromJSONString]);
    dataArray = [[request responseString] objectFromJSONString];
    showPlayCellView = [[ShowPlayCellView alloc] init];
    [showPlayCellView getData:dataArray];
    [self.ShowPlayTableView reloadData];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
    // Dispose of any resources that can be recreated.
}

@end
