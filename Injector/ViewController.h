//
//  ViewController.h
//  Injector
//
//  Created by sun on 13-4-3.
//  Copyright (c) 2013年 suu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int error;
}

- (IBAction)pushToInfo:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *path;
@property (strong, nonatomic) IBOutlet UITextField *offset;
@property (strong, nonatomic) IBOutlet UITextField *change;
@property (strong, nonatomic) IBOutlet UITextView *console;

- (IBAction)exitPath:(id)sender;
- (IBAction)exitOffset:(id)sender;
- (IBAction)exitChange:(id)sender;
- (IBAction)doInject:(id)sender;

- (void)inject;

- (IBAction)followMe:(id)sender;

- (IBAction)moreInfo:(id)sender;

@end
