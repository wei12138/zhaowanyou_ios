//
//  RegisterPersonViewController.m
//  找玩友
//
//  Created by 军魏 on 14-8-14.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "RegisterPersonViewController.h"
#import "VicinityViewController.h"
#import "LoginCheck.h"
#import "ShowPlayViewController.h"
#import "MessageViewController.h"
#import "PlayFriendsViewController.h"
#import "TabBarViewController.h"
#import "ReleaseWorkViewController.h"
#import "DateTrans.h"
#import "JSONKit.h"
#import "CircleImage.h"
#import "GTMBase64.h"
@interface RegisterPersonViewController ()<UITextFieldDelegate>

@end
//POST 参数宏定义
#define Method @"m"
#define Method_value @"register"
#define Method_photo @"upload"
#define Content @"User"
#define DataValue @"data"
#define Post_Name @"name"
#define Post_Gender @"gender"
#define Post_Phone @"telphone"
#define Post_Password @"password"
#define Post_BirthDay @"birthday"
#define Post_userImage @"photo"

static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";
@implementation RegisterPersonViewController
{
    NSString* userPhone;
    NSString* userPassword;
    NSString* userBirthday;
    NSString* userGender;
    NSString* userName;
    NSString* userId;
    TabBarViewController *tabBarView;
    NSString* userPhoto;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self setup];

  
   
}

-(void) GetData:(NSString *)phoneValue and:(NSString *)passValue
{
    userPassword = passValue;
    userPhone = phoneValue;
   
   
}

- (IBAction)selectImage:(id)sender {
    [self userBirthDayDown];
    [self userNameLabelDown];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"从相册选择",nil];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    actionSheet.tag = 0;  //操作表标签：1表示性别选择操作表 0代表头像选择选择
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self userBirthDayDown];
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self userNameLabelDown];
    return YES;
}
#pragma  关闭用户名输入框的键盘并且保存其中数据
-(void) userNameLabelDown
{
    [_user_Name_label resignFirstResponder];
    userName = _user_Name_label.text;

}
#pragma 关闭日期选择器,并且把日期转化为字符串赋值给生日标签
-(void) userBirthDayDown
{
    _user_Birthday_label.text = [DateTrans stringFromDate:_BirthDayPickerView.date];
    userBirthday = _user_Birthday_label.text;
    self.BirthDayPickerView.hidden = YES;
}

#pragma  初始化跳转界面
-(void) setupTurnView
{
    tabBarView = [[TabBarViewController alloc] init];
    
    
    //  _tabBarView.tabBar.delegate = self;
    buttonItem.backgroundColor = [UIColor clearColor];
    buttonItem.frame = CGRectMake(124, -5, 74, 58);
    
    VicinityViewController* vicinityView = [[VicinityViewController alloc] init];
    ShowPlayViewController* showPlayView = [[ShowPlayViewController alloc] init];
    ReleaseWorkViewController* releaseView = [[ReleaseWorkViewController alloc] init];
    MessageViewController*  messageView = [[MessageViewController alloc] init];
    PlayFriendsViewController* playFriends = [[PlayFriendsViewController alloc] init];
    
    UINavigationController* Vicinity;
    UINavigationController* showplay;
    Vicinity = [[UINavigationController alloc] initWithRootViewController:vicinityView];
    showplay = [[UINavigationController alloc] initWithRootViewController:showPlayView];
     UINavigationController*  message = [[UINavigationController alloc] initWithRootViewController:messageView];
    
    
    tabBarView.viewControllers = @[Vicinity,showplay,releaseView,message,playFriends];
    tabBarView.tabBar.selectedImageTintColor = [UIColor orangeColor];
    
    [tabBarView.tabBar addSubview:buttonItem];
     [self presentModalViewController:tabBarView animated:YES];
    [self removeFromParentViewController];
}

