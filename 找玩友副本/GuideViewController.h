//
//  GuideViewController.h
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//


#import "VicinityViewController.h"
#import "ShowPlayViewController.h"
#import "MessageViewController.h"

#import "TabBarViewController.h"
#import "ReleaseWorkViewController.h"
#import "PlayFriendsViewController.h"
@interface GuideViewController : UIViewController
{
    IBOutlet UIButton*  button;
    IBOutlet UIButton*  buttonItem;
   
}

@property (strong,nonatomic) TabBarViewController *tabBarView;


-(void) initGuide;
-(IBAction) firstpressed;
-(IBAction) OnClick;
@end
