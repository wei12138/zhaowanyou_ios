//
//  UIViewController_VicinityViewController.h
//  找玩友
//
//  Created by 军魏 on 9/17/14.
//  Copyright (c) 2014 军魏. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ActivityDeatailViewController.h"
#import "PlayFriendsViewController.h"
#import "cellViewSetup.h"
#import "bmkLoction.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface VicinityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,activityButtonAction,locationData>
{
    bmkLoction *bmkl;
    
}



@property (weak, nonatomic) IBOutlet UITableView *ActivityListView;
@property (weak,nonatomic) IBOutlet UILabel *LocalMessageLable;

-(IBAction) ClickFrinds;

@end
