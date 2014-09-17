//
//  ActivityDeatailViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-16.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ActivityDeatailViewController.h"
#import "CircleImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CommentViewController.h"
#import "LoginCheck.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
#import "AsynchronousRequest.h"
static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";
@interface ActivityDeatailViewController ()<AsynchronousRequestDelegate>
#define Method @"m"
#define MethodValue @"get"
#define activityOwn_id @"owner_id"
#define UrlContent @"Comment"
@end

@implementation ActivityDeatailViewController
{
    NSDictionary* Activitydict;
    UIImageView* userImg;
    UIImage* ReciveImage;
    NSArray* CommentArray;
    AcComment* acComment;
    UIImageView* views[100];   //图片缓冲 匹配单元格
    NSMutableArray* CommentImageArray;
    UIView *containerView;
    NSString*  ACuserID;
    NSString* activity_ID;
    LoginCheck* check; //登录检测类
    AsynchronousRequest* asy;  //网络处理请求类
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma 获取数据
-(void)reciveDict:(NSDictionary *)dic
{
    Activitydict = dic;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"活动详情";
    [self ActivityDetailTable_Setup];
    [self ID_Setup];
    [self getCommentPostValue:activity_ID];
    [self doneBar_Setup];
    check  = [LoginCheck sharedLoginCheck];
    // Do any additional setup after loading the view from its nib.
    CommentImageArray = [[NSMutableArray alloc] init];  //用户评论头像数组初始化
}

#pragma 确定导航栏按钮设置
-(void) doneBar_Setup
{
    UIBarButtonItem* doneBar = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStyleDone target:self action:@selector(CommentView)];
    self.navigationItem.rightBarButtonItem = doneBar;
}

#pragma 表格视图初始化
-(void) ActivityDetailTable_Setup
{
    self.ActivityDetailTableView.dataSource = self;
    self.ActivityDetailTableView.delegate = self;
    self.ActivityDetailTableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
}
#pragma 活动用户ID与活动评论ID初始化
-(void) ID_Setup
{
    ACuserID =[Activitydict valueForKey:@"user_id"];
    activity_ID = [Activitydict valueForKey:@"id"];
}




#pragma 用户评论头像数组初始化
-(void) CommentImageArray_Setup:(NSInteger) index
{
    for (int i = 0;i < index; i++) {
        UIImageView* image = [[UIImageView alloc] init];
        [CommentImageArray addObject:image];
    }
}

#pragma 评论界面
-(void) CommentView
{
    
    if ([check returnCheckValue] == false) {
        [self setupAlertView];
        return;
    }
    CommentViewController* CView = [[CommentViewController alloc] init];
    [CView getACownerID:ACuserID andUserID:[check getUserId] andActivityID:activity_ID];
    [self.navigationController pushViewController:CView animated:YES];
}


#pragma 表格协议

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return [CommentArray count];
    }
    return 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    if (indexPath.section == 0) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Activity"];
        cell.selected = NO;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        ActivityMessageInfo* viewInfo = [[ActivityMessageInfo alloc] init];
        [cell.contentView addSubview:[viewInfo InfoView:self.ActivityDetailTableView.backgroundColor andMessage:Activitydict]];
        userImg = [[UIImageView alloc] init];
        userImg.frame = CGRectMake(19, 5, 40, 37);
        userImg = [CircleImage returnCircleImageView:userImg andFrame:CGRectMake(19, 5, 40, 40)];
        [userImg setImageWithURL:[Activitydict valueForKey:@"photo"] placeholderImage:[UIImage imageNamed:@"gray_logo.png"]];
        [cell.contentView addSubview:userImg];
        return cell;
    }
    if (indexPath.section == 1) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Comment"];
        cell.selected = NO;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSString* CommentNumberString = [[NSNumber numberWithInteger:[CommentArray count]] stringValue];
        CommentNumberString = [NSString stringWithFormat:@"(%@)",CommentNumberString];
        NSString* CommentString = @"活动评论";
        CommentString = [CommentString stringByAppendingString:CommentNumberString];
        cell.textLabel.text = CommentString;
        
        return cell;
    }
    if (indexPath.section == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        for(UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCell"];
            cell.selected = NO;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell.contentView addSubview:[acComment createCommentView:indexPath.row andFrame:cell.frame]];
        UIImageView* headImage = [CommentImageArray objectAtIndex:indexPath.row];
        headImage.frame = CGRectMake(19, 5, 40, 40);
        headImage = [CircleImage returnCircleImageView:views[indexPath.row] andFrame:views[indexPath.row].frame];
        [headImage setImageWithURL:[[CommentArray objectAtIndex:indexPath.row] valueForKey:@"photo"] placeholderImage:[UIImage imageNamed:@"gray_logo.png"]];
        [cell.contentView addSubview:headImage];
        
        return cell;
    }
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 2;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 366;
    }
    if (indexPath.section == 1) {
        return 35;
    }
    if (indexPath.section == 2) {
        UITextView*  ActivityText = [[UITextView alloc] init];
        ActivityText.text = [[CommentArray objectAtIndex:indexPath.row] valueForKey:@"activity_content"];
        [ActivityText sizeToFit]; //根据内容计算单元格高度
        return 46+ActivityText.frame.size.height;
    }
    return 0;
}

-(void) AsyRequestFinished:(NSArray *)valueArray
{
    CommentArray = valueArray;
    [self CommentCell_Setup];
    asy.delegate = nil; //关闭数据协议服务
}

-(void) getCommentPostValue:(NSString*) activityId
{
    NSDictionary* dict = @{Method:MethodValue,activityOwn_id:activityId};
    NSString* pathUrl = [baseURL stringByAppendingString:UrlContent];
    
    asy = [[AsynchronousRequest alloc] init];
    [asy getRequestForServes:pathUrl andPostValue:dict andIsJson:YES];
}

#pragma 评论单元格视图初始化
-(void) CommentCell_Setup
{
    acComment = [[AcComment alloc] init];
    [acComment setupData:CommentArray];
    [self CommentImageArray_Setup:[CommentArray count]];
    [self.ActivityDetailTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
