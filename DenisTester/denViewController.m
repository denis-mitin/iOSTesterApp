//
//  denViewController.m
//  DenisTester
//
//  Created by Gigya QA on 4/29/13.
//  Copyright (c) 2013 Gigya QA. All rights reserved.
//

//GigyaLoginDontLeaveApp Yes - add to plist
#import "denViewController.h"
#import "denAppDelegate.h"
#import "denPluginViewController.h"
#import "ActionSheetStringPicker.h"

@interface denViewController ()

@property (nonatomic, copy) GSUserInfoHandler LoginHandler;

@end

@implementation denViewController
@synthesize methodText;
@synthesize Output;
@synthesize paramJson;
@synthesize HTTPs;



NSString *regToken;

-(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [Gigya setSocializeDelegate:self];
    [Gigya setAccountsDelegate:self];
    //[Gigya setNetworkActivityIndicatorEnabled:false];
    //[Gigya setUseHTTPS:false];
    
    [Gigya setRequestTimeout:10000];
    
    NSLog([NSString stringWithFormat:@"%f", [Gigya requestTimeout]]);
    
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logoutButton addTarget:self
                      action:@selector(logout:)
            forControlEvents:UIControlEventTouchUpInside];
    //[but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    logoutButton.frame = CGRectMake(100.0, 110.0, 160.0, 40.0);
    [self.view addSubview:logoutButton];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    if (infoDict[@"TesterVerifySessionOnInit"] && [infoDict[@"TesterVerifySessionOnInit"] boolValue])
        [self verifySession];
    
    [self postToLog: [NSString stringWithFormat:@"Running Gigya SDK %@ \n FB SDK %@", GSGigyaSDKVersion, [FBSDKSettings sdkVersion]]];

}

- (void)logout:(UIButton*)sender
{
    [self call:@"socialize.logout" param:@"{}"];
}

- (IBAction)verifySession:(id)sender {
    [self verifySession];
}

