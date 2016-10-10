//
//  denViewController.h
//  DenisTester
//
//  Created by Gigya QA on 4/29/13.
//  Copyright (c) 2013 Gigya QA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GigyaSDK/Gigya.h>
//#import <FBSDKShareKit/FBSDKShareKit.h>

// GSResponseDelegate,GSLoginUIDelegate,GSAddConnectionsUIDelegate,GSEventDelegate,
@interface denViewController : UIViewController <UITextViewDelegate,UIWebViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,GSPluginViewDelegate,GSAccountsDelegate,GSSocializeDelegate,GSWebBridgeDelegate>
{
    // GSAPI* gsAPI;
    NSDictionary *methods;
    NSDictionary *parameters;
}
@property (weak, nonatomic) IBOutlet UITextView *textview;

- (IBAction)methodPressed:(id)sender;

- (IBAction)loginUI:(id)sender;
- (IBAction)connectUI:(id)sender;
- (IBAction)callMethod:(id)sender;
- (IBAction)autoRun:(id)sender;
- (IBAction)openDialog:(id)sender;
- (IBAction)logout:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *paramJson;
@property (weak, nonatomic) IBOutlet UITextView *Output;
@property (weak, nonatomic) IBOutlet UITextView *Title;
@property (weak, nonatomic) IBOutlet UITextField *methodText;
@property (weak, nonatomic) IBOutlet UISwitch *HTTPs;
@property (strong, nonatomic) UIActionSheet *pickerSheet;
@property (strong, nonatomic) UIPopoverController *popover;

@end

