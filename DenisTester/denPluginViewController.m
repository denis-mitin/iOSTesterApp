//
//  denPluginViewController.m
//  DenisTester
//
//  Created by Gigya QA on 6/15/14.
//  Copyright (c) 2014 Gigya QA. All rights reserved.
//

#import "denPluginViewController.h"


@interface denPluginViewController ()

@end

@implementation denPluginViewController

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
	// Do any additional setup after loading the view.
    
    self.pluginView = [[GSPluginView alloc] initWithFrame:CGRectMake(0, 500, 600, 500)];
    self.pluginView.delegate = self;
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setObject: @"ios" forKey: @"categoryID"];
    //[mutableDict setObject: @"Test_1" forKey: @"categoryID"];
    [mutableDict setObject: @"2"   forKey:@"version"];
    [mutableDict setObject: @"lang"   forKey:@"he"];
    
    [self.pluginView loadPlugin:@"comments.commentsUI" parameters:mutableDict];
    [self.view addSubview:self.pluginView];
     
    
    
   
    
    mutableDict = [NSMutableDictionary dictionary];
    //[mutableDict setObject:@"Mobile-login" forKey:@"screenSet"];
    [mutableDict setObject:@"new-RegistrationLogin" forKey:@"screenSet"];
    [mutableDict setObject: @"lang"   forKey:@"he"];
    
    GSPluginView *pluginView2 = [[GSPluginView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    pluginView2.delegate = self;
    [pluginView2 loadPlugin:@"accounts.screenSet" parameters:mutableDict];
    [self.view addSubview:pluginView2];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(closeView:)
     forControlEvents:UIControlEventTouchUpInside];
    //[but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Close" forState:UIControlStateNormal];
    button.frame = CGRectMake(300.0, 600.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    UIButton *buttonRefresh = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonRefresh addTarget:self
               action:@selector(refreshView:)
     forControlEvents:UIControlEventTouchUpInside];
    //[but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [buttonRefresh setTitle:@"Refresh" forState:UIControlStateNormal];
    buttonRefresh.frame = CGRectMake(400.0, 600.0, 160.0, 40.0);
    [self.view addSubview:buttonRefresh];
    
    
       /* UIApplication * application = [UIApplication sharedApplication];
     
    if([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
            NSLog(@"Multitasking Supported");
         
            __block UIBackgroundTaskIdentifier background_task;
            background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
             
                    //Clean up code. Tell the system that we are done.
                    [application endBackgroundTask: background_task];
                    background_task = UIBackgroundTaskInvalid;
                }];
         
            //To make the code block asynchronous
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             
                    //### background task starts
                    NSLog(@"Running in the background\n");
                    while(TRUE)
                        {
                                NSLog(@"Background time Remaining: %f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
                                [NSThread sleepForTimeInterval:1]; //wait for 1 sec
                            }
                    //#### background task ends
             
                    //Clean up code. Tell the system that we are done.
                    [application endBackgroundTask: background_task];
                    background_task = UIBackgroundTaskInvalid; 
                });
    }
    else
    {
            NSLog(@"Multitasking Not Supported");
    }*/
}

- (void)pluginView:(GSPluginView *)pluginView firedEvent:(NSDictionary *)event
{
    NSLog(@"Plugin fired event \n%@ ", event);
   // self.Output.text = [NSString stringWithFormat:@"Plugin fired event \n%@ ", event];
}


- (void)pluginView:(GSPluginView *)pluginView didFailWithError:(NSError *)error {
    NSLog(@"Failed with error \n%@ ", error);
    //self.Output.text = [NSString stringWithFormat:@"Failed with error \n%@ ", error];
}

- (void)pluginView:(GSPluginView *)pluginView finishedLoadingPluginWithEvent:(NSDictionary *)event
{
    NSLog(@"Load event \n%@ ", event);
    //self.Output.text = [NSString stringWithFormat:@"Load event \n%@ ", event];
}

-(void) refreshView:(UIButton*)sender
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setObject: @"ios" forKey: @"categoryID"];
    [mutableDict setObject: @"2"   forKey:@"version"];
    
    [self.pluginView loadPlugin:@"comments.commentsUI" parameters:mutableDict];
}

-(void) closeView:(UIButton*)sender
{
    NSLog(@"you clicked on button %@", sender.tag);
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// fix for UIWebView crashing when quickly clicking on HTML SELECT element multiple times
// http://openradar.appspot.com/19469574#aglvcGVucmFkYXJyFAsSB0NvbW1lbnQYgICAoOugswoM
// http://stackoverflow.com/questions/25908729/ios8-ipad-uiwebview-crashes-while-displaying-popover-when-user-taps-drop-down-li/26692948#26692948
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_USEC), dispatch_get_main_queue(),
                   ^{
                       if ([viewControllerToPresent respondsToSelector:@selector(popoverPresentationController)] &&
                           viewControllerToPresent.popoverPresentationController &&
                           !viewControllerToPresent.popoverPresentationController.sourceView)
                       {
                           return;
                       }
                       
                       [super presentViewController:viewControllerToPresent animated:flag completion:completion];
                   });
}




@end
