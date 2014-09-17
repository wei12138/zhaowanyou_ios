//
//  SceneryDetailScroViewViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-19.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "SceneryDetailScroViewViewController.h"

@interface SceneryDetailScroViewViewController ()

@end

@implementation SceneryDetailScroViewViewController

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
    UIView*  activityMessageView = [[UIView alloc] initWithFrame:frame];
    activityMessageView.backgroundColor = [UIColor whiteColor];
    
    UIImageView* headPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wife1.jpg"]];
    headPicture.frame = CGRectMake(5, 5, 40, 37);
    [activityMessageView addSubview:headPicture];
    
    UILabel* userName = [[UILabel alloc] initWithFrame:CGRectMake(53, 5, 190, 15)];
    userName.text = @"方芳芳";
    userName.font = [UIFont systemFontOfSize:12.0f];
    [activityMessageView addSubview:userName];
    
    UIImageView* genderPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Gender32px"]];
    genderPicture.frame = CGRectMake(90, 5, 15, 15);
    [activityMessageView addSubview:genderPicture];
    
    UIImageView* loctionPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Location32px"]];
    loctionPicture.frame = CGRectMake(48, 20, 23, 22);
    [activityMessageView addSubview:loctionPicture];
    
    UILabel* timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 2, 101, 18)];
    timerLabel.text = @"2014-7-15";
    timerLabel.font = [UIFont systemFontOfSize:12.0f];
    [activityMessageView addSubview:timerLabel];
    
    UILabel* locMessage = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 201, 22)];
    locMessage.text = @"都江堰市青城山东软大道1号";
    locMessage.font = [UIFont systemFontOfSize:11.0f];
    [activityMessageView addSubview:locMessage];
    
    UITextView* activityMessage = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, 320, 30)];
    activityMessage.text = @"哇哇听上去很不错唉,求联系求组队";
    activityMessage.font = [UIFont systemFontOfSize:13.0f];
    activityMessage.editable = NO;
    activityMessage.selectable = NO;
    activityMessage.scrollEnabled = NO;
    [activityMessageView addSubview:activityMessage];
    
    
    return activityMessageView;

    
}
-(void) print
{
    NSLog(@"print");
}
-(void) addViews
{
    int space = 2;
    int count = 10; //用于计数有多少条消息
    
    [self setContentSize:CGSizeMake(320, 170+(76+space)*count)];
    
    
    for (int i = 0; i < count; i++) {
        UIView* activityView = [self createViews:CGRectMake(0, 170+(76+space)*i, 320, 76)];
        [self addSubview:activityView];
    }
    
    }
    
    
    




@end
