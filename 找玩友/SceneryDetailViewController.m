//
//  SceneryDetailViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-19.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "SceneryDetailViewController.h"

@interface SceneryDetailViewController ()

@end

@implementation SceneryDetailViewController

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
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"活动详情";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    SceneryDetailScroViewViewController *sceneryScroView = [[SceneryDetailScroViewViewController alloc] initWithFrame:CGRectMake(0, 8, 320, 480)];
    [sceneryScroView addViews];
    self.SceneryView.frame = CGRectMake(0, 0, 320, 124);
    self.SceneryView.backgroundColor = [UIColor whiteColor];
    self.ReView.frame = CGRectMake(0, 132, 320, 35);
    self.ReView.backgroundColor = [UIColor whiteColor];
    [sceneryScroView addSubview:self.ReView];
    [sceneryScroView addSubview:self.SceneryView];
    [self.view addSubview:sceneryScroView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backView
{
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"View Ended");}];
    
}
@end
