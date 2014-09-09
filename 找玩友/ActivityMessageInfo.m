//
//  ActivityMessageInfo.m
//  找玩友
//
//  Created by 军魏 on 14-8-27.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ActivityMessageInfo.h"
#import "CircleImage.h"
@implementation ActivityMessageInfo

-(UIView*) InfoView:(UIColor *)backgoundColor andMessage:(NSDictionary *)dict
{
    UIView *InfoView = [[UIView alloc] initWithFrame:CGRectMake(14, 0, 320, 365)];
    InfoView.backgroundColor = backgoundColor;
    //活动模块
    UIView*  activityMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 94)];
    activityMessageView.backgroundColor = [UIColor whiteColor];
    
      
    UILabel* userName = [[UILabel alloc] initWithFrame:CGRectMake(53, 5, 190, 15)];
    userName.text =[dict valueForKey:@"name"];
    userName.font = [UIFont systemFontOfSize:12.0f];
    [userName sizeToFit];
    [activityMessageView addSubview:userName];
    
    if ([[dict objectForKey:@"gender"] isEqualToString:@"男"]) {
    UIImageView* genderPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Man"]];
    genderPicture.frame = CGRectMake(53+userName.frame.size.width+5, 0, 15, 15);
        [genderPicture sizeToFit];
    [activityMessageView addSubview:genderPicture];
    }
    else
    {
    UIImageView* genderPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Gender32px"]];
    genderPicture.frame = CGRectMake(53+userName.frame.size.width+5, -3, 15, 15);
        [genderPicture sizeToFit];
    [activityMessageView addSubview:genderPicture];
        
    }
    UIImageView* loctionPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Location32px"]];
    loctionPicture.frame = CGRectMake(48, 20, 23, 22);
    [activityMessageView addSubview:loctionPicture];
    
    UILabel* timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(219, 2, 101, 18)];
    timerLabel.text = [dict valueForKey:@"post_time"];
    timerLabel.font = [UIFont systemFontOfSize:12.0f];
    [activityMessageView addSubview:timerLabel];
    
    UILabel* locMessage = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 201, 22)];
    locMessage.text = [dict valueForKey:@"post_addr"];
    locMessage.font = [UIFont systemFontOfSize:12.0f];
    [locMessage sizeToFit];
    [activityMessageView addSubview:locMessage];
    
    UITextView* activityMessage = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, 320, 50)];
    activityMessage.text =[dict valueForKey:@"activity_content"];
    activityMessage.font = [UIFont systemFontOfSize:13.0f];
    activityMessage.editable = NO;
    activityMessage.selectable = NO;
    activityMessage.scrollEnabled = NO;
    [activityMessage sizeToFit];
    [activityMessageView addSubview:activityMessage];
    [InfoView addSubview:activityMessageView];
    
    //活动信息
    UIView* pNumber = [[UIView alloc] initWithFrame:CGRectMake(0, 102, 103, 53)];
    pNumber.backgroundColor = [UIColor whiteColor];
    
    UILabel* pNumberlaber = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 42, 21)];
    pNumberlaber.textAlignment =UITextAlignmentCenter;
    pNumberlaber.text = [dict valueForKey:@"join_people_num"];
    [pNumber addSubview:pNumberlaber];
    
    UILabel* pNumberMessage = [[UILabel alloc] initWithFrame:CGRectMake(17, 32, 68, 21)];
    pNumberMessage.text = @"参与人数";
    [pNumber addSubview:pNumberMessage];
    [InfoView addSubview:pNumber];
    
    UIView* pLimited = [[UIView alloc] initWithFrame:CGRectMake(109, 102, 103, 53)];
    pLimited.backgroundColor = [UIColor whiteColor];
    
    UILabel* pLimitedLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 42, 21)];
    pLimitedLabel.textAlignment =UITextAlignmentCenter;
    pLimitedLabel.text = [dict valueForKey:@"limit_people_num"];
    [pLimited addSubview:pLimitedLabel];
    
    UILabel* pLimitedMessage = [[UILabel alloc] initWithFrame:CGRectMake(17, 32, 68, 21)];
    pLimitedMessage.text = @"限制人数";
    [pLimited addSubview:pLimitedMessage];
    [InfoView addSubview:pLimited];
    
    UIView* pDate = [[UIView alloc] initWithFrame:CGRectMake(217, 102, 103, 53)];
    pDate.backgroundColor = [UIColor whiteColor];
    
    UILabel* pDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 12, 86, 21)];
    // pNumberlaber.textAlignment =UITextAlignmentCenter;
    pDateLabel.text = [dict valueForKey:@"end_time"];
    pDateLabel.font = [UIFont systemFontOfSize:16.0f];
    [pDate addSubview:pDateLabel];
    
    UILabel* pDateMessage = [[UILabel alloc] initWithFrame:CGRectMake(17, 32, 68, 21)];
    pDateMessage.text = @"截至时间";
    [pDate addSubview:pDateMessage];
    [InfoView addSubview:pDate];
    
    //发起人信息
    UIView*  Ractivity = [[UIView alloc] initWithFrame:CGRectMake(0, 158, 320, 46)];
    Ractivity.backgroundColor = [UIColor whiteColor];
    
    UILabel* RactivityLaber = [[UILabel alloc] initWithFrame:CGRectMake(8, 12, 146, 21)];
    RactivityLaber.text = @"发起人详细信息";
    RactivityLaber.font = [UIFont systemFontOfSize:20.0f];
    [Ractivity addSubview:RactivityLaber];
    
    [InfoView addSubview:Ractivity];
    //年龄
  
    UIView* ageView = [[UIView alloc] initWithFrame:CGRectMake(0, 205, 320, 28)];
    ageView.backgroundColor = [UIColor whiteColor];
    
    UILabel* ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 50, 15)];
    ageLabel.text = @"年       龄";
    ageLabel.font = [UIFont systemFontOfSize:12.0f];
    [ageView addSubview:ageLabel];
    
    
    /**
     根据出生日期计算年龄
     */
    UILabel* age = [[UILabel alloc] initWithFrame:CGRectMake(88, 3, 42, 21)];
    

     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSDate *date = [dateFormatter dateFromString:[dict valueForKey:@"birthday"]];
     NSTimeInterval dateDiff = [date timeIntervalSinceNow];
     int ageNum=trunc(dateDiff/(60*60*24))/365;
     ageNum = -ageNum;
 
    
    NSString* ageString = [[[NSNumber numberWithInt:ageNum] stringValue] stringByAppendingString:@"岁"];
    age.text = ageString;
    age.font = [UIFont systemFontOfSize:13.0f];
    [age sizeToFit];
    [ageView addSubview:age];
    [InfoView addSubview:ageView];
    //手机
    UIView* mobileView = [[UIView alloc] initWithFrame:CGRectMake(0, 234, 320, 28)];
    mobileView.backgroundColor = [UIColor whiteColor];
    
    UILabel* mobileLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 52, 15)];
    mobileLabel.text = @"手  机  号";
    mobileLabel.font = [UIFont systemFontOfSize:12.0f];
    [mobileView addSubview:mobileLabel];
    
    UILabel* mobile = [[UILabel alloc] initWithFrame:CGRectMake(85, 8, 200, 15)];
    mobile.text = [dict valueForKey:@"telphone"];
    mobile.font = [UIFont systemFontOfSize:12.0f];
    [mobileView addSubview:mobile];
    [InfoView addSubview:mobileView];
    //活动详情
    UIView* activityDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 270, 320,37)];
    activityDetailView.backgroundColor = [UIColor whiteColor];
    
    UILabel* activityDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 137, 21)];
    activityDetailLabel.text = @"活动详情";
    activityDetailLabel.font = [UIFont systemFontOfSize:17.0f];
    [activityDetailView addSubview:activityDetailLabel];
    [InfoView addSubview:activityDetailView];
    //活动费用
    UIView* costView = [[UIView alloc] initWithFrame:CGRectMake(0,308, 320, 28)];
    costView.backgroundColor = [UIColor whiteColor];
    
    UILabel* costLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 68, 21)];
    costLabel.text = @"活动经费";
    [costView addSubview:costLabel];
    
    UILabel* cost = [[UILabel alloc] initWithFrame:CGRectMake(96, 3, 42, 21)];
    cost.text = [dict valueForKey:@"activity_cost"];
    cost.font = [UIFont systemFontOfSize:13.0f];
    [cost sizeToFit];
    [costView addSubview:cost];
    [InfoView addSubview:costView];
    //集合地点
    
    UIView* placeView = [[UIView alloc] initWithFrame:CGRectMake(0,337, 320, 28)];
    placeView.backgroundColor = [UIColor whiteColor];
    
    UILabel* placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 68, 21)];
    placeLabel.text = @"集合地点";
    [placeView addSubview:placeLabel];
    
    UILabel* place = [[UILabel alloc] initWithFrame:CGRectMake(96, 3, 60, 21)];
    place.text = [dict valueForKey:@"assembling_place"];
    place.font = [UIFont systemFontOfSize:13.0f];
    [place sizeToFit];
    [placeView addSubview:place];
    
    [InfoView addSubview:placeView];
    
    
    return InfoView;
}


@end
