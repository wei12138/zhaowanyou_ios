//
//  ReleaseActivityViewController.h
//  找玩友
//
//  Created by 军魏 on 14-7-15.
//  Copyright (c) 2014年 军魏. All rights reserved.
//






#import <UIKit/UIKit.h>
@interface ReleaseActivityViewController : UIViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *startTime;

@property (weak, nonatomic) IBOutlet UITextField *endTime;

@property (weak, nonatomic) IBOutlet UITextField *ActivityCost;


@property (weak, nonatomic) IBOutlet UITextField *LimitedPeople;

@property (weak, nonatomic) IBOutlet UITextField *assemblePlace;





-(IBAction) pickerViewShow;
-(IBAction) pickerEndDateShow;
@end
