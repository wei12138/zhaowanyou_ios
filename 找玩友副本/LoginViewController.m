//
//  LoginViewController.m
//  找玩友
//
//  Created by 军魏 on 14-8-12.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "LoginViewController.h"
#import "ASIFormDataRequest.h"
#import "VicinityViewController.h"
#import "LoginCheck.h"
#import "ShowPlayViewController.h"
#import "MessageViewController.h"
#import "PlayFriendsViewController.h"
#import "TabBarViewController.h"
#import "ReleaseWorkViewController.h"
#import "JSONKit.h"


@interface LoginViewController ()<UITextFieldDelegate,ASIHTTPRequestDelegate>

@end
#define Method @"m"
#define DataValue @"data"
#define Post_type @"type"
#define Post_pass @"password"
#define Post_account @"account"
#define Content @"User"
static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";

@implementation LoginViewController
{
    enum Check_State Rphone;
    enum Check_State Rpassword;
    enum Check_State LuserName;
    enum Check_State Lpassword;
    NSString* Re_phone;
    NSString* Re_password;
    NSString* L_UserName;
    NSString* L_passwoed;
    NSString* loginType;      //验证登录类型 0表示电话号码登录  1表示用户名登录
     TabBarViewController *tabBarView;
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
       
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginScroView.delegate = self;
   
    UIImageView* image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test_login_bg4"]];
    image1.frame = CGRectMake(0, 0, 320, 460);
    
    
    UIImageView* image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test_login_bg3 2"]];
    image2.frame = CGRectMake(320, 0, 320, 460);
    
    UIImageView* image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test_login_bg1 2"]];
    image3.frame = CGRectMake(640, 0, 320, 460);
    
    UIImageView* image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test_login_bg2"]];
    image4.frame = CGRectMake(960, 0, 320, 460);
    
    self.loginScroView.delegate = self;
    self.loginScroView.contentSize = CGSizeMake(1280, 480);
    [self.loginScroView addSubview:image1];
    [self.loginScroView addSubview:image2];
    [self.loginScroView addSubview:image3];
    [self.loginScroView addSubview:image4];
    
    //初始化验证状态机
    Rpassword = Erro_State;
    Rphone = Erro_State;
    Lpassword = Erro_State;
    LuserName = Erro_State;
    
 
    // Do any additional setup after loading the view from its nib.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
	self.loginPageControl.currentPage = offset.x / 320.0f;
  
}

#pragma 密码输入 帐号输入  注册手机  注册密码  输入判断
-(void) textFieldDidEndEditing:(UITextField *)textField
{
    
    switch (textField.tag) {
        case Tag_UserName:
            if ([textField.text isEqual:@""]) {
                _login_errLabel.text = @"*用户名不能为空";
                LuserName = Erro_State;
                return;
            }
            if([Valid isValiPhoneNumber:textField.text])
            {
                NSLog(@"手机号正确");
                LuserName = login_UserName_Correct;
                L_UserName = textField.text;
                loginType = @"0";
                return;
            }

            else  if ([Valid isValiPassword:textField.text] ) {
                NSLog(@"用户名正确");
                LuserName = login_UserName_Correct;
                L_UserName = textField.text;
                loginType = @"1";
            }
            else
            {
                _login_errLabel.text = @"*用户名格式不正确";
                LuserName = Erro_State;
            }
            break;
            
         case Tag_UserPassword:
            if ([textField.text isEqual:@""]) {
                _login_errLabel.text = @"*密码不能为空";
                Lpassword = Erro_State;
                return;
            }
            if ([Valid isValiPassword:textField.text]) {
                NSLog(@"密码格式正确!!!");
                Lpassword = login_Password_Correct;
                L_passwoed = textField.text;
            }
            else
            {
                Lpassword = Erro_State;
            }
            break;
            
        case Tag_PhoneNumber:
            if ([textField.text isEqualToString:@""]) {
                _registerErrLabel.text = @"*手机号码不能为空";
                Rphone = Erro_State;
                return;
            }
            if ([Valid isValiPhoneNumber:textField.text]) {
                Rphone = register_Phone_Correct;
                Re_phone = textField.text;
                NSLog(@"手机号匹配成功！！！！！");
            }
            else
            {
                NSLog(@"手机号匹配失败");
                _registerErrLabel.text = @"*手机号码格式不正确";
               // [_registerErrLabel sizeToFit];
                Rphone = Erro_State;
                _registerErrLabel.textAlignment = UITextAlignmentCenter;
            }
            
            break;
            
        case Tag_RegisterPassword:
            if ([textField.text isEqualToString:@""]) {
                _registerErrLabel.text = @"*密码号码不能为空";
                Rpassword = Erro_State;
                return;
            }
            
            if ([Valid isValiPassword:textField.text]) {
                Rpassword = register_PassWord_Correct;
                Re_password = textField.text;
                NSLog(@"密码匹配成功!!!!");
            }
            else
            {
                NSLog(@"密码匹配失败!!!!");
                Rpassword = Erro_State;
                _registerErrLabel.text = @"*密码格式不正确";
               // [_registerErrLabel sizeToFit];
                 _registerErrLabel.textAlignment = UITextAlignmentCenter;
            }
            
            break;
    }
}

