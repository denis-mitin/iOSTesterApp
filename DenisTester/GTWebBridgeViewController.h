//
//  GTWebBridgeViewController.h
//  GigyaSDK
//
//  Created by Ran on 1/14/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GigyaSDK/Gigya.h>
#import <WebKit/WebKit.h>

@interface GTWebBridgeViewController : UIViewController <GSWebBridgeDelegate, UIWebViewDelegate>
//,WKNavigationDelegate

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) IBOutlet WKWebView *wkWebView;

@end
