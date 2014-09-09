//
//  MessageViewController.m
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "MessageViewController.h"
#import "LoginCheck.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
#import "AboutMeViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";
@interface MessageViewController ()<ASIHTTPRequestDelegate>

@end
#define Method @"m"
#define Method_value @"get"
#define Post_Id @"user_id"
#define Content @"News"

@implementation MessageViewController
{
    LoginCheck* loginCheck;
     NSArray* dataArray;
      UIImageView* views[100];
    NSString* userID;
    MessageScro* message;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"消息";
        self.tabBarItem.image = [UIImage  imageNamed:@"Message24px"];
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
        [self.tabBarController removeFromParentViewController];
    };
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
        self.tabBarController.selectedIndex = 0;
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
        self.tabBarController.selectedIndex = 0;
    };
}

-(void) viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;    
     loginCheck = [LoginCheck sharedLoginCheck];
    userID = [loginCheck getUserId];
    if ([loginCheck returnCheckValue] == false) {
        self.MessageTableView.hidden = YES;
        [self setupAlertView];
        return;
    }
    else
    {
        [self packegMessageToWeb];
        self.MessageTableView.hidden = NO;
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    message = [[MessageScro alloc] init];
    self.MessageTableView.delegate = self;
    self.MessageTableView.dataSource = self;
    //[self.view addSubview:Messages];
           // Do any additional setup after loading the view from its nib.
}

#pragma 表格协议

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [dataArray count]) {
        
        return;
    }
    else
    {
        
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
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
    /*
    if(indexPath.section == [dataArray count])
    {
        cell.textLabel.text = @"点击查看更多";
        
        cell.textAlignment = UITextAlignmentCenter;
        return cell;
    }
     */
    [cell.contentView  addSubview: [message createView:cell.frame andIndex:0]];
       //为每一个单元格添加一个UIimgeview  用来接收下载的图片
    views[indexPath.section] = [[UIImageView alloc] init ];
    views[indexPath.section].frame = CGRectMake(5, 3, 40, 40);
    [views[indexPath.section] sd_setImageWithURL:[[dataArray objectAtIndex:indexPath.section] valueForKey:@"photo"] placeholderImage:[UIImage imageNamed:@"gray_logo.png"]];
    views[indexPath.section] = [CircleImage returnCircleImageView:views[indexPath.section] andFrame:views[indexPath.section].frame];
    //   NSLog(@"head image number is %i   and section number %i",headImage.tag,indexPath.section);
    [cell.contentView addSubview:views[indexPath.section]];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}



-(IBAction)clickFriends
{
    AboutMeViewController* me = [[AboutMeViewController alloc] init];
    [self.navigationController pushViewController:me animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) click
{
    NSLog(@"Click!! me");
}

-(void) packegMessageToWeb
{
    NSDictionary* dic = @{Method:Method_value,Post_Id:userID};
    NSString* path = [baseURL stringByAppendingString:Content];

    [self getMessageFromWeb:path and:dic];
}

-(void) getMessageFromWeb:(NSString*) path and:(NSDictionary*) dic
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
      NSLog(@"获取的消息数据为%@",[[request responseString] objectFromJSONString]);
}

@end
