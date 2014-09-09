//
//  FaceSelectedViewController.m
//  找玩友
//
//  Created by 军魏 on 14-8-4.
//  Copyright (c) 2014年 军魏. All rights reserved.
//

#import "FaceSelectedViewController.h"

@interface FaceSelectedViewController ()

@end

@implementation FaceSelectedViewController

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
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i = 0;i<105;i++){
        UIImage *face = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        NSMutableDictionary *dicFace = [NSMutableDictionary dictionary];
        //        if (i<10){
        //        [dicFace setValue:face forKey:[NSString stringWithFormat:@"</00%d>",i]];
        //        }else if (i<100){
        //            [dicFace setValue:face forKey:[NSString stringWithFormat:@"</0%d>",i]];
        //        }else
        //        {
        [dicFace setValue:face forKey:[NSString stringWithFormat:@"[/%d]",i]];
        //        }
        
        [temp addObject:dicFace];
    }
    //NSLog(@"weijun caiwei %@!!",temp);
    self.phrase = temp;

    [self showEmojiView];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showEmojiView{
    
    
    int xIndex = 0;
    
    int yIndex = 0;
    
    
    
    int emojiRangeArray[12] = {0,10,20,30,40,50,60,70,80,90,100,104};
    
    
    
    for (int j = 0 ; j<12 ; j++ ) {
        
        
        
        int startIndex = emojiRangeArray[j];
        
        int endIndex = emojiRangeArray[j+1];
        
        
        
        for (int i = startIndex ; i<= endIndex ; i++ ) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(10 + xIndex*32, 10 + yIndex*32, 32.0f, 32.0f);
            NSMutableDictionary *tempdic = [self.phrase objectAtIndex:i];
            //            if (i<10){
            //            UIImage *tempImage = [tempdic valueForKey:[NSString stringWithFormat:@"</00%d>",i]];
            //            [button setBackgroundImage:tempImage forState:UIControlStateNormal];
            //            } else if (i<100){
            //                UIImage *tempImage = [tempdic valueForKey:[NSString stringWithFormat:@"</0%d>",i]];
            //                [button setBackgroundImage:tempImage forState:UIControlStateNormal];
            //            }else
            //            {
            UIImage *tempImage = [tempdic valueForKey:[NSString stringWithFormat:@"[/%d]",i]];
            [button setBackgroundImage:tempImage forState:UIControlStateNormal];
            //            }
            button.tag = i;
            
            [button addTarget:self action:@selector(didSelectAFace:)forControlEvents:UIControlEventTouchUpInside];
            
            [_FaceScroView addSubview:button];
            
            
            
            xIndex += 1;
            
            if (xIndex == 9) {
                
                xIndex = 0;
                
                yIndex += 1;
                
            }
            
        }
        
    }
    
    [_FaceScroView setContentSize:CGSizeMake(300.0f, 12 + (yIndex+1)*32)];
    
}


-(IBAction) dimissFaceView
{
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"系统表情关闭！！！");}];
}




-(void) didSelectAFace
{
    
}












@end
