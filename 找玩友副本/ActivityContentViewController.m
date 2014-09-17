





#import "ActivityContentViewController.h"
#import "LoginCheck.h"
#import "getCurrentTime.h"
#import "localInformation.h"
#import "AsynchronousRequest.h"

#import "VicinityViewController.h"
#import "ReleaseWorkViewController.h"
#import "PlayFriendsScroViewController.h"
#import "MessageViewController.h"
#import "ShowPlayViewController.h"
#import "TabBarViewController.h"
@interface ActivityContentViewController ()<UITextViewDelegate,AsynchronousRequestDelegate>

@end
#define Content @"Activity"
#define Method @"m"
#define Method_value @"post"
#define Data @"data"

static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";
@implementation ActivityContentViewController
{
    NSString* contentString;
    NSString* startTime;
    NSString* endTime;
    NSString* AssemPlace;
    NSString* limit;
    NSString* Cost;
    NSString* latitude;
    NSString* longtitude;
    NSString* address;
    NSString* cityCode;
    NSString* userID;
    NSString* currentTime;
    AsynchronousRequest* asy;
    TabBarViewController *tabBarView;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"发布内容";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIBarButtonItem* doneBar = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(ReActivity)];
    self.navigationItem.rightBarButtonItem = doneBar;
    // Do any additional setup after loading the view from its nib.
}

-(void) getDataFromReleaseActivityStartTime:(NSString *)Stime andEndtime:(NSString *)Etime andAssem:(NSString *)Place andLimited:(NSString *)limite andCost:(NSString *)cost
{
    LoginCheck* check = [LoginCheck sharedLoginCheck];
    localInformation* local = [localInformation shareLocalInformation];
    startTime = Stime;
    endTime = Etime;
    AssemPlace = Place;
    Cost = cost;
    limit = limite;
    address = [local getAddr];
    latitude = [local getLat];
    longtitude = [local getLon];
    userID = [check getUserId];
    currentTime = [getCurrentTime getCurrent];
    cityCode = @"75";
}

-(BOOL) checkNullAndBlank
{
    if (latitude == NULL || [latitude isEqualToString:@""]) {
        return false;
    }
    if (longtitude == NULL || [longtitude isEqualToString:@""]) {
        return false;
    }
    if (address == NULL || [address isEqualToString:@""]) {
        return false;
    }
    if (contentString == NULL || [contentString isEqualToString:@""]) {
        return false;
    }
    return true;
}

-(void) ReActivity
{
    [self.ContentTextView resignFirstResponder];
    contentString = self.ContentTextView.text;
    if ([self checkNullAndBlank]) {
        
        [self putActivityMessageToWeb];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"请完善信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) putActivityMessageToWeb
{
    NSDictionary*   postData = @{
                                 @"user_id": userID,
                                 @"post_time":currentTime,
                                 @"post_addr":address,
                                 @"activity_start_time":startTime,
                                 @"activity_content":contentString,
                                 @"limit_people_num":limit,
                                 @"end_time":endTime,
                                 @"activity_cost":Cost,
                                 @"assembling_place":AssemPlace,
                                 @"city_code" :cityCode,
                                 @"activity_longitude":longtitude,
                                 @"activity_latitude":latitude
                                 };
    
    NSString* path = [baseURL stringByAppendingString:Content];
    
    NSString* postJson = [postData JSONString];
    NSDictionary* dict = @{Method: Method_value,Data:postJson};
    asy = [[AsynchronousRequest alloc] init];
    asy.delegate = self;
    [asy   getRequestForServes:path andPostValue:dict andIsJson:NO];
}


-(void) AsyRequestFinished:(NSArray *)valueArray
{
    //2表示成功登录
    if ([[valueArray objectAtIndex:0] isEqualToString:@"2"]) {
        self.ContentTextView.delegate = nil;
        //跳转到发布选择界面
        [self setupTurnView];
    }
    //1表示登录失败
    if ([[valueArray objectAtIndex:0] isEqualToString:@"1"]) {
        UIAlertView* Alert = [[UIAlertView alloc] initWithTitle:@"发布失败" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [Alert show];
    }
    
}

-(void) setupTurnView
{
    tabBarView = [[TabBarViewController alloc] init];
    
    
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
    
    
    tabBarView.viewControllers = @[Vicinity,showplay,releaseView,message,playFriends];
    tabBarView.tabBar.selectedImageTintColor = [UIColor orangeColor];
    
    [tabBarView.tabBar addSubview:buttonItem];
    [self presentModalViewController:tabBarView animated:YES];
    [self removeFromParentViewController];
    
}

@end
