#import "ShowPlayViewController.h"
#import "ShowPlayCellView.h"
#import "AboutMeViewController.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
#import "LoginCheck.h"
#import "AsynchronousRequest.h"
#import "CircleImage.h"
static NSString* baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";

@interface ShowPlayViewController ()<AsynchronousRequestDelegate>

@end

@implementation ShowPlayViewController
{
    NSArray* dataArray;
    ShowPlayCellView* showPlayCellView;
    UIImageView* views[100];    //图片匹配模式
    bmkLoction* bmkl;
    LoginCheck* loginCheck;
    NSMutableArray* imageArray;
    UIRefreshControl* rc ;//表视图刷新控件
    AsynchronousRequest* asy;
}
//POST 参数宏定义
#define Content @"Interest"
#define Method @"m"
#define Method_newest @"newest"
#define postData_city_code @"city_code"
#define postData_longitude @"longitude"
#define postData_latitude  @"latitude"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"晒玩点";
        self.tabBarItem.image = [UIImage imageNamed:@"ShowPlay24px"];
        self.tabBarItem.tag = 1;
        // self.view.backgroundColor = [UIColor  yellowColor];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.LocationLabel.text = @"";
    [bmkl setup];
    [bmkl start];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [bmkl down];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //刷新
    [self ShowPlayTable_Setup];
    [self BMKloc_Setup];
    loginCheck = [LoginCheck sharedLoginCheck]; //登录检测单例初始化
    // Do any additional setup after loading the view from its nib.
    //用户头像数组初始化
    imageArray = [[NSMutableArray alloc] init];
    //表视图刷新控件初始化
    [self reflashContrl_Setup];
}
#pragma 百度定位类初始化
-(void) BMKloc_Setup
{
    bmkl = [[bmkLoction alloc] init];
    bmkl.delegate = self;
    [bmkl setup];
}

#pragma 玩点表视图状态初始化
-(void) ShowPlayTable_Setup
{
    self.ShowPlayTableView.delegate = self;
    self.ShowPlayTableView.dataSource = self;
    self.ShowPlayTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
}

#pragma 刷新控件初始化状态
-(void) reflashContrl_Setup
{
    rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(reflashStaring) forControlEvents:UIControlEventEditingChanged];
}

#pragma 刷新控件刷新状态
-(void) reflashStaring
{
    if (rc.refreshing) {
        [self getShowPlayListWithCityCode:@"75" andLatitude:@"12.21212" andLongitude:@"12.13322"];
        rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在加载"];
    }
}
#pragma 刷新控件结束状态
-(void) reflashEnded
{
    [rc endRefreshing];
    
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
}

#pragma 根据JSON数据数量分配用户头像数组大小
-(void) setupImage:(NSInteger) index
{
    for (int i = 0; i < index; i++) {
        UIImageView* imageView = [[UIImageView alloc] init];
        [imageArray addObject:imageView];
    }
}

-(void) getlatitude:(NSString *)latitude andlongtitude:(NSString *)longtitude
{
    
}

#pragma 定位数据回调
-(void) getLocData:(NSString *)locaString
{
    self.LocationLabel.text = locaString;
}

-(IBAction) clickFriends
{
    if ([loginCheck returnCheckValue] == true) {
        
        AboutMeViewController *me = [[AboutMeViewController alloc] init];
        [self.navigationController pushViewController:me animated:YES];
    }
    else
    {
        [self setupAlertView];
    }
    
}

-(void) turnToSceneryDetail
{
    SceneryDetailViewController* sceneryDetailView = [[SceneryDetailViewController alloc] init];
    [self.navigationController pushViewController:sceneryDetailView animated:YES];
    
}

#pragma 表格视图布局
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3+[dataArray count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     表格布局分为三节
     第一节为背景图片  高度128 宽度320
     第二节为Segement选择器节  高度43 宽度320
     第三节为玩点信息节 高度根据玩点内容进行调整
     */
    
    if (indexPath.section == 0) {
        return 128;
    }
    if (indexPath.section == 1) {
        return 43;
    }
    if (indexPath.section == 2+[dataArray count]) {
        return 58;
    }
    
    UITextView* ActivityText = [[UITextView alloc] init];
    ActivityText.text = [[dataArray objectAtIndex:indexPath.section-2] valueForKey:@"in_content"];
    [ActivityText sizeToFit]; //根据内容计算单元格高度
    
    return 110+ActivityText.frame.size.height;
}



