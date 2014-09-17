//
//  LoginViewController.h
//  找玩友
//
//  Created by 军魏 on 14-8-12.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJBlurAlertView.h"
#import "Valid.h"
#import "RegisterPersonViewController.h"


@interface LoginViewController : UIViewController<UIScrollViewDelegate,RJBlurAlertViewDelegate>
{
     IBOutlet UIView* PopLoginView;     //登录弹出界面
     IBOutlet UIView* RegPopView;       //注册弹出界面
    IBOutlet UIButton* buttonItem;
    RJBlurAlertView* RJBlurLoginView;
    RJBlurAlertView* RJBlurRegisterView;
 }

enum TAG_REGISTER_TEXTFIELD{
    
    Tag_UserName  = 100,      //登录用户名
    Tag_UserPassword ,        //登录密码
    Tag_PhoneNumber,          //注册手机号
    Tag_RegisterPassword,     //注册密码
};

#pragma 验证状态机
enum Check_State
{
    register_Phone_Correct,
    register_PassWord_Correct,
    login_UserName_Correct,
    login_Password_Correct,
    Erro_State,
};


@property(weak,nonatomic) IBOutlet UIPageControl* loginPageControl;
@property(weak,nonatomic) IBOutlet UIScrollView* loginScroView;
@property(weak,nonatomic) IBOutlet UIView* loginView;


@property (weak, nonatomic) IBOutlet UILabel *registerErrLabel;

@property(weak,nonatomic) IBOutlet UITextField* phoneNumber; //注册手机号
@property(weak,nonatomic) IBOutlet UITextField* passWord;

@property(weak,nonatomic) IBOutlet UITextField* UserName;
@property(weak,nonatomic) IBOutlet UITextField* UserPass;


@property (weak, nonatomic) IBOutlet UILabel *login_errLabel;



-(IBAction) RegisterView;
-(IBAction) LoginPopView;
-(IBAction) RegisterPopView;
-(IBAction) back;  //退出登录页面
-(IBAction) Login;
-(IBAction) selectView;
@end
