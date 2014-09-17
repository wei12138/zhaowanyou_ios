//
//  PersonalInformationViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//


#import "CCSegmentedControl.h"

#import "SegmentOneViewController.h"
#import "SegmentTwoViewController.h"


#import "LoginViewController.h"
@interface PersonalInformationViewController : UIViewController
{
    CCSegmentedControl* m;
}



@property(weak,nonatomic)  IBOutlet UIView* basicView;
-(IBAction)backView;
-(void) segementViewChange:(id) sender;


@end
