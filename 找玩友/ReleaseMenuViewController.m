//
//  ReleaseMenuViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-1.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "ReleaseMenuViewController.h"

@interface ReleaseMenuViewController ()

@end

@implementation ReleaseMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
  }
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"";
      // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backView
{
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"MenuView ended");}];

}

-(IBAction) ReleaseActivity
{
    ReleaseActivityViewController* Activity = [[ReleaseActivityViewController alloc] init];
    [self.navigationController pushViewController:Activity animated:YES];
}

-(IBAction)ReleaseScenery
{
    ReleaseSceneryViewController* Scenery = [[ReleaseSceneryViewController alloc] init];
    [self.navigationController pushViewController:Scenery animated:YES];

}

@end