- (void)verifySession
{
    [self postToLog:[Gigya isSessionValid] ? @"VALID SESSION" : @"INVALID SESSION"];
    
    GSRequest *request = [GSRequest requestForMethod:@"socialize.getUserInfo"];
    [request sendWithResponseHandler:^(GSResponse * _Nullable response, NSError * _Nullable error) {
        NSString *logOutput = error ? [error description] : @"";
        
        if (response)
            logOutput = [NSString stringWithFormat:@"%@\n\n%@", logOutput, [response JSONString]];
        
        [self postToLog:[NSString stringWithFormat:@"%@\n\n%@", self.Output.text, logOutput]];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"memory warning");
}


- (void)postToLog:(NSString *) msgString
{
    NSLog(msgString);
    //self.Output.text = [NSString stringWithFormat:@"%@ \n %@", msgString, self.Output.text];
    self.Output.text = [NSString stringWithFormat:@"%@", msgString];
}

- (IBAction)methodPressed:(id)sender {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Photo"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
     encoding:NSUTF8StringEncoding
     error:NULL];

    
    methods = @{@"socialize": @[@"getSession",@"addConnection",@"checkin",@"deleteAccount",@"delUserSettings",@"exportUsers",@"facebookGraphOperation",@"getAlbums",@"getContacts",@"getFeed",@"getFriendsInfo",@"getPhotos",@"getPlaces",@"getRawData",@"getReactionsCount",@"getSessionInfo",@"getTopShares",@"getUserInfo",@"getUserSettings",@"incrementReactionsCount",@"login",@"logout",@"notifyLogin",@"notifyRegistration",@"publishUserAction",@"removeConnection",@"sendNotification",@"setStatus",@"setUID",@"setUserInfo",@"setUserSettings",@"shortenURL",@"addConnectionsUI",@"editConnectionsUI",@"feedUI",@"followBarUI",@"friendSelectorUI",@"loginUI",@"ReactionsBarUI",@"shareBarUI",@"shareUI"],
                @"accounts": @[@"deleteAccount",@"deleteScreenSet",@"finalizeRegistration",@"getAccountInfo",@"getPolicies",@"getSchema",@"getScreenSets",@"importProfilePhoto",@"initRegistration",@"isAvailableLoginID",@"linkAccounts",@"login",@"logout",@"notifyLogin",@"MyPhotoUI",@"publishProfilePhoto",@"register",@"resendVerificationCode",@"resetPassword",@"screenSet",@"search",@"setAccountInfo",@"setPolicies",@"setProfilePhoto",@"setSchema",@"setScreenSet"],
                
                @"comments": @[@"postComment",@"commentsUI"],
                @"chat": @[@"getMessages",@"chatUI"],
                @"pluginView": @[@"pluginView",@"pluginView"],
                @"permissions": @[@"requestPublishPermissions",@"requestReadPermissions"]
                };
    
    parameters = @{@"addConnection": @"{\"provider\":\"twitter\"}",
                   @"commentsUI": @"{\"categoryID\":\"ios\",\"version\":\"2\"}",
                   @"finalizeRegistration": [NSString stringWithFormat:@"{ \"regToken\":\"%@\"}", regToken],
                   @"login": @"{\"loginID\":\"sylildix@gmail.com\", \"password\":\"Q123456w\"}",
                   //@"login": [NSString stringWithFormat:@"{ \"provider\":\"facebook\", \"loginMode\":\"link\", \"regToken\":\"%@\"}", regToken],
                   @"notifyLogin": @"{\"siteUID\":\"id1\"}",
                   // @"{\"loginID\":\"lnflkgts@gmail.com\", \"password\":\"Q123456w\"}", // prod
                   @"register": [NSString stringWithFormat:@"{\"email\":\"%@@gmail.com\", \"password\":\"Q123456w\", \"finalizeRegistration\":true, \"regToken\":\"%@\"}",[self generateRandomString:8], regToken],
                   @"removeConnection": @"{\"provider\":\"facebook\"}",
                   @"resetPassword": @"{\"loginID\":\"lnflkgts@gmail.com\"}",
                   
                   @"screenSet": [NSString stringWithFormat:@"{\"screenSet\":\"Android-RegistrationLogin\",\"startScreen\":\"gigya-register-screen\",\"lang\":\"en\",                                                    \"facebookLoginBehavior\":\"%@\"}", @(FBSDKLoginBehaviorNative)],
                   //Saml
                   //@"screenSet": @"{\"screenSet\":\"Default-RegistrationLogin\",\"customButton\": {\"type\": \"saml\", \"providerName\":\"OTP\",\"idpName\":\"otp-newUsage\",\"iconURL\": \"http://icons.iconarchive.com/icons/chrisbanks2/cold-fusion-hd/128/mickey-mouse-icon.png\",\"logoURL\": \"http://icons.iconarchive.com/icons/chrisbanks2/cold-fusion-hd/128/boid-icon.png\",\"lastLoginIconURL\":\"http://icons.iconarchive.com/icons/chrisbanks2/cold-fusion-hd/128/mickey-mouse-icon.png\",\"position\":3} }",
                   
                   
                   @"setAccountInfo": [NSString stringWithFormat: @"{\"regToken\":\"%@\", \"profile\":{\"zip\":55555}}",regToken],
                   @"chatUI" : @"{\"categoryID\":\"274467960\",\"width\":300,\"height\":450}",
                   
                    @"shareUI": @"{\"userAction\":{ \"title\": \"This is a title's\", \"linkBack\": \"http://sociallogin.org/QA/site/denis/oauth2/jssdk/\", \"userMessage\": \"This is a user message \", \"description\": \"This is a description\"},}",
                   
                   @"shareBarUI": @"{\"userAction\":{ \"title\": \"This is a titles\", \"linkBack\": \"http://www.etoday.ru/\", \"userMessage\": \"This is a user message \", \"description\": \"This is a description\"},\"shareButtons\":\"facebook-like,twitter-tweet,google-plusone\"}",
                   @"ReactionsBarUI": @"{\"userAction\":{ \"title\": \"This is a title's\", \"linkBack\": \"http://www.etoday.ru/\", \"userMessage\": \"This is a user message \", \"description\": \"This is a description\"},\"reactions\":[{ \"ID\": \"Recommend\", \"text\": \"Recommend\"},{ \"ID\": \"lol\", \"text\": \"LOL\"}],\"barID\":\"test\",\"showCounts\": \"top\"}",
                   
                   @"setStatus": @"{\"status\":\"aaaaa\"}",
                   
                   @"setProfilePhoto": [NSString stringWithFormat: @"{\"photoBytes\":\"%@\", \"publish\":true}",content],
                   
                   @"requestPublishPermissions": @"{\"permissions\":\"publish_actions,manage_pages\"}",
                   @"requestReadPermissions": @"{\"permissions\":\"email,user_likes\"}",
                   };
    
    NSMutableArray *namespaceMethodsPrefixed = [[NSMutableArray alloc] init];
    for (NSString *namespace in methods)
    {
        NSArray *namespaceMethods = methods[namespace];
        
        for (NSString *method in namespaceMethods)
            [namespaceMethodsPrefixed addObject:[NSString stringWithFormat:@"%@.%@", namespace, method]];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"Pick a method"
                                            rows:namespaceMethodsPrefixed
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSArray *selectValueParts = [selectedValue componentsSeparatedByString:@"."];
                                           NSArray *method = selectValueParts[[selectValueParts count] - 1];
                                           
                                           self.methodText.text = selectedValue;
                                           self.paramJson.text = parameters[method];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Method picker canceled");
                                     }
                                          origin:sender];
}

