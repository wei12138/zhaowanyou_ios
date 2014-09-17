//
//  AboutMeViewController.h
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReleaseMenuViewController.h"
#import "PlayFriendsViewController.h"
@interface AboutMeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *userAgeAndStarLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLocationInfo;
@property (weak, nonatomic) IBOutlet UILabel *userRactivityLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRplayPoint;
@property (weak, nonatomic) IBOutlet UILabel *userJactivity;

@end