-(IBAction)RegisterView
{
    [self.passWord resignFirstResponder];
    [self.phoneNumber resignFirstResponder];
    if (Rphone == register_Phone_Correct && Rpassword == register_PassWord_Correct) {
    RegisterPersonViewController*  personRegister = [[RegisterPersonViewController alloc] init];
       
        [personRegister GetData:Re_phone and:Re_password];
      
    [self presentViewController:personRegister animated:YES completion:nil];
    [self down];
    [RJBlurRegisterView dismiss];
}
  else
  {
          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请完善信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
         [alertView show];
  }

}



-(IBAction)LoginPopView
{
   RJBlurLoginView = [[RJBlurAlertView alloc] initWithContentView:PopLoginView];
    RJBlurLoginView.delegate = self;
    self.UserName.delegate = self;
    self.UserPass.delegate = self;
    self.UserName.tag = Tag_UserName;
    self.UserPass.tag = Tag_UserPassword;
   
    [RJBlurLoginView show];
}

-(void) down
{
    self.UserName.delegate = nil;
    self.UserPass.delegate = nil;
    self.passWord.delegate = nil;
    self.phoneNumber.delegate = nil;
    RJBlurLoginView.delegate = nil;
    RJBlurRegisterView.delegate = nil;
}

-(IBAction)RegisterPopView
{
    RJBlurRegisterView = [[RJBlurAlertView alloc] initWithContentView:RegPopView];
    RJBlurRegisterView.delegate = self;
    self.passWord.delegate = self;
    self.phoneNumber.delegate = self;
    self.passWord.tag= Tag_RegisterPassword;
    self.phoneNumber.tag = Tag_PhoneNumber;
   
    [RJBlurRegisterView show];
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Dispose of any resources that can be recreated.
}
-(IBAction) back
{
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"登录页面关闭!");}];
    [RJBlurLoginView dismiss];
    [self down];
}

-(IBAction) Login
{
    [self.UserName resignFirstResponder];
    [self.UserPass resignFirstResponder];
    if (Lpassword == login_Password_Correct && LuserName == login_UserName_Correct) {
        NSLog(@"密码格式验证成功  登录类型 %@",loginType);
        [self putLoginMessageToWeb:loginType andPassword:L_passwoed andAccount:L_UserName];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请完善信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];

    }
}

-(void) putLoginMessageToWeb:(NSString*) Ltype andPassword:(NSString*) Lpass andAccount:(NSString*) Laccount
{
    NSDictionary* postData = @{Post_type: Ltype,
                               Post_pass: Lpass,
                               Post_account:Laccount
                               };
    
    NSString* path = [baseURL stringByAppendingString:Content];
    NSString* postJson = [postData JSONString];
    
    NSDictionary* dic = @{Method:@"login",
                          DataValue:postJson};
    [self postRequestToWeb:path andDic:dic];
}

-(void) postRequestToWeb:(NSString*) path andDic:(NSDictionary*) dict
{
    
    NSURL* url = [[NSURL alloc] initWithString:path];
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    for (NSString* key in dict) {
        [request setPostValue:[dict objectForKey:key] forKey:key];
    }
    
    request.delegate = self;
    [request setTimeOutSeconds:10.0];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];
   
    if (request.error) {
        NSLog(@"登录错误  %@",request.error);
    }

}

-(void) requestFinished:(ASIHTTPRequest *)request
{
    NSArray* JSONarray = [request.responseString objectFromJSONString];
    if (JSONarray != NULL) {
        NSLog(@"用户数据为   %@",JSONarray);
        //把登录后获得的数据广播到APP中
        NSString*   user_id = [JSONarray valueForKey:@"user_id"];
    
        LoginCheck* check = [LoginCheck sharedLoginCheck];
        [check changeCheckValue:true];
        [check setUserId:user_id];
        
        [self down];
        [RJBlurLoginView dismiss];
         [self removeFromParentViewController];
        [self setupTurnView];
       
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码或者用户名错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];

    }
}
#pragma 登录成功跳转界面
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

-(IBAction)selectView
{
    [tabBarView ClickRelease];
}

@end
