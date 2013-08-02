//
//  AppDelegate.h
//  Injector
//
//  Created by sun on 13-4-3.
//  Copyright (c) 2013年 suu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"

@class ViewController;
@class InfoViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *nav;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) InfoViewController *infoViewController;

- (void)pushInfoViewController;

@end
