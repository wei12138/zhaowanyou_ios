//
//  ReleaseActivityViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-15.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ReleaseActivityViewController.h"
#import "ActivityContentViewController.h"
#import "DateTrans.h"

@interface ReleaseActivityViewController ()

@end

@implementation ReleaseActivityViewController
{
    NSString* start_Time;
    NSString* Cost;
    NSString* Limited_People;
    NSString* end_Time;
    NSString* assemble_place;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setup
{
   
    self.title = @"发布活动";
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem* doneBar = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(ReleaseActivity)];
    self.navigationItem.rightBarButtonItem = doneBar;
    self.datePicker.hidden = YES;
}

-(void) startDelegate
{
    _ActivityCost.delegate = self;
    _LimitedPeople.delegate = self;
    _assemblePlace.delegate = self;
}
-(void) endDelegate
{
    _ActivityCost.delegate = nil;
    _LimitedPeople.delegate = nil;
    _assemblePlace.delegate = nil;

}
-(void) viewDidAppear:(BOOL)animated
{
    [self startDelegate];
     _datePicker.tag = 3;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self endDelegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view from its nib.
    _datePicker.tag = 3;
}



#pragma 判断个输入框是否为空
-(BOOL) CheckBlankAboutField
{
    if (start_Time == NULL || [start_Time isEqualToString:@""]) {
        return false;
    }
    if (end_Time == NULL ||[end_Time isEqualToString:@""]) {
        return false;
    }
    if (assemble_place == NULL || [assemble_place isEqualToString:@""]) {
        return false;
    }
    if (Cost == NULL || [Cost isEqualToString:@""]) {
        return false;
    }
    if (Limited_People == NULL || [Limited_People isEqualToString:@""]) {
        return false;
    }
    return true;
}

-(void) ReleaseActivity
{
    [self textFieldDown];
    [self selectTimePicker];
    if ([self CheckBlankAboutField]) {
    ActivityContentViewController*  ContentView = [[ActivityContentViewController alloc] init];
        [ContentView getDataFromReleaseActivityStartTime:start_Time andEndtime:end_Time andAssem:assemble_place andLimited:Limited_People andCost:Cost];
    
    [self.navigationController pushViewController:ContentView animated:YES];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"请完善内容" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self endDelegate];
    // Dispose of any resources that can be recreated.
}
#pragma 输入格式设置代码
-(IBAction) pickerViewShow
{
    [self textFieldDown];
    [self selectTimePicker];
    self.datePicker.hidden = NO;
    self.datePicker.tag = 0;     //设置TAG区别于结束时间日期选择  0代表选择开始时间  1代表结束时间
}

-(IBAction)pickerEndDateShow
{
     [self textFieldDown];
    [self selectTimePicker];
    self.datePicker.hidden = NO;
    self.datePicker.tag = 1;
}

-(void) startTimeEnd
{
    _startTime.text = [DateTrans stringFromDate:self.datePicker.date];
    start_Time =_startTime.text;
    _datePicker.hidden = YES;

}
#pragma 输入框完成输入时关闭键盘 并且保持数据
-(void) textFieldDown
{
    [_assemblePlace resignFirstResponder];
    assemble_place = _assemblePlace.text;
    
    [_LimitedPeople resignFirstResponder];
    Limited_People = _LimitedPeople.text;
    
    [_ActivityCost resignFirstResponder];
    Cost = _ActivityCost.text;
    
    
}




-(void) endTimeEnd
{
    _endTime.text = [DateTrans stringFromDate:self.datePicker.date];
    end_Time = _endTime.text;
    _datePicker.hidden = YES;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)  selectTimePicker
{
    switch (_datePicker.tag) {
        case 0:
            [self startTimeEnd];
            break;
            
        case 1:
            [self endTimeEnd];
            break;
    }

}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    [self selectTimePicker];
}


-(void) textFieldDidEndEditing:(UITextField *)textField
{
    [self textFieldDown];
}

@end
