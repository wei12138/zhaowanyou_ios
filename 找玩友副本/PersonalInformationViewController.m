//
//  PersonalInformationViewController.m
//  找玩友
//
//  Created by 军魏 on 14-7-21.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "PersonalInformationViewController.h"
@interface PersonalInformationViewController ()

@end

@implementation PersonalInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) segementViewChange:(id)sender
{
   
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            [[self.basicView.subviews objectAtIndex:0] removeFromSuperview];
            SegmentOneViewController *seg1 = [[SegmentOneViewController alloc] init];
            [self.basicView addSubview:seg1.view];
        }
            break;
            
       case 1:
        {
            [[self.basicView.subviews objectAtIndex:0] removeFromSuperview];
            SegmentTwoViewController* seg2 = [[SegmentTwoViewController alloc] init];
            [self.basicView addSubview:seg2.view];
        }
            break;
            
        case 2:
        {
            [[self.basicView.subviews objectAtIndex:0] removeFromSuperview];
             

        }
            break;
        
         case 3:
        {
            [[self.basicView.subviews objectAtIndex:0] removeFromSuperview];
          
        }
            break;
            
       default:
            break;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    m = [[CCSegmentedControl alloc] initWithItems:@[@"个人资料",@"图片墙",@"发起的活动",@"发布的玩点"]];
    m.frame = CGRectMake(0, 254, 320, 30);
    m.backgroundColor = [self colorWithHexString:@"#F1F1F1"];
    m.selectedSegmentTextColor = [UIColor orangeColor];
    
    SegmentOneViewController *seg1 = [[SegmentOneViewController alloc] init];
    [self.basicView addSubview:seg1.view];
    
    
    [m addTarget:self action:@selector(segementViewChange:) forControlEvents:UIControlEventValueChanged];
   // [self.basicView removeFromSuperview];
    [self.view addSubview:m];
    
    
}
- (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}


-(void) viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.title = @"玩友资料";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backView
{
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"玩友信息界面关闭");}];
    
}






@end
