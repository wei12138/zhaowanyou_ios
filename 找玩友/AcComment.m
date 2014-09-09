//
//  AcComment.m
//  找玩友
//
//  Created by 军魏 on 14-8-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "AcComment.h"
#import "CircleImage.h"
#import "ViewBlank.h"
@implementation AcComment
{
    NSArray* CommentArray;
}

-(void) setupData:(NSArray *)commentArray
{
    CommentArray = commentArray;
}


-(UIView*) createCommentView:(NSInteger)index andFrame:(CGRect)frame
{
    UIView*  activityMessageView = [[UIView alloc] initWithFrame:CGRectMake(14, 0, 320, frame.size.height)];
    activityMessageView.backgroundColor = [UIColor whiteColor];
    
      
    UILabel* userName = [[UILabel alloc] initWithFrame:CGRectMake(53, 5, 190, 15)];
    userName.text = [[CommentArray objectAtIndex:index] valueForKey:@"name"];
    userName.font = [UIFont systemFontOfSize:12.0f];
    [userName sizeToFit];
    [activityMessageView addSubview:userName];
    
    if ([[[CommentArray objectAtIndex:index] valueForKey:@"gender"]  isEqualToString:@"女"]) {
    UIImageView* genderPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Gender32px"]];
    genderPicture.frame = CGRectMake(53+userName.frame.size.width+5, -3, 15, 15);
    [activityMessageView addSubview:genderPicture];
    }
    else
    {
        UIImageView* genderPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Man"]];
        genderPicture.frame = CGRectMake(53+userName.frame.size.width+5, 0, 15, 15);
        [activityMessageView addSubview:genderPicture];
    }
    
    UIImageView* loctionPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Location32px"]];
    loctionPicture.frame = CGRectMake(48, 20, 23, 22);
    [activityMessageView addSubview:loctionPicture];
    
    UILabel* timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 2, 101, 18)];
    timerLabel.text = [[CommentArray objectAtIndex:index] valueForKey:@"time"];
    timerLabel.font = [UIFont systemFontOfSize:12.0f];
    [timerLabel sizeToFit];
    [activityMessageView addSubview:timerLabel];
    
    UILabel* locMessage = [[UILabel alloc] initWithFrame:CGRectMake(70, 28, 201, 22)];
    locMessage.text = [[CommentArray objectAtIndex:index] valueForKey:@"address"];
    locMessage.font = [UIFont systemFontOfSize:11.0f];
    [locMessage sizeToFit];
    [activityMessageView addSubview:locMessage];
    
    UITextView* activityMessage = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, 320, 30)];
    NSString* contentString = [[CommentArray objectAtIndex:index] valueForKey:@"content"];
    contentString = [ViewBlank returnViewBlank:contentString];
    activityMessage.text =contentString;
    activityMessage.font = [UIFont systemFontOfSize:13.0f];
    activityMessage.editable = NO;
    activityMessage.selectable = NO;
    activityMessage.scrollEnabled = NO;
    [activityMessage sizeToFit];
    [activityMessageView addSubview:activityMessage];
    
    
    return activityMessageView;

    
    
    
}

@end
