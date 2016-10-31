//
//  denAppDelegate.m
//  DenisTester
//
//  Created by Gigya QA on 4/29/13.
//  Copyright (c) 2013 Gigya QA. All rights reserved.
//

#import "denAppDelegate.h"



@implementation denAppDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [Gigya handleOpenURL:url
                    application:application
              sourceApplication:sourceApplication
                     annotation:annotation];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options
{
    return [Gigya handleOpenURL:url app:app options:options];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // For plist
    // GigyaTouchIDEnabled Yes
    
    //Override point for customization after application launch.
   //[Gigya initWithAPIKey:@"3_iquS4Hh7XC1ptnsWQfHbf6PoiViogP8v22jQ0SQRcCFnEpj95MGYLlZYfq3RI4d5" application:application launchOptions:launchOptions APIDomain:@"eu1.gigya.com"]; //to test saml screenset
    
    //[Gigya initWithAPIKey:@"3_PrJU94R8nIylcnsY0nyf1fQgq62FHZ7bMOI-73sUZHw_aM_uvj9IS-tODCSfHPw9" application:application launchOptions:launchOptions]; //sociallogin.org local il1a
    
    //[Gigya initWithAPIKey:@"3_1ST4slgK10MUhy4K4ehagNjgoXR97EoqKAZsOjebrzvjqMoH55F3zpOo3wgq7JUS"  application:application launchOptions:launchOptions APIDomain:@"ru1.gigya.com"]; //denis.ru
  //main
    [Gigya initWithAPIKey:@"3_wJo2JBfQO09OzjVvvt6F-0oEd8igVPLLRRXXqgNGvOkQyVUP9wWZxg_kIEMnbE9n" application:application launchOptions:launchOptions]; //sociallogin.org Prod 176663209146906 / Sociallogin.org - qa-app10
///self.gsAPI = [[GSAPI alloc] initWithAPIKey:@"3_wJo2JBfQO09OzjVvvt6F-0oEd8igVPLLRRXXqgNGvOkQyVUP9wWZxg_kIEMnbE9n"];
    //sociallogin.org
   //[Gigya initWithAPIKey:@"2_DJDxNTrvx_QC313MDs_6Byos-ua1lHs5S1-fH32d-MznZn-gLccOid6IYt1D2f26" application:application launchOptions:launchOptions]; //bsocialize.com
  // [Gigya initWithAPIKey:@"3_9Ss9hAAwCWuF6JJDStpwF9UqIFCO5SU0XnXl1QjsYwW_R262yICuBiA8wpjzp6aQ" APIDomain:@"eu1.gigya.com"]; //bsocializeeu.com
 
    //[Gigya initWithAPIKey:@"3_rnylxaXmqRFLbILkPIV1cQJhIvlMOwjcFSmKOQiuWxPmd5KBKOP_LUdfS6z_luEh" application:application launchOptions:launchOptions];
 // [Gigya initWithAPIKey:@"2_NGWPcIQU-iNWg06QwYu3Y9wDseMse_9AeQMBhfaLzjhTYIjUaFDO1vwri0v8Ga3R" application:application launchOptions:launchOptions]; //qagroup.com 740588265999474 qagrv2 - Test1
    //[Gigya initWithAPIKey:@"3_WsQePJtcdFQFr0jEi1G1ZtCs9Q3IYEXbCGmtVGCzLOU_SMJua_5PToIKKfVucB39"]; //guy
    //[Gigya initWithAPIKey:@"3_cXcJmTJFeAvPAxrb3Y4bVs3RDIQbX4uhpQ7alLFpA5rIARD1U7JyU5LG63N67FQg" ]; //american idol
//[Gigya initWithAPIKey:@"2_pd9mRZHRYIukd6DpOMReSfqTpuF0K4eHN_cz3hYmMGx8zmPE3ObXwGQCSKZ4FS1O" ]; //nhl.com
    
    
    //[Gigya initWithAPIKey:@"3_9Ss9hAAwCWuF6JJDStpwF9UqIFCO5SU0XnXl1QjsYwW_R262yICuBiA8wpjzp6aQ" APIDomain:@"eu1.gigya.com"]; // bsocializeeu.com
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [Gigya handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
