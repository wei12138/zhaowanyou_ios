//
//  VicinityViewController.h
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDeatailViewController.h"
#import "PlayFriendsViewController.h"
#import "SVPullToRefresh.h"
#import "cellViewSetup.h"
#import "bmkLoction.h"
#import <SDWebImage/UIImageView+WebCache.h>
@protocol localInfo <NSObject>



@end

@interface VicinityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate,activityButtonAction,locationData>
{
    bmkLoction *bmkl;
  
   }



@property (weak, nonatomic) IBOutlet UITableView *ActivityListView;
@property (weak,nonatomic) IBOutlet UILabel *LocalMessageLable;

-(IBAction) ClickFrinds;

@end
