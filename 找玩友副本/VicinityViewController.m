#import "VicinityViewController.h"
#import "CircleImage.h"
#import "LoginCheck.h"
#import "LoginViewController.h"
#import "DXAlertView.h"
#import "AboutMeViewController.h"
#import "localInformation.h"
#import "AsynchronousRequest.h"
@interface VicinityViewController ()<AsynchronousRequestDelegate>

@end
#define Content @"Activity"
#define Method @"m"
#define UserID @"user_id"
#define ActivityID @"activity_id"
#define PostData @"data"
#define Method_post @"post"
#define Method_getList @"getList"

static NSString *baseURL = @"http://42.159.226.4:8080/zhaowanyou/api/";

@implementation VicinityViewController
{
    NSArray* dataArray;
    cellViewSetup* cellViewArray;  //用户单元格内容实现数组
    UITextView* ActivityText;
    NSMutableArray* imageArray;
    LoginCheck* loginCheck;
    localInformation* localInfo;
    UIRefreshControl* rc;
    AsynchronousRequest* asy;  //网络请求处理类
}
-(void) viewDidAppear:(BOOL)animated
{
    [bmkl setup];
    [bmkl start];  //开启定位服务与地理反编码协议;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"附近";
        self.tabBarItem.image = [UIImage imageNamed:@"Vcinity24px"];
        
    }
    return self;
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

-(void) viewDidDisappear:(BOOL)animated
{
    [bmkl down];
    //关闭定位服务与地理反编码协议;
}
-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
-(void) BMKStart
{
    bmkl = [[bmkLoction alloc] init];
    bmkl.delegate = self;
    [bmkl setup];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // headImage = [[UIImageView alloc] init];
    self.ActivityListView.delegate = self;
    self.ActivityListView.dataSource = self;
    
    [self BMKStart];
    
    loginCheck = [LoginCheck sharedLoginCheck];  //登录检测单例
    localInfo = [localInformation shareLocalInformation]; //定位信息传递类
    cellViewArray.delegate = self; //用户单元格内容协议实现
    // Do any additional setup after loading the view from its nib.
    //动态头像数组初始化
    imageArray = [[NSMutableArray alloc] init];
    //
    [self setupReflash];
}
#pragma 刷新控件初始化
-(void) setupReflash
{
    rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(reflashTable) forControlEvents:UIControlEventValueChanged];
    [self.ActivityListView addSubview:rc];
    
}
#pragma 刷新控件刷新状态
-(void) reflashTable
{
    if (rc.refreshing) {
        rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中"];
        [self getActivityListWithCityCode:@"75" andLatitude:@"30.893223" andLongitude:@"103.60196"];
    }
}
#pragma 刷新控件结束状态
-(void) reflashEnded
{
    [rc endRefreshing];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
}

-(void) setupImageArray:(NSInteger) index
{
    for (int i = 0;i < index ; i++) {
        UIImageView* imageView = [[UIImageView alloc] init];
        [imageArray addObject:imageView];
    }
}
#pragma 获取地理坐标
-(void)  getLocData:(NSString *)locaString
{
    self.LocalMessageLable.text = locaString;
    self.LocalMessageLable.font = [UIFont systemFontOfSize:15.0f];
    [localInfo setLocalInfoAddress:locaString];
}

-(void) getlatitude:(NSString *)latitude andlongtitude:(NSString *)longtitude
{
    [localInfo setLocalInfolatitude:latitude andlongtitude:longtitude];
    NSLog(@"经纬度是 %@ %@",latitude,longtitude);
}

-(IBAction) ClickFrinds
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

#pragma 表格视图
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [dataArray count]) {
        [self getActivityListWithCityCode:@"75" andLatitude:@"30.893223" andLongitude:@"103.60196"];
        return;
    }
    else
    {
        ActivityDeatailViewController* detailView = [[ActivityDeatailViewController alloc] init];
        [detailView reciveDict:[dataArray objectAtIndex:indexPath.section]];
        [self.navigationController pushViewController:detailView animated:YES];
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [dataArray count] +1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  ];
    
    for(UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.textLabel.text = nil;
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selected = NO;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if(indexPath.section == [dataArray count])
    {
        cell.textLabel.text = @"点击查看更多";
        cell.textAlignment = UITextAlignmentCenter;
        return cell;
    }
    
    [cell.contentView addSubview:[cellViewArray setupCellView:indexPath.section andCellFrame:cell.frame ]];
    UIImageView* headImage = [imageArray objectAtIndex:indexPath.section];
    headImage.frame = CGRectMake(10, 8, 50, 50);
    [headImage setImageWithURL:[[dataArray objectAtIndex:indexPath.section] valueForKey:@"photo"] placeholderImage:[UIImage imageNamed:@"gray_logo.png"]];
    
    headImage = [CircleImage returnCircleImageView:headImage andFrame:headImage.frame];
    //为每一个单元格添加一个UIimgeview  用来接收下载的图片
    //   NSLog(@"head image number is %i   and section number %i",headImage.tag,indexPath.section);
    [cell.contentView addSubview:headImage];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [dataArray count]) {
        return 58;
    }
    ActivityText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    ActivityText.text = [[dataArray objectAtIndex:indexPath.section] valueForKey:@"activity_content"];
    [ActivityText sizeToFit]; //根据内容计算单元格高度
    
    return 110+ActivityText.frame.size.height;
}

#pragma ActivityButton协议
-(void) activityGood
{
    NSLog(@"good caiwei love weijun");
}
- (void)getActivityListWithCityCode:(NSString *)cityCode andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    NSDictionary *postData = @{
                               @"city_code": cityCode,
                               @"latitude": latitude,
                               @"longitude": longitude,
                               };
    NSString *path = [baseURL stringByAppendingString:Content];
    //发送的json数据
    NSString *postJson = [postData JSONString];
    NSDictionary *dict = @{Method: Method_getList,PostData:postJson};
    asy = [[AsynchronousRequest alloc] init];
    [asy getRequestForServes:path andPostValue:dict andIsJson:YES];
    asy.delegate = self;
    
}

-(void) AsyRequestFinished:(NSArray *)valueArray
{
    dataArray = valueArray;
    [self CellView_Setup];
    [self reflashEnded];
    asy.delegate = nil;
}
#pragma 单元格数据初始化
-(void) CellView_Setup
{
    cellViewArray = [[cellViewSetup alloc] init];
    //用户单元格内容数据调入
    [cellViewArray getData:dataArray];
    //创建用户头像数组
    [self setupImageArray:[dataArray count]];
    //刷新表格
    [self.ActivityListView reloadData];
}

#pragma  异步请求完成 数据回调

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
