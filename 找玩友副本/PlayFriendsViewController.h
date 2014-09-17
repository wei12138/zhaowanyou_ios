//
//  PlayFriendsViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-16.
//  Copyright (c) 2014年 军魏. All rights reserved.
//


#import "PlayFriendsScroViewController.h"
#import "PersonalInformationViewController.h"

@interface PlayFriendsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,friendsInformationDelegate>
{
    NSArray* rankDataSource;
    UITableView* rankTable;
    BOOL ShowRank; //YES 代表隐藏  //NO代表出现
}

@property(weak,nonatomic) IBOutlet UILabel* rankLabel;
@property(weak,nonatomic) IBOutlet UIButton* rankButton;

@property(weak,nonatomic)  IBOutlet UIView* rankView;
@property(weak,nonatomic) IBOutlet UIImageView* rankImage;

@property (weak, nonatomic) IBOutlet UIButton *checkButton;




-(void) Show;
-(void) hidden;
-(void) initDataSource:(NSArray*) value;
-(IBAction)pushButton;
-(IBAction)checkLogin;

@end
