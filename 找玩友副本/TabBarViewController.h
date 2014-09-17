//
//  TabBarViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-3.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VicinityViewController.h"
#import "ShowPlayViewController.h"
#import "ReleaseMenuViewController.h"
@interface TabBarViewController : UITabBarController
{
   
}

@property(strong,nonatomic) UINavigationController* releaseNavigation;
-(void) ClickRelease;
@end