- (void)userDidLogout {
    [Gigya getSessionWithCompletionHandler:^(GSSession * _Nullable session) {
        NSLog(@"userDidLogout \n Is valid session: %@", [session isValid] ? @"YES" : @"NO");
        self.Title.text = [NSString stringWithFormat:@"userDidLogout \n Is valid session: %@", [session isValid] ? @"YES" : @"NO"];
    }];
}
- (void)userDidLogin:(GSUser *)user {
    NSLog(@"userDidLogin \n%@", user);
    self.Title.text = [NSString stringWithFormat:@"userDidLogin \n%@", user];
}

- (void)userInfoDidChange:(GSUser *)user {
    NSLog(@"userInfoDidChange \n%@", user);
    self.Title.text = [NSString stringWithFormat:@"userInfoDidChange \n%@", user];
}

- (void)accountDidLogout {
    [Gigya getSessionWithCompletionHandler:^(GSSession * _Nullable session) {
        NSLog(@"accountDidLogout \n Is valid session: %@", [session isValid] ? @"YES" : @"NO");
        self.Title.text = [NSString stringWithFormat:@"accountDidLogout \n Is valid session: %@", [session isValid] ? @"YES" : @"NO"];
    }];
}
- (void)accountDidLogin:(GSAccount *)user {
    NSLog(@"accountDidLogin \n%@", user);
    self.Title.text = [NSString stringWithFormat:@"accountDidLogin \n%@", user];
    
}

- (void)ResponseHandler:(GSResponse*)response err:(NSError*)error {
    if (!error) {
        NSLog(@"%@", response);
         [Gigya getSessionWithCompletionHandler:^(GSSession * _Nullable session) {
        self.Output.text = [NSString stringWithFormat:@"%@ isLoggedIn = %i", [response JSONString], [session isValid ]];
         }];
        NSString *reg = [response objectForKey:@"regToken"];
        
        if( [reg hasPrefix:@"RT1"] )
        {
            regToken = [response objectForKey:@"regToken"];
        }
    }
    else {
        NSLog(@"%@", error);
        self.Output.text = [NSString stringWithFormat:@"error = %@ response = %@", error, [response JSONString]];
    }
}

- (void)LoginHandler:(GSUser*)response err:(NSError*)error {
    if (!error) {
         [Gigya getSessionWithCompletionHandler:^(GSSession * _Nullable session) {
        NSLog([NSString stringWithFormat:@"%@ \n isLoggedIn = %i token = %@", [response JSONString], [ session isValid ], session.token]);
        self.Output.text = [NSString stringWithFormat:@"%@ \n isLoggedIn = %i token = %@", response, [ session isValid ], session.token];
                            }];
    }
    else {
        NSLog(@"%@", error);
         [Gigya getSessionWithCompletionHandler:^(GSSession * _Nullable session) {
        self.Output.text = [NSString stringWithFormat:@"%@ \n isLoggedIn = %i response = %@", error, [session isValid ], response ];
         }];
    }
    
}


- (void) NotifyHandler:(GSResponse*)response err:(NSError*)error {
    if (!error) {
        NSLog(@"%@", response);
         [Gigya getSessionWithCompletionHandler:^(GSSession * _Nullable session) {
        self.Output.text = [NSString stringWithFormat:@"%@ isLoggedIn = %i", [response JSONString], [ session isValid ]];
         }];
    }
    else {
        NSLog(@"%@", error);
        self.Output.text = [NSString stringWithFormat:@"%@", error];
    }
}

