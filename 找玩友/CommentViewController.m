//
//  CommentViewController.m
//  找玩友
//
//  Created by 军魏 on 14-9-7.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "CommentViewController.h"
#import "localInformation.h"
#import "getCurrentTime.h"
#import  "ASIFormDataRequest.h"
#import "JSONKit.h"
static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";
@interface CommentViewController ()<ASIHTTPRequestDelegate,UITextViewDelegate>

@end

#define Content @"Comment"
#define Method @"m"
#define Method_value @"post"
#define Post_data @"data"
#define Post_type @"type"
#define Post_ownId @"owner_user_id"
#define Type_value @"0"  //类型0 表示发布活动评论


@implementation CommentViewController
{
    NSString*  own_Id;
    NSString*  user_Id;
    NSString*  user_Comment;  //评论内容
    NSString*  user_Address;  //评论者地址
    NSString*  user_Time;      //评论时间
    NSString*  own_activityId;  //活动ID
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) getACownerID:(NSString *)ACid andUserID:(NSString *)userID andActivityID:(NSString *)activityID
{
    localInformation* address = [localInformation  shareLocalInformation];
    if ([address getAddr] == NULL) {
        NSLog(@"地理位置获取失败");
        return;
    }
    user_Address = [address getAddr];
    own_Id = ACid;
    user_Id = userID;
    user_Time = [getCurrentTime getCurrent];
    own_activityId = activityID;
}

-(void) setupView
{
    UIBarButtonItem* doneBar = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(GoComment)];
    self.navigationItem.rightBarButtonItem = doneBar;
    self.CommetInputView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];  //初始化界面
    //初始化事件
     // Do any additional setup after loading the view from its nib.
}

#pragma 发表评论
-(void) GoComment
{
    [self.CommetInputView resignFirstResponder];
   
    user_Comment = self.CommetInputView.text;
    if (user_Comment != NULL && ![user_Comment isEqualToString:@""]) {
        NSLog(@"活动发起人ID %@",own_Id);
        NSLog(@"自己ID %@",user_Id);
        NSLog(@"自己的位置%@",user_Address);
        NSLog(@"发表的时间%@",user_Time);
        NSLog(@"内容为%@",user_Comment);
        NSLog(@"活动ID 为%@",own_activityId);
        [self packegAcComment];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"请讲信息填写完整" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void) packegAcComment
{
      NSDictionary* postData = @{@"id":own_activityId,
                                 @"owener_id":own_Id,
                                 @"user_id":user_Id,
                                 @"time":user_Time,
                                 @"address":user_Address,
                                 @"content":user_Comment,
                                 };
    NSString* path = [baseURL stringByAppendingString:Content];
    
    NSString* postJson = [postData JSONString];
    NSLog(@" json is  %@",postJson);
    NSDictionary* dict = @{Method:Method_value,
                           Post_data:postJson,
                           Post_ownId:own_Id,
                           Post_type:Type_value};
    
    [self putAcCommentToWeb:path and:dict];
    
}

-(void) putAcCommentToWeb:(NSString*) path and:(NSDictionary*) dic
{
    NSURL* url = [NSURL URLWithString:path];
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:url];
    for (NSString *key in dic) {
        [request setPostValue:[dic objectForKey:key] forKey:key];
    }

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
    NSLog(@"返回值%@",request.responseString);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
