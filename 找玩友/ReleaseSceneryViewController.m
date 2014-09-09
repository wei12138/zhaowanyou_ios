//
//  ReleaseSceneryViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-12.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ReleaseSceneryViewController.h"

@interface ReleaseSceneryViewController ()

@end

@implementation ReleaseSceneryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发布玩点";
    self.TextView.delegate = self;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view from its nib.
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