- (IBAction)loginUI:(id)sender {
    // NSLog(@"your text is %@",self.textview.text);
    NSLog(@"Calling LoginUI");
    
    @try { // showLoginProvidersDialogOver:self showLoginProvidersPopoverFrom:sender
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [Gigya showLoginProvidersPopoverFrom:sender
                                       providers:@[@"facebook", @"twitter", @"googleplus", @"yahoo", @"linkedin",@"*"]
             //providers:@[@"*"]
                                      parameters:@{ @"googlePlusExtraPermissions": @"https://www.googleapis.com/auth/wallet", @"cid":@"1200",@"pendingRegistration":@"true",@"facebookExtraPermissions":@"rsvp_event",
                                                    @"facebookReadPermissions":@"user_events",
                                                    @"captionText":@"My Login",
                                                    @"regSource":@"loginUIPopOver",
                                                   // @"sessionExpiration":@"30"

                                                    
                                                      //@"facebookLoginBehavior":@(FBSDKLoginBehaviorWeb)
                                                    //@"forceAuthentication":@"true"
                                                    }
                               completionHandler:^(GSResponse *response, NSError *error) {
                                   [self LoginHandler:response err:error];
                               }];
        }
        else {
            [Gigya showLoginProvidersDialogOver:self
                                      providers:@[@"facebook", @"twitter", @"googleplus", @"yahoo", @"linkedin",@"*"]
                                     parameters:@{ @"googleExtraPermissions": @"https://www.googleapis.com/auth/wallet", @"cid":@"1200",@"pendingRegistration":@"true",
                                                   @"captionText":@"My Login",
                                                   @"regSource":@"loginUIDialog",
                                                   @"facebookLoginBehavior":@(FBSDKLoginBehaviorSystemAccount)

                                                   //@"facebookLoginBehavior":@(FBSDKLoginBehaviorWeb)
                                                  //  old @"facebookLoginBehavior":@(FBSessionLoginBehaviorUseSystemAccountIfPresent) //FBSessionLoginBehaviorWithFallbackToWebView
                                                   //@"forceAuthentication":@"true"
                                                   } completionHandler:^(GSResponse *response, NSError *error) {
                                                       [self LoginHandler:response err:error];
                                                   }];
        }
    }
    @catch (NSException *exception) {
        self.Output.text = [NSString stringWithFormat:@"%@", exception];
        NSLog(@"%@", [NSString stringWithFormat:@"%@", exception]);
    }
}

- (IBAction)connectUI:(id)sender {
    // NSLog(@"your text is %@",self.textview.text);
    NSLog(@"Calling ConnectUI");
    
    @try { //showAddConnectionProvidersDialogOver:self showAddConnectionProvidersPopoverFrom:sender
        [Gigya showAddConnectionProvidersDialogOver:self
                                          providers:@[@"facebook", @"twitter", @"googleplus", @"yahoo", @"linkedin"]
                                         parameters:@{ @"googleExtraPermissions": @"https://www.googleapis.com/auth/wallet", @"cid":@"1200", @"forceAuthentication":@"true",@"facebookExtraPermissions":@"rsvp_event,sms",
//                                                       @"facebookLoginBehavior":@(FBSDKLoginBehaviorNative),
                                                       @"facebookReadPermissions":@"user_events",
                                                       @"captionText":@"My Connect",
                                                       @"regSource":@"connectUI"}
         
                                  completionHandler:^(GSResponse *response, NSError *error) {
                                      [self LoginHandler:response err:error];
                                  }];
    }
    @catch (NSException *exception) {
        self.Output.text = [NSString stringWithFormat:@"%@", exception];
        NSLog([NSString stringWithFormat:@"%@", exception]);
    }
}


