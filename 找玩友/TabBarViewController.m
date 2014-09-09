//
//  TabBarViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-3.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "TabBarViewController.h"
#import "LoginCheck.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController
{
    LoginCheck* loginCheck;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     // [self.tabbarv]
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    loginCheck = [LoginCheck sharedLoginCheck];
 
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ClickRelease
{
    if ([loginCheck returnCheckValue] == true ) {
    ReleaseMenuViewController *MenuView = [[ReleaseMenuViewController alloc] init];
    self.releaseNavigation = [[UINavigationController alloc] initWithRootViewController:MenuView];
    [self presentViewController:self.releaseNavigation animated:YES completion:^{NSLog(@"选择活动页面打开!");}];
    }
    else
    {
        [self setupAlertView];
    }
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