-(IBAction)pickDateView
{
    [self userNameLabelDown];
     self.BirthDayPickerView.hidden = NO;
}
-(IBAction)genderView
{
    [self userBirthDayDown];
    [self userNameLabelDown];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"男", @"女",nil];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    actionSheet.tag = 1;  //操作表标签：1表示性别选择操作表
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
    if (buttonIndex == 0) {
        NSLog(@"男");
        _user_gender_label.text = @"男";
        userGender = @"男";
    }
    else if(buttonIndex == 1) {
        NSLog(@"女");
        _user_gender_label.text = @"女";
        userGender = @"女";
    }
    else if(buttonIndex == 2) {
        NSLog(@"取消");
      }
        return;
    }
    if (actionSheet.tag == 0) {
        if (buttonIndex == 0) {
             NSLog(@"拍照");
            [self pickImageFromCamera];
        }
        else if(buttonIndex == 1) {
            [self pickImageFromAlbum];
              NSLog(@"从相册选择");
        }
        else if(buttonIndex == 2) {
            NSLog(@"取消");
        }
    }
}
#pragma 从相册选择
-(void) pickImageFromAlbum
{
    UIImagePickerControllerSourceType sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma 拍照选择
-(void) pickImageFromCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma 设置选中的照片
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker  dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选择照片界面退出");
    }];
    
    self.headImageVIew.image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData*  photoData = UIImageJPEGRepresentation(self.headImageVIew.image, 0.5);
    if ([photoData length] > 0) {
        userPhoto = [GTMBase64 encodeBase64Data:photoData];
         NSLog(@"转码成功!!");
    }
    self.headImageVIew = [CircleImage returnCircleImageView:self.headImageVIew andFrame:self.headImageVIew.frame];
    
}

-(BOOL)  infoCheck
{
        if (userName == NULL || [userName isEqualToString:@""]){
       // NSLog(@"user name %@",userName);
        return false;
    }
    
    if (userGender == NULL || [userGender isEqualToString:@""]) {
       // NSLog(@"Gender name %@",userGender);

        return false;
    }
    
    if (userBirthday == NULL||[userGender isEqualToString:@""]) {
      //  NSLog(@"birthday name %@",userBirthday);

        return false;
    }
    if (userPhoto == NULL || [userPhoto isEqualToString:@""]) {
        return false;
    }
    
    return true;
    
}

-(IBAction) registerUserInfo
{
    [self userBirthDayDown];
    [self userNameLabelDown];
    if ([self infoCheck]) {
        [self putUserInfoToWebName:userName andBirthday:userBirthday andPassword:userPassword andPhone:userPhone andGender:userGender andPhoto:userPhoto];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请完善信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];

    }
}

-(void) setup
{
    self.title = @"完善个人信息";
    _user_phone_label.text = userPhone;
    _user_phone_label.tag = 2;
    _user_phone_label.delegate = self;
    
    _user_Birthday_label.tag= 1;
    _user_Birthday_label.delegate = self;
 
    _user_Name_label.tag = 3;
    _user_Name_label.delegate = self;
    
    _user_gender_label.tag = 4;
    _user_gender_label.delegate = self;

}

-(void) endDelegate
{
    _user_Birthday_label.delegate = nil;
    _user_phone_label.delegate = nil;
    _user_Name_label.delegate = nil;
    _user_gender_label.delegate = nil;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
      self.BirthDayPickerView.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)backRegister
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma 图片上传请求



#pragma 注册信息网络请求
-(void)  putUserInfoToWebName:(NSString*) Name andBirthday:(NSString*) Birthday andPassword:(NSString*) Password andPhone:(NSString*) Phone andGender:(NSString*) Gender andPhoto:(NSString*) userphoto
{
    NSDictionary* postData=@{Post_Name:Name,Post_Gender:Gender,Post_BirthDay:Birthday,Post_Phone:Phone,Post_Password:Password};
    NSString *path = [baseURL stringByAppendingString:Content];
  
   
    NSString* postJson = [postData JSONString];
 
    NSDictionary* dic = @{Method:Method_value,DataValue:postJson,Post_userImage:userPhoto};
    [self postJsonDataToWebWithPath:path postKeyValueDict:dic];
}

- (void)postJsonDataToWebWithPath:(NSString *)path postKeyValueDict:(NSDictionary *)dict
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
    NSLog(@"user id is %@",request.responseString);
  
    if (![request.responseString isEqualToString:@"1"]) {
        LoginCheck* check = [LoginCheck sharedLoginCheck];
        [check changeCheckValue:true];
        [check setUserId:userId];
        NSLog(@"注册成功!!!");
        [self endDelegate];
        [self setupTurnView];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"注册失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma 事件点击跳转
-(IBAction)clickTurn
{
    [tabBarView ClickRelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    // Dispose of any resources that can be recreated.
}

@end
