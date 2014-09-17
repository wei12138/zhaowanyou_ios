//
//  PlayFriendsScroViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-17.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol friendsInformationDelegate <UIScrollViewDelegate,NSObject>

-(void) turnToFriendsInformation;

@end

@interface PlayFriendsScroViewController : UIScrollView
{
    NSArray* userName;
    NSArray* userPicture;
    NSArray* userMessage;
    NSArray* booleans;
}
@property(nonatomic,assign) id<friendsInformationDelegate> delegate;
-(void) addViews;
-(UIView*) createViews:(CGRect) frame;
-(void) turnTo;


@end
