//
//  GuideViewController.m
//  找玩友
//
//  Created by 军魏 on 14-6-28.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "GuideViewController.h"
@interface GuideViewController ()

@end

@implementation GuideViewController
{
    
}

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
    [self initGuide];
    self.tabBarView = [[TabBarViewController alloc] init];
 
    
  //  _tabBarView.tabBar.delegate = self;
    buttonItem.backgroundColor = [UIColor clearColor];
    buttonItem.frame = CGRectMake(124, -5, 74, 58);
    
    VicinityViewController* vicinityView = [[VicinityViewController alloc] init];
    ShowPlayViewController* showPlayView = [[ShowPlayViewController alloc] init];
    ReleaseWorkViewController* releaseView = [[ReleaseWorkViewController alloc] init];
    MessageViewController*  messageView = [[MessageViewController alloc] init];
    PlayFriendsViewController* playFriends = [[PlayFriendsViewController alloc] init];
    
    UINavigationController* Vicinity;
    UINavigationController* showplay;
    Vicinity = [[UINavigationController alloc] initWithRootViewController:vicinityView];
    showplay = [[UINavigationController alloc] initWithRootViewController:showPlayView];
    UINavigationController*  message = [[UINavigationController alloc] initWithRootViewController:messageView];

    _tabBarView.viewControllers = @[Vicinity,showplay,releaseView,message,playFriends];
    _tabBarView.tabBar.selectedImageTintColor = [UIColor orangeColor];
    
    [_tabBarView.tabBar addSubview:buttonItem];
    
  
    
    // Do any additional setup after loading the view from its nib.
}

-(void) initGuide
{
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
   
    [scrollView setContentSize:CGSizeMake(960, 0)];
    [scrollView setPagingEnabled:YES];
     [scrollView setBounces:NO];
  
    
    UIImageView  *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [imageview1 setImage:[UIImage imageNamed:@"guidePictrue2"]];
    [scrollView addSubview:imageview1];
   
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, 480)];
    [imageview2 setImage:[UIImage imageNamed:@"guidePicture3"]];
    [scrollView addSubview:imageview2];
   
    
    UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, 480)];
    [imageview3 setImage:[UIImage imageNamed:@"guidePicture4"]];
    [scrollView addSubview:imageview3];
    
    [button setFrame:CGRectMake(75+640, 429, 171, 38)];
    [self.view addSubview:scrollView];
    [scrollView addSubview:button];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) firstpressed
{
       //buttonItem.backgroundColor = [UIColor redColor];;
    
   [self presentModalViewController:_tabBarView animated:YES];
    [self removeFromParentViewController];
    
    }
-(IBAction)OnClick
{
    
    [self.tabBarView ClickRelease];
   
   }



@end