- (void)call:(NSString*)m param:(NSString*)p {
    
    NSString * jsonString = p; //@"{\"userAction\":{ \"title\": \"This is a titles\", \"linkBack\": \"http://www.etoday.ru/\", \"userMessage\": \"This is a user message \", \"description\": \"This is a description\"},\"shareButtons\":\"facebook-like,twitter-tweet,google-plusone,facebook,twitter\"}";
    NSData * data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error = nil;
    //id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (!json) {
        json = [NSMutableDictionary dictionary];
    }
    // [json setValue:@(FBSessionLoginBehaviorWithFallbackToWebView) forKey:@"facebookLoginBehavior"];
    [json setValue:@"This is caption"  forKey:@"captionText"];
    GSRequest *request = [GSRequest requestForMethod:m
                                          parameters:json];
    request.useHTTPS = self.HTTPs.on;
    
    
    NSString *prov = [json objectForKey:@"provider"];
    
    //[json removeObjectForKey:@"provider"];
    
    
    
    if([m isEqualToString:@"socialize.login"] ) //|| [m isEqualToString:@"login"]
    {
        //[gsAPI login:pParams ViewController:self delegate:self context:nil];
        NSLog(@"Calling login");
        @try {
            //if(dontLeave)
            [Gigya loginToProvider:prov parameters:json over:self completionHandler:^(GSResponse *response, NSError *error) {
                    [self LoginHandler:response err:error];
                }];
            //showLoginDialogOver:self provider:prov loginToProvider:prov
           /* else
                
                [Gigya loginToProvider:prov
                            parameters:json
                     completionHandler:^(GSResponse *response, NSError *error) {
                         [self LoginHandler:response err:error];
                     }];*/
            
        }
        @catch (NSException *exception) {
            self.Output.text = [NSString stringWithFormat:@"%@", exception];
            NSLog(@"%@", [NSString stringWithFormat:@"%@", exception]);
        }
        
    }
    else if([m isEqualToString:@"socialize.logout"] || [m isEqualToString:@"logout"] ) //|| [m isEqualToString:@"accounts.logout"]
    {
        NSLog(@"Calling logout ");
        @try {
            [Gigya logoutWithCompletionHandler:^(GSResponse *response, NSError *error) {
                [self ResponseHandler:response err:error];
            }];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
            self.Output.text = [NSString stringWithFormat:@"%@", exception];
        }
    }
    else if([m isEqualToString:@"socialize.addConnection"] || [m isEqualToString:@"addConnection"])
    {
        NSLog(@"Calling addConnection");
        @try { // howAddConnectionDialogOver:self provider:prov loginToProvider:prov
            [Gigya addConnectionToProvider:prov
                                parameters:json
                         completionHandler:^(GSResponse *response, NSError *error) {
                             [self LoginHandler:response err:error];
                         }];
            
        }
        @catch (NSException *exception) {
            self.Output.text = [NSString stringWithFormat:@"%@", exception];
            NSLog([NSString stringWithFormat:@"%@", exception]);
        }
    }
    /*else if([m isEqualToString:@"socialize.removeConnection"] || [m isEqualToString:@"removeConnection"])
     {
     NSLog(@"Calling removeConnection");
     @try {
     [Gigya removeConnectionToProvider:prov
     completionHandler:^(GSResponse *response, NSError *error) {
     [self LoginHandler:response err:error];
     }];
     }
     @catch (NSException *exception) {
     NSLog(@"%@", exception);
     self.Output.text = [NSString stringWithFormat:@"%@", exception];
     }
     
     }*/
    else if([m isEqualToString:@"getSession"] || [m isEqualToString:@"socialize.getSession"])
    {
        //sess = [gsAPI getSession];
        NSLog(@"Session");
       [Gigya getSessionWithCompletionHandler:^(GSSession * _Nullable session) {
            NSLog([NSString stringWithFormat:@"%@ \n %@ ", [session  description], [session secret]]);
            self.Output.text = [NSString stringWithFormat:@"%@ \n %@  \n %i", [session description], [session secret], [Gigya useHTTPS]];
        }];
    }
    else if([m isEqualToString:@"setSession"] || [m isEqualToString:@"socialize.setSession"])
    {
        // [gsAPI setSession:sess];
        //NSLog(@"Calling setSession with token = %@", sess.accessToken);
    }
    else if([m isEqualToString:@"notifyLogin"])
    {
        NSLog(@"NotifyLogin");
        @try {
            [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
                [self NotifyHandler:response err:error];
            }
             ];
        }
        @catch (NSException *exception) {
            NSLog(@"%@Exception", exception);
            self.Output.text = [NSString stringWithFormat:@"%@", exception];
        }
    }
    else if([m isEqualToString:@"accounts.screenSet"] || [m rangeOfString:@"UI"].location != NSNotFound)
        //[m isEqualToString:@"comments.commentsUI"])
    {
        NSLog(@"plugin");
        
        
        @try {
            [Gigya showPluginDialogOver:self plugin:m parameters:json completionHandler:^(BOOL closedByUser, NSError *error) {
               /* GSRequest *req = [GSRequest requestForMethod:@"accounts.getAccountInfo"];
                
                [req sendWithResponseHandler:^(GSResponse *resp, NSError*error) {
                    
                    if (!error) {
                        NSLog(@"#### Success! Use the response object. %@",resp);
                        self.Output.text = @"# Success! Use the response object. %@",resp;
                        
                    }
                    else {
                        NSLog(@"Error. %@",error);
                        self.Output.text = @"Error. %@",error;
                    }
                }];*/
                NSLog(@"Closed by user = %i \n%@ ", closedByUser, error);
                self.Output.text = [NSString stringWithFormat:@"Closed by user = %i %@ ", closedByUser, error];
            } delegate:self];
            
            
            /* GSPluginView *pluginView = [[GSPluginView alloc] initWithFrame:CGRectMake(0, 0, 600, 500)];
             pluginView.delegate = self;
             [pluginView loadPlugin:m parameters:json];
             [self.view addSubview:pluginView];
             
             NSMutableDictionary *mutableDict;
             [mutableDict setObject:@"screenSet" forKey:@"Mobile-login"];
             
             GSPluginView *pluginView2 = [[GSPluginView alloc] initWithFrame:CGRectMake(0, 600, 300, 500)];
             pluginView.delegate = self;
             [pluginView2 loadPlugin:@"accounts.screenSet" parameters:mutableDict];
             [self.view addSubview:pluginView2];*/
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
            self.Output.text = [NSString stringWithFormat:@"%@", exception];
        }
    }
    
    else if ([m rangeOfString:@"pluginView"].location != NSNotFound) {
        denPluginViewController *vc = [[denPluginViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    else if([m isEqualToString:@"permissions.requestReadPermissions"] )
    {
        //[self postToLog:@"ask for readPermissions"];
        
        // @"email,user_likes" @"publish_actions,publsih_stream"
       /* [Gigya requestNewFacebookReadPermissions: [json objectForKey:@"permissions"] responseHandler:^(BOOL granted, NSError *error, NSArray *declinedPermissions) {
            
            [self postToLog:[NSString stringWithFormat:@"\nSuccess = %i declined = %@ error = %@", granted, declinedPermissions, error]];
            
        }];*/
        
        [self postToLog:[NSString stringWithFormat:@"ask for readPermissions %@", [json objectForKey:@"permissions"]]];

        [Gigya requestNewFacebookReadPermissions:@"user_likes" viewController:self responseHandler:^(BOOL granted, NSError * _Nullable error, NSArray * _Nullable declinedPermissions) {
            
            NSLog(@"OK");
        }];
        
//        [Gigya requestNewFacebookReadPermissions:@"user_likes" viewController:self responseHandler:^(BOOL granted, NSError *error, NSArray *declinedPermissions){
//            
//            [self postToLog:[NSString stringWithFormat:@"\nSuccess = %i declined = %@ error = %@", granted, declinedPermissions, error]];
//            
//        }];
        
        
    }
    
    else if([m isEqualToString:@"permissions.requestPublishPermissions"] )
    {
       // [self postToLog:@"ask for publishPermissions "];
        
        /*[Gigya requestNewFacebookPublishPermissions: [json objectForKey:@"permissions"] responseHandler:^(BOOL granted, NSError *error, NSArray *declinedPermissions) {
            
            [self postToLog:[NSString stringWithFormat:@"\nSuccess = %i declined = %@ error = %@", granted, declinedPermissions, error]];
            
        }];*/
        
        [self postToLog:[NSString stringWithFormat:@"ask for publishPermissions %@", [json objectForKey:@"permissions"]]];

        
        [Gigya requestNewFacebookPublishPermissions: [json objectForKey:@"permissions"] viewController:self responseHandler:^(BOOL granted, NSError *error, NSArray *declinedPermissions) {
            
            [self postToLog:[NSString stringWithFormat:@"\nSuccess = %i declined = %@ error = %@", granted, declinedPermissions, error]];
            
        }];
    }
    
    
    else
    {
        NSLog(@"Calling method %@ with params = %@", m, p);
        self.Output.text = [NSString stringWithFormat:@"%@ Calling method %@ with params = %@", self.Output.text, m, p];
        // request.parameters = json;
        
        @try {
            [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
                [self ResponseHandler:response err:error];
            }
             ];
            // [request cancel];
            
            /* NSError *aaa;
             GSResponse *res = [request sendSynchronouslyWithError:&aaa];
             NSLog(@"\n Error = %@", aaa);
             self.Output.text = [NSString stringWithFormat:@"\n Error = %@", aaa];
             NSLog(@"\n Response = %@", res);
             self.Output.text = [NSString stringWithFormat:@"\n Response = %@", res];*/
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
            self.Output.text = [NSString stringWithFormat:@"%@", exception];
        }
    }
}




- (IBAction)callMethod:(id)sender {
    [self call:self.methodText.text param:self.paramJson.text];
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

- (IBAction)autoRun:(id)sender
{
    
    NSLog(@"Auto");
    NSString* path = [[NSBundle mainBundle] pathForResource:@"set"
                                                     ofType:@"json"];
    /*NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];*/
    NSLog(@"%@",path);
    
    NSArray  *testMethods = [NSArray arrayWithObjects://@"ds.set",
                             @"socialize.getUserInfo",
                             @"accounts.getAccountInfo",
                             // @"requestFacebookPublishPermissions",
                             @"socialize.getSessionInfo",
                             @"socialize.publishUserAction",
                             @"socialize.sendNotification",
                             //@"socialize.logout",
                             @"comments.postComment",
                             @"ds.get",
                             @"accounts.resetPassword",
                             nil];
    NSArray  *testParams = [NSArray arrayWithObjects: //content,
                            @"{}",
                            @"{}",
                            //@"{}",
                            @"{\"provider\":\"facebook\"}",
                            @"{\"userAction\": {\"title\":\"This is a title's iOS\",\"linkBack\":\"http://www.etoday.ru/\",\"userMessage\":\"This is a user message\",\"description\":\"Thisisadescription\"}}",
                            @"{\"subject\": \"Listen to cs \", \"body\": \"Get the Hungama App I found, its awesome. Watch Music videos \", \"recipients\": \"_gid_9YOj3miaHfwog1tt2OmbIA==\"}",
                            //@"{}",
                            @"{ \"categoryID\" : \"ios\",  \"commentText\" : \"i like this video\", \"guestEmail\":\"shwetha.km@sourcebits.com\", \"guestName\": \"shwe\" }",
                            @"{\"type\":\"aaa\",\"oid\":\"aaa\"}",
                            @"{\"loginID\":\"sam@sam.com\"}",
                            nil];
    
    
    
    /*NSArray  *testMethods = [NSArray arrayWithObjects: @"requestFacebookPublishPermissions", nil];
     NSArray  *testParams = [NSArray arrayWithObjects:@"{}", nil];
     */
    
    for (int i = 0; i < [testMethods count]; i++) {
        self.methodText.text = testMethods[i];
        self.paramJson.text  = testParams[i];
        
        [self call:testMethods[i] param:testParams[i]];
        
    }
    
    
}

- (IBAction)openDialog:(id)sender {
    NSLog(@"Dialog");
    //id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
    //[shareBuilder open];
    
    // Create and assign the post parameters, including the link, which will become our target url
    //FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    //content.contentURL = [NSURL URLWithString:@"http://www.gigya.com"];
//    content.contentTitle = @"Deep linking tutorial";
//    content.contentDescription = @"Learn how to direct users to a relevant experience within your app.";
//    content.imageURL = [NSURL URLWithString:@"http://i.imgur.com/g3Qc1HN.png"];
    // params.description = @"How to handle incoming links when users engage with your app's posts on Facebook.";
//    content.ref = @"tutorial";
    
    // If the Facebook app is installed and we can present the share dialog
    // Present share dialog
//    [FBSDKShareDialog showFromViewController:self
//                                  withContent:content
//                                     delegate:self];
    
    //FBSDKShareButton *button = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(50, 400, 180, 30)];
    //button.shareContent = content;
    //[self.view addSubview:button];
}

- (void)viewDidUnload {
    [self setHTTPs:nil];
    [super viewDidUnload];
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    NSLog(@"Share Success: %@", results);
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    NSLog(@"FB Share Error: %@", error);
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    NSLog(@"User canceled FB Share Dialog");
}
@end


