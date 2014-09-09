//
//  ShowPlayCellView.m
//  找玩友
//
//  Created by 军魏 on 14-8-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ShowPlayCellView.h"
#import "CircleImage.h"
#import "ViewBlank.h"
@implementation ShowPlayCellView
{
    NSArray* reciveArray;
}

-(void) getData:(NSArray *)showPlayArray
{
    reciveArray = showPlayArray;
}
-(UIView*) createShowPlayCellView:(NSInteger)index andCellFrame:(CGRect)frame
{
    UIView* cellView = [[UIView alloc] initWithFrame:frame];
    
     UIImageView* headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gray_logo"]];
      headImage.frame = CGRectMake(10, 8, 50, 50);
    headImage = [CircleImage returnCircleImageView:headImage andFrame:headImage.frame];
    [cellView addSubview:headImage];
    
    UILabel *UserName = [[UILabel alloc] init];
    UserName.text = [[reciveArray objectAtIndex:index] valueForKey:@"name"];
    UserName.frame = CGRectMake(70, 7, 0,0 );
    [UserName sizeToFit];
    
    [cellView addSubview:UserName];
    
    if ([[[reciveArray objectAtIndex:index] valueForKey:@"gender"] isEqualToString:@"男"]) {
        UIImageView* GenderIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Man"]];
        GenderIcon.frame = CGRectMake(UserName.frame.origin.x+50, 7, 26, 21);
        [GenderIcon sizeToFit];
        [cellView addSubview:GenderIcon];
    }
    else
    {
        UIImageView* GenderIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Gender32px"]];
        GenderIcon.frame = CGRectMake(UserName.frame.origin.x+50, 2, 26, 21);
        [GenderIcon sizeToFit];
        [cellView addSubview:GenderIcon];
    }
    
    UILabel* timeLabel = [[UILabel alloc] init];
    timeLabel.text = [[reciveArray objectAtIndex:index] valueForKey:@"in_time"];
    timeLabel.frame = CGRectMake(185, 7,0 ,0 );
    [timeLabel sizeToFit];
    [cellView addSubview:timeLabel];
    
    UIImageView* locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Location32px"]];
    locationIcon.frame = CGRectMake(65, 36,25 , 22);
    [cellView addSubview:locationIcon];
    
    UILabel* locLabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 36, 205, 21)];
    locLabel.text = [[reciveArray objectAtIndex:index] valueForKey:@"in_addr"];
    locLabel.font = [UIFont systemFontOfSize:12.0f];
    [locLabel sizeToFit];
    [cellView addSubview:locLabel];
    
    UITextView* ActivityText = [[UITextView alloc] init];
    NSString* newStr = [[reciveArray objectAtIndex:index] valueForKey:@"in_content"];
    newStr = [ViewBlank returnViewBlank:newStr];
    ActivityText.text = newStr;
    ActivityText.scrollEnabled = NO;
    ActivityText.selectable = NO;
    ActivityText.frame = CGRectMake(0, 65, 320, 60);
    [ActivityText sizeToFit];
    [cellView addSubview:ActivityText];
    
    UIButton* goodButton = [[UIButton alloc] initWithFrame:CGRectMake(240,ActivityText.frame.size.height+90, 20, 20)];
    [goodButton setBackgroundImage:[UIImage imageNamed:@"Question24px"] forState:UIControlStateNormal];
   
    [cellView addSubview:goodButton];
    
    UIButton* shengLButton = [[UIButton alloc] initWithFrame:CGRectMake(270+goodButton.frame.size.width, ActivityText.frame.size.height+90, 20, 20)];
    [shengLButton setBackgroundImage:[UIImage imageNamed:@"shengluehao24px"] forState:UIControlStateNormal];
    [cellView addSubview:shengLButton];
    
    cellView.frame = CGRectMake(0, 0, 320, ActivityText.frame.size.height+110);
    [cellView  sizeToFit];
    
    return cellView;

}
@end
