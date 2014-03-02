//
//  ViewController.h
//  CareTasker
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "AccountCreationViewController.h"

@interface ViewController : UIViewController <AccountCreationViewController>

@property (nonatomic, strong) IBOutlet UIView *main;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end
