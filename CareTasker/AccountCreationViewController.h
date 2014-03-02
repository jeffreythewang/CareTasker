//
//  AccountCreationViewController.h
//  CareTasker
//
//  Created by Jeffrey Wang on 3/2/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "Model/User.h"

@class AccountCreationViewController;

@protocol AccountCreationViewController <NSObject>
- (void)accountCreationViewControllerDidCancel:(AccountCreationViewController *)controller;
- (void)accountCreationViewControllerDidSave: (AccountCreationViewController* )controller;
@end

@interface AccountCreationViewController : UITableViewController

- (void)addUser:(NSString*) userid :(NSString*) firstName :(NSString*) lastName :(NSString*) email :(NSString*) type :(NSString*) npassword;
- (void)createGroup:(NSString*) userid;

@property (nonatomic, weak) id <AccountCreationViewController> delegate;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *fNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
