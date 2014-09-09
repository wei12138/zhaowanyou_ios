//
//  MessageScroViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-12.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageScro : NSObject
{
    UIImage* headPicture;
    NSString* userName;
    NSString* Comment;
    NSString* Timer;
    NSArray* userMessage;
}

-(void) getData:(NSArray*) valuArray;
-(UIView*) createView:(CGRect) frame andIndex:(NSInteger) index;

@end
