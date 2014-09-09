//
//  PlayFriendsScroViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-17.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "PlayFriendsScroViewController.h"

@interface PlayFriendsScroViewController ()

@end

@implementation PlayFriendsScroViewController

-(id) initMessageScroViewWithData:(NSArray *)value
{
    userMessage = value;
    
    return nil;
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
    
    
}


-(UIView*) createViews:(CGRect)frame
{
    UIView* userView = [[UIView alloc] initWithFrame:frame];
    BOOL g = YES;
    
    //头像
    UIImageView* headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wife2"]];
    headImage.frame = CGRectMake(6, 3, 49, 44);
    [userView addSubview:headImage];
    
    //姓名
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(63, 0, 50, 21)];
    userNameLabel.text = @"方芳芳";
    userNameLabel.font = [UIFont systemFontOfSize:12.0f];
    [userView addSubview:userNameLabel];
    
    //活动
    UILabel *friendsActivity = [[UILabel alloc] initWithFrame:CGRectMake(62, 29, 258, 21)];
    friendsActivity.text = @"最近发布了一个活动";
    friendsActivity.font = [UIFont systemFontOfSize:12.0f];
    [userView addSubview:friendsActivity];
    
    //文件
    UIImageView* fileImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wenjian.png"]];
    fileImage.frame = CGRectMake(290, 7, 17, 23);
    [userView addSubview:fileImage];
    
    if(g == YES)
    {
        UIImageView* genderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Man.png"]];
        genderImageView.frame = CGRectMake(108, 0, 19, 16);
        [userView addSubview:genderImageView];
    }
    userView.backgroundColor = [UIColor whiteColor];
    
       return userView;
    
}
-(void) print
{
    NSLog(@"print");
}
-(void) addViews
{
    int viewHigh = 55;
    int space = 5;
    int count = 20;   //记录有多少条服务器消息
    [self setContentSize:CGSizeMake(320,(viewHigh+space)*count)];
    
    for (int i = 0; i < count; i++) {
    
        UIView* friendsView = [self createViews:CGRectMake(0, (55+space)*i, 320, 55)];
        UIButton* friendsDetailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
       // friendsDetailButton.backgroundColor = [UIColor redColor];
        [friendsDetailButton addTarget:self action:@selector(turnTo) forControlEvents:UIControlEventTouchUpInside];
        [friendsView addSubview:friendsDetailButton];
        [self addSubview:friendsView];
       
        
    }
}

-(void) turnTo
{
    [self.delegate turnToFriendsInformation];
}






@end
