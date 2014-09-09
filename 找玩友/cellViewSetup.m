//
//  cellViewSetup.m
//  找玩友
//
//  Created by 军魏 on 14-8-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "cellViewSetup.h"
#import "CircleImage.h"
#import "ViewBlank.h"

#define time_label_gap 10
#define gender_user_gap 20


@implementation cellViewSetup
{
    NSArray*  reciveArray;
    UIImageView *headImage;
    
}

-(void) getData:(NSArray *)value
{
    reciveArray = value;
   
}

-(UIView*) setupCellView:(NSInteger)index andCellFrame:(CGRect)frame
{
  
   
    UIView* cellView = [[UIView alloc] initWithFrame:frame];
    NSLog(@"width is %f",frame.size.width);
       
    UILabel *UserName = [[UILabel alloc] init];
    UserName.text = [[reciveArray objectAtIndex:index] valueForKey:@"name"];
    UserName.frame = CGRectMake(70, 7, 0,0 );
    [UserName sizeToFit];

    [cellView addSubview:UserName];
    
    if ([[[reciveArray objectAtIndex:index] valueForKey:@"gender"] isEqualToString:@"男"]) {
        CGFloat genderX = UserName.frame.size.width+UserName.frame.origin.x+gender_user_gap;
        UIImageView* GenderIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Man"]];
        GenderIcon.frame = CGRectMake(genderX, 7, 26, 21);
        [GenderIcon sizeToFit];
        [cellView addSubview:GenderIcon];
    }
    else
    {
         CGFloat genderX = UserName.frame.size.width+UserName.frame.origin.x+gender_user_gap;
        UIImageView* GenderIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Gender32px"]];
        GenderIcon.frame = CGRectMake(genderX, 2, 26, 21);
        [GenderIcon sizeToFit];
        [cellView addSubview:GenderIcon];
    }
    
    UILabel* timeLabel = [[UILabel alloc] init];
    timeLabel.text = [[reciveArray objectAtIndex:index] valueForKey:@"post_time"];
    timeLabel.font = [UIFont systemFontOfSize:13.0f];
    [timeLabel sizeToFit];
    timeLabel.frame = CGRectMake(frame.size.width-timeLabel.frame.size.width-time_label_gap, 7, timeLabel.frame.size.width, timeLabel.frame.size.height);
  
    [cellView addSubview:timeLabel];
    
    UIImageView* locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Location32px"]];
    locationIcon.frame = CGRectMake(65, 36,25 , 22);
    [cellView addSubview:locationIcon];
    
    UILabel* locLabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 36, 205, 21)];
    locLabel.text = [[reciveArray objectAtIndex:index] valueForKey:@"post_addr"];
    locLabel.font = [UIFont systemFontOfSize:12.0f];
    [locLabel sizeToFit];
    [cellView addSubview:locLabel];
    
    UITextView* ActivityText = [[UITextView alloc] init];
    NSString* newStr = [[reciveArray objectAtIndex:index] valueForKey:@"activity_content"];
    newStr = [ViewBlank returnViewBlank:newStr];
    ActivityText.text = newStr;
    ActivityText.scrollEnabled = NO;
    ActivityText.selectable = NO;
    ActivityText.frame = CGRectMake(0, 65, 320, 60);
    [ActivityText sizeToFit];
    [cellView addSubview:ActivityText];
    
    UIButton* goodButton = [[UIButton alloc] initWithFrame:CGRectMake(240,ActivityText.frame.size.height+90, 20, 20)];
    [goodButton setBackgroundImage:[UIImage imageNamed:@"Question24px"] forState:UIControlStateNormal];
    [goodButton addTarget:self action:@selector(clickGood) forControlEvents:UIControlEventTouchUpInside];
    [cellView addSubview:goodButton];
    
    UIButton* shengLButton = [[UIButton alloc] initWithFrame:CGRectMake(270+goodButton.frame.size.width, ActivityText.frame.size.height+90, 20, 20)];
    [shengLButton setBackgroundImage:[UIImage imageNamed:@"shengluehao24px"] forState:UIControlStateNormal];
    [cellView addSubview:shengLButton];
    
    cellView.frame = CGRectMake(0, 0, 320, ActivityText.frame.size.height+110);
    [cellView  sizeToFit];

       return cellView;
}

-(void) clickGood
{
    NSLog(@"!!!!!");
    [self.delegate activityGood];
}


@end
