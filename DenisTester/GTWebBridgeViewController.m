//
//  GTWebBridgeViewController.m
//  GigyaSDK
//
//  Created by Ran on 1/14/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "GTWebBridgeViewController.h"



@interface GTWebBridgeViewController ()

@end

@implementation GTWebBridgeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ios8
    // WKWebView
    /*
    self.wkWebView = [[WKWebView alloc] init]; // instead of creating it in the storyboard
    
    self.view = self.wkWebView; // instead of creating it in the storyboard
    
    [GSWebBridge registerWebView:self.wkWebView delegate:self];
    
    [self.wkWebView setNavigationDelegate:self];
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sociallogin.org/qa/site/andrey/mobile/href.htm", CFAbsoluteTimeGetCurrent()]]]];
    */
    
    //To use webView ios7 and down uncomment this
    [GSWebBridge registerWebView:self.webView delegate:self];
    [self.webView setDelegate:self];
    
  //  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://sociallogin.org/QA/site/denis/oauth2/jssdk/"]]];
    
     [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://qagroup1.com/QA/site/denis/oauth2/jssdk/"]]];
    
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://sociallogin.org/qa/site/andrey/mobile/href.htm?apikey=3_wJo2JBfQO09OzjVvvt6F-0oEd8igVPLLRRXXqgNGvOkQyVUP9wWZxg_kIEMnbE9n"]]];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://nhl.com"]]];
    // http://sociallogin.org/QA/site/denis/oauth2/jssdk/
    //https://sociallogin.org/QA/site/denis/oauth2/jssdk/
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([GSWebBridge handleRequest:request webView:webView]) {
        return NO;
    }
    
    return YES;
}

 /*- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([GSWebBridge handleRequest:[navigationAction request] webView:webView]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
   
}*/

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [GSWebBridge webViewDidStartLoad:webView];
}

- (void)viewDidUnload
{
    [GSWebBridge unregisterWebView:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
