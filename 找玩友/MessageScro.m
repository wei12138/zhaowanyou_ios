//
//  MessageScroViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-12.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "MessageScro.h"

@interface MessageScro ()

@end

@implementation MessageScro
{
    NSArray* dataArray;
}


-(void) getData:(NSArray *)valuArray
{
    dataArray = valuArray;
}

-(UIView*) createView:(CGRect)frame andIndex:(NSInteger)index
{
    UIView* userView = [[UIView alloc] initWithFrame:frame];
    
    
    //设置姓名
    UILabel *userNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 3, 117, 15)];
    userNamelabel.text = @"采薇";
    userNamelabel.font = [UIFont systemFontOfSize:12];
    [userView addSubview:userNamelabel];
    [userNamelabel release];
    
    //设置时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 0, 105, 14)];
    timeLabel.text = @"2012-8-1 12:23";
    timeLabel.font = [UIFont systemFontOfSize:12];
    [userView addSubview:timeLabel];
    [timeLabel release];
    
    //设置评论内容
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 26, 267, 15)];
    commentLabel.text = @"太坑了下次再也不去了";
    commentLabel.font = [UIFont systemFontOfSize:12];;
    [userView addSubview:commentLabel];
    [commentLabel release];
    
  
   // NSLog(@"MessageView Start");
    return userView;
    
}
-(void) print
{
    NSLog(@"print");
}
-(void) addViews
{
    int space = 5;
    int countImage = 20;
    int viewHigh = 47;
    [self setContentSize:CGSizeMake(320, (space+viewHigh)*countImage)];
       for (int i = 0; i < countImage; i++) {
        headPicture = [UIImage imageNamed:@"Wife2"];
        userName = @"笑笑芳";
        Timer = @"2014-7-12 14:32";
        Comment = @"二芳评论了你:太坑了下次再也不用去了TAT";
         UIView* value = [self createView:CGRectMake(0, viewHigh*i+i*space, 320, 47)];
          
        [self addSubview:value];
        [value  release];
        
    }
    [headPicture release];
    [Timer release];
    [userName release];
    [Comment release];

}




@end
