//
//  PlayFriendsViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-16.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "PlayFriendsViewController.h"
#import "LoginCheck.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
@interface PlayFriendsViewController ()

@end

@implementation PlayFriendsViewController
{
    LoginCheck* loginCheck;
   
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"玩友";
        self.tabBarItem.image = [UIImage imageNamed:@"More32px.png"];
        // Custom initialization
    }
    return self;
}
-(void) initDataSource:(NSArray*) value
{
    rankDataSource = value;
}

-(IBAction) pushButton
{
    if(ShowRank == YES)
    {
        [self hidden];
    }
    else
    {
        [self Show];
    }
}


-(void) Show
{
    self.rankImage.image = [UIImage imageNamed:@"shangla"];
    rankTable.hidden = NO;
    ShowRank = YES;
    [self.rankView setNeedsDisplay];
}

-(void) hidden
{
    self.rankImage.image = [UIImage imageNamed:@"xiala"];
    rankTable.hidden = YES;
    ShowRank = NO;
    [self.rankView setNeedsDisplay];
}
-(void) viewDidAppear:(BOOL)animated
{
    loginCheck = [LoginCheck sharedLoginCheck];
    if ([loginCheck returnCheckValue] == false) {
        [self setupAlertView];
        
        return;
    }
}

-(void) setup
{
    PlayFriendsScroViewController* fView = [[PlayFriendsScroViewController alloc] initWithFrame:CGRectMake(0, 116, 320, 480)];
    [fView addViews];
    fView.delegate = self;
    [self.view addSubview:fView];
    
    self.rankImage.image = [UIImage imageNamed:@"xiala"];
    rankDataSource = [[NSArray alloc] init];
    rankDataSource = @[@"姓名",@"活动",@"亲密度"];
    ShowRank = NO;
    self.rankLabel.text = @"排序";
    self.rankLabel.font = [UIFont systemFontOfSize:18.0f];
    self.rankLabel.textColor = [UIColor lightGrayColor];
    rankTable = [[UITableView alloc] initWithFrame:CGRectMake(8, 106, 106, 100)];
    rankTable.delegate = self;
    rankTable.dataSource = self;
    rankTable.backgroundColor = [UIColor clearColor];
    rankTable.separatorColor = [UIColor blackColor];
    rankTable.hidden = YES;
    [self.view addSubview:rankTable];
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    // Do any additional setup after loading the view from its nib.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [rankDataSource count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"ListCellIdentifier";
	UITableViewCell *cell = [rankTable dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	cell.textLabel.text = (NSString *)[rankDataSource objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 30.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self hidden];
	_rankLabel.text = (NSString *)[rankDataSource objectAtIndex:indexPath.row];
    _rankLabel.textColor = [UIColor blackColor];
}

-(void) backView
{
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"Friends View Ended!!!");}];
}

-(void) turnToFriendsInformation
{
    
    PersonalInformationViewController* personView = [[PersonalInformationViewController alloc] init];
    UINavigationController* personNavigation = [[UINavigationController alloc] initWithRootViewController:personView];
   personNavigation.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:personNavigation animated:YES completion:^{NSLog(@"玩友详细资料视图控制器打开");}];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)checkLogin
{
    if ([loginCheck returnCheckValue] == false)
    {
        [self setupAlertView];
    }
    else
    {
        [_checkButton removeFromSuperview];
    }
}
-(void) setupAlertView
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"登录提醒" contentText:@"请您先登录,再查看" leftButtonTitle:@"去登录" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        NSLog(@"left button clicked");
        LoginViewController* loginView = [[LoginViewController alloc] init];
        [self presentViewController:loginView animated:YES completion:^{NSLog(@"登录界面打开");}];
        [self.tabBarController removeFromParentViewController];
    };
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
        self.tabBarController.selectedIndex = 0;
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
        self.tabBarController.selectedIndex = 0;
    };
    
}

@end