-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     表格布局分为三节
     第一节为背景图片  高度128 宽度320
     第二节为Segement选择器节  高度43 宽度320
     第三节为玩点信息节 高度根据玩点内容进行调整
     */
    //第一节
    UITableViewCell* cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selected = NO;
    }
    
    for(UIView *view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
        
    }
    cell.textLabel.text = nil;
    cell.backgroundView = nil;
    
    if (indexPath.section == 0) {
        
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beijing.jpeg"]];
        return cell;
    }
    //第二节
    if (indexPath.section == 1) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"segment"];
        
        self.segementControl.frame = CGRectMake(cell.frame.size.width/2-self.segementControl.frame.size.width/2, cell.frame.size.height/2-self.segementControl.frame.size.height/2, 161, 30);
        [cell.contentView addSubview:self.segementControl];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selected = NO;
        return cell;
    }
    if (indexPath.section == [dataArray count]+2) {
        UIButton* moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 58)];
        [moreButton addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:moreButton];
        cell.textLabel.text = @"点击查看更多";
        cell.textAlignment = UITextAlignmentCenter;
        
        return cell;
    }
    //第三节
    int index = (int)indexPath.section-2;
    
    [cell.contentView addSubview:[showPlayCellView createShowPlayCellView:index andCellFrame:cell.frame]];
    UIImageView* headImage = [imageArray  objectAtIndex:index];
    //用户头像URL
    NSURL* URL = [NSURL URLWithString:[[dataArray objectAtIndex:index] valueForKey:@"photo"]];
    headImage.frame = CGRectMake(10, 8, 50, 50);
    headImage = [CircleImage returnCircleImageView:headImage andFrame:headImage.frame];
    if (URL == NULL) {
        
        headImage.image = [UIImage imageNamed:@"gray_logo.png"];
        [cell.contentView addSubview:headImage];
        return cell;
    }
    [headImage setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"gray_logo.png"]];
    //   NSLog(@"head image number is %i   and section number %i",headImage.tag,indexPath.section);
    [cell.contentView addSubview:headImage];
    return cell;
}
-(void) Click
{
    [self getShowPlayListWithCityCode:@"75" andLatitude:@"12.21212" andLongitude:@"12.13322"];
}

#pragma 网络请求
- (void)getShowPlayListWithCityCode:(NSString *)cityCode andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    
    NSString *path = [baseURL stringByAppendingString:Content];
    
    NSDictionary *dict = @{Method: Method_newest,postData_city_code:cityCode,postData_latitude:latitude,postData_longitude:longitude};
    
    asy = [[AsynchronousRequest alloc] init];
    asy.delegate = self;
    [asy getRequestForServes:path andPostValue:dict andIsJson:YES];
}

-(void) AsyRequestFinished:(NSArray *)valueArray
{
    // NSLog(@"回调数据为%@",valueArray);
    dataArray = valueArray;
    [self ShowPlayCell_Setup];
    [self reflashEnded];  //关闭刷新控件
    asy.delegate = nil;   //关闭回调数据借口
}

#pragma 表格数据源初始化类
-(void) ShowPlayCell_Setup
{
    [self setupImage:[dataArray count]];   //用户头像数组大小初始化
    showPlayCellView = [[ShowPlayCellView alloc] init];
    [showPlayCellView getData:dataArray];
    [self.ShowPlayTableView reloadData];
}

-(void) setupAlertView
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"登录提醒" contentText:@"请您先登录,再查看" leftButtonTitle:@"去登录" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        NSLog(@"left button clicked");
        LoginViewController* loginView = [[LoginViewController alloc] init];
        [self presentViewController:loginView animated:YES completion:^{NSLog(@"登录界面打开");}];
    };
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
