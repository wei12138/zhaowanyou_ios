//
//  RegisterPersonViewController.h
//  找玩友
//
//  Created by 军魏 on 14-8-14.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleImage.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@interface RegisterPersonViewController : UIViewController<UIActionSheetDelegate,ASIHTTPRequestDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
   
    IBOutlet UIButton *buttonItem;
}
@property(weak,nonatomic) IBOutlet UIView* headView;

@property (weak, nonatomic) IBOutlet UIDatePicker *BirthDayPickerView;

@property (weak, nonatomic) IBOutlet UITextField *user_phone_label;


@property (weak, nonatomic) IBOutlet UITextField *user_Birthday_label;

@property (weak, nonatomic) IBOutlet UITextField *user_Name_label;
@property (weak, nonatomic) IBOutlet UITextField *user_gender_label;

@property (weak, nonatomic) IBOutlet UIButton *pickViewButton;
@property (weak, nonatomic) IBOutlet UIButton *genderSheetPiker;

@property (weak, nonatomic) IBOutlet UIImageView *headImageVIew;


-(IBAction) pickDateView;
-(IBAction) backRegister;
-(IBAction) genderView;
-(IBAction) registerUserInfo;

-(IBAction) clickTurn;

-(void) GetData:(NSString*) phoneValue and:(NSString*) passValue;


- (IBAction)selectImage:(id)sender;


@end
