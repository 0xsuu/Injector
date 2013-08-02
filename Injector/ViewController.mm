//
//  ViewController.m
//  Injector
//
//  Created by sun on 13-4-3.
//  Copyright (c) 2013年 suu. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"
#import "AppDelegate.h"
#include <stdio.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.path setKeyboardAppearance:UIKeyboardAppearanceAlert];
    [self.offset setKeyboardAppearance:UIKeyboardAppearanceAlert];
    [self.change setKeyboardAppearance:UIKeyboardAppearanceAlert];
    
}

- (void)inject
{
    FILE *fp,*fpNew;
    
    fp = fopen("/var/mobile/target","rb");
    fpNew = fopen("/var/mobile/new","wb");
    
    if (fpNew == 0)
    {
        self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"#warning: failed to create new file"];
        error = 1;
    }
    else
    {
        self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"new file created"];
    }
    
    if (fp == 0)
    {
        self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"#warning: failed to read raw file"];
        error = 1;
    }
    else
    {
        self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"reading raw file"];
    }
    
    fseek(fp,0,SEEK_SET);
    
    char output;
    output = fgetc(fp);
    
    int count = 0;
    int offset = 0;
    offset = strtoul([self.offset.text UTF8String], 0, 16);
    self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"dumping"];

    while(!feof(fp))
    {
        if (count % 10000 == 0)
        {
            self.console.text = [NSString stringWithFormat:@"%@%@",self.console.text,@"."];
        }
        
        if (count == offset)
        {
            self.console.text = [NSString stringWithFormat:@"%@\n%@:0x%X",self.console.text,@"injecting offset",offset];
            fputc(strtoul([self.change.text UTF8String], 0, 16),fpNew);
            self.console.text = [NSString stringWithFormat:@"%@\n%02X changed to %02lX",self.console.text,output,strtoul([self.change.text UTF8String], 0, 16)];
            self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"dumping"];
        }
        else
        {
            fputc(output,fpNew);
        }
        output=fgetc(fp);
        count++;
    }
    self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"dump completed"];
    fclose(fp);
    fclose(fpNew);
}

- (IBAction)followMe:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/u/2717340833?topnav=1&wvr=5"]];
}

- (IBAction)moreInfo:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://iamsuu.lofter.com/post/12d495_51f196"]];
}

- (IBAction)pushToInfo:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] pushInfoViewController];
}

- (IBAction)exitPath:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)exitOffset:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)exitChange:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)doInject:(id)sender
{
    self.console.text = nil;
    
    if ([self.path.text isEqualToString:@""] || [self.offset.text isEqualToString:@""] || [self.change.text isEqualToString:@""])
    {
        UIAlertView *emptyWarning = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Invalid input(s)" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [emptyWarning show];
        
        return;
    }
    self.console.text = @"initializing";
    system("rm -r /var/mobile/target;rm -r /var/mobile/new");
    
    if (system([[NSString stringWithFormat:@"cp %@ /var/mobile/target",self.path.text] UTF8String]))
    {
        self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"failed to initialize"];
        return;
    }
    
    //[NSThread detachNewThreadSelector:@selector(inject) toTarget:self withObject:nil];
    [self performSelectorOnMainThread:@selector(inject) withObject:nil waitUntilDone:NO];
    
    if (error)
    {
        return;
    }
    
    self.console.text = [NSString stringWithFormat:@"%@\n%@\n%@",self.console.text,@"saving backup",@"overwriting new file"];
    if (!system([[NSString stringWithFormat:@"cd /var/mobile/;mv %@ %@_backup;cp new %@;chown -R mobile %@;chmod 751 %@",self.path.text,self.path.text,self.path.text,self.path.text,self.path.text] UTF8String]))
    {
        self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"completed"];
    }
    else
    {
        self.console.text = [NSString stringWithFormat:@"%@\n%@",self.console.text,@"failed with system()"];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.path resignFirstResponder];
    [self.offset resignFirstResponder];
    [self.change resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
