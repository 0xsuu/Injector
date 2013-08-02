//
//  InfoViewController.m
//  Injector
//
//  Created by sun on 13-4-3.
//  Copyright (c) 2013年 suu. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)followMe:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/u/2717340833?topnav=1&wvr=5"]];
}

- (IBAction)moreInfo:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://iamsuu.lofter.com/post/12d495_51f196"]];
}

@end
