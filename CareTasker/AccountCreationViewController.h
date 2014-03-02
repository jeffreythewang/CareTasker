//
//  AccountCreationViewController.h
//  CareTasker
//
//  Created by Jeffrey Wang on 3/2/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountCreationViewController;

@protocol AccountCreationViewController <NSObject>
- (void)accountCreationViewControllerDidCancel:(AccountCreationViewController *)controller;
- (void)accountCreationViewControllerDidSave: (AccountCreationViewController* )controller;
@end

@interface AccountCreationViewController : UITableViewController

@property (nonatomic, weak) id <AccountCreationViewController> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
