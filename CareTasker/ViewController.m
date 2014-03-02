//
//  ViewController.m
//  CareTasker
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "ViewController.h"

#define CareTaskerNS @"https://caretasker.firebaseio.com/"

@interface ViewController ()

@end

@implementation ViewController

@synthesize main;
@synthesize username;
@synthesize password;

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
    
    // Create a reference to a Firebase location
    Firebase* f = [[Firebase alloc] initWithUrl:CareTaskerNS];
    
    Firebase* sampleChatRef = [[Firebase alloc] initWithUrl:CareTaskerNS];
    Firebase* childRef = [sampleChatRef childByAppendingPath:@"users"];
    Firebase* userRef = [childRef childByAppendingPath:@"jsmith"];
    [userRef setValue:@{@"fname": @"John", @"lname": @"Smith",@"email": @"jsmith@gmail.com", @"type": @"Caretaker", @"pass": @"hunter2"}];
    Firebase* user2Ref = [childRef childByAppendingPath:@"suchdoge"];
    [user2Ref setValue:@{@"fname": @"Such", @"lname": @"Doge",@"email": @"muchwowh@gmail.com", @"type": @"Patient", @"pass": @"hunter2"}];
    
    [userRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot.value == [NSNull null]) {
            NSLog(@"User jsmith doesn't exist");
        } else {
            NSString* firstName = snapshot.value[@"fname"];
            NSString* lastName = snapshot.value[@"lname"];
                                                NSLog(@"User's full name is: %@ %@", firstName, lastName);
                                                }
                                                }];
    
    // Read data and react to changes
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
    }];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    [singleTap release];
}

// text field stuff
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


//Implement the below delegate method:

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.username = textField;
}

//Implement resignOnTap:

- (void)resignOnTap:(UITextField *)iSender {
    [self.username resignFirstResponder];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if ([self.username isFirstResponder]) {
        [self.username resignFirstResponder];
    }
}

// Firebase
- (BOOL)findUser:(NSString*) userid {
    __block BOOL isUser = NO;
    NSString *newString = [@"https://caretasker.firebaseio.com/users/"  stringByAppendingString:userid];
    Firebase* userfindRef = [[Firebase alloc] initWithUrl:newString];
    [userfindRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot.value == [NSNull null]) {
            NSLog(@"User %@ does not exist", userid);
            // return NO;
        } else {
            NSString* firstName = snapshot.value[@"fname"];
            NSString* lastName = snapshot.value[@"lname"];
            NSLog(@"User's name is: %@ %@", firstName, lastName);
            // return YES;
            isUser = YES;
        }
    }];
    return isUser;
}

- (void)addUser:(NSString*) userid :(NSString*) firstName :(NSString*) lastName :(NSString*) email :(NSString*) type :(NSString*) npassword {
    NSString *newString = [@"https://caretasker.firebaseio.com/users/" stringByAppendingString:userid];
    Firebase* userRef = [[Firebase alloc] initWithUrl:newString];
    [userRef setValue:@{@"fname": firstName, @"lname": lastName, @"email": email, @"type": type, @"pass": npassword}];
}

// Function to login an existing user
- (void)loginUser:(NSString*) user :(NSString*) npassword {
    
    if (![self findUser:user]) {
        NSString *newString = [@"https://caretasker.firebaseio.com/users/" stringByAppendingString:user];
        NSString *newString2 = [newString stringByAppendingString:@"/"];
        NSString *newString3 = [newString2 stringByAppendingString:@"pass"];
        Firebase* loginRef = [[Firebase alloc] initWithUrl:newString3];
        [loginRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            if(snapshot.value == npassword) {
                // Move to next screeen
            }
            else {
                // Popup dialog saying that password was incorrect
            }
        }];
    }
    else {
        // Popup dialog saying that username could not be found
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
