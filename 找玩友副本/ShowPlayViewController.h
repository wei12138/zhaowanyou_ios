//
//  ShowPlayViewController.h
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneryDetailViewController.h"
#import "bmkLoction.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ShowPlayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,locationData>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segementControl;

@property (weak, nonatomic) IBOutlet UILabel *LocationLabel;

@property (weak, nonatomic) IBOutlet UITableView *ShowPlayTableView;

-(IBAction) clickFriends;
@end
