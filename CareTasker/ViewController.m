//
//  ViewController.m
//  CareTasker
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "ViewController.h"
#import "AccountCreationViewController.h"

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
    
    [self addUser:@"jdoe" :@"John" :@"Doe" :@"jdoe@gmail.com" :@"Caretaker" :@"qwerty"];
    [self addUser:@"fsho" :@"Fenix" :@"Sho" :@"fsho@gmail.com" :@"Patient" :@"wasd"];
    [self addToGroup:@"jdoe" :@"fsho" :@"Patient"];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

// text field stuff
-(void)dismissKeyboard {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

/*
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:mailTf])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}
*/

//Account creation stuff


// Firebase
- (BOOL)findUser:(NSString *) userid {
    // Default to false
    __block BOOL isUser = NO;
    NSString *newString = [@"https://caretasker.firebaseio.com/users/"  stringByAppendingString:userid];
    Firebase* userfindRef = [[Firebase alloc] initWithUrl:newString];
    [userfindRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot.name == [NSNull null]) {
            NSLog(@"User %@ does not exist", userid);
        } else {
            NSDictionary* userData = snapshot.value;
            NSString* firstName = userData[@"fname"];
            NSString* lastName = userData[@"lname"];
            NSLog(@"User's name is: %@ %@", firstName, lastName);
            // Sets to YES if the user was found
            isUser = YES;
        }
    }];
    return isUser;
}

- (void)addUser:(NSString*) userid :(NSString*) firstName :(NSString*) lastName :(NSString*) email :(NSString*) type :(NSString*) npassword {
    NSString *newString = [@"https://caretasker.firebaseio.com/users/" stringByAppendingString:userid];
    Firebase* userRef = [[Firebase alloc] initWithUrl:newString];
    [userRef setValue:@{@"fname": firstName, @"lname": lastName, @"email": email, @"type": type, @"pass": npassword}];
    if ([type isEqualToString: @"Caretaker"])
        [self createGroup:userid];
}

// Function to login an existing user
- (void)loginUser:(NSString*) userid :(NSString*) npassword {
    if (![self findUser:userid]) {
        NSString *newString = [@"https://caretasker.firebaseio.com/users/" stringByAppendingString:userid];
        Firebase* loginRef = [[Firebase alloc] initWithUrl:newString];
        [loginRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            NSDictionary* userData = snapshot.value;
            if([userData[@"pass"] isEqualToString:npassword]) {
                if([userData[@"type"] isEqualToString:@"Caretaker"]) {
                    // Move to Caretaker screen
                }
                else {
                    // Move to Patient screen
                }
            }
            else {
                // Popup dialog saying that password was incorrect
                NSLog(@"Password was incorrect.");
            }
        }];
    }
    else {
        // Popup dialog saying that username could not be found
        NSLog(@"Username was incorrect.");
    }
}

- (void)addToGroup:(NSString*) caretakerID :(NSString*) patientID :(NSString*) type {
    if ([type isEqualToString:@"Patient"]) {
        NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:caretakerID];
        NSString *newString2 = [newString stringByAppendingString:@"/Patients/"];
        NSString *newString3 = [newString2 stringByAppendingString:patientID];
        Firebase* groupRef = [[Firebase alloc] initWithUrl:newString3];
        [groupRef setValue:@{@"patientID": patientID}];
    }
    else {
        // This person is not a patient!!!
    }
}

// Called by addUser if the user is a Caretaker, it creates a Caretaker's group
- (void)createGroup:(NSString*) userid {
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:userid];
    NSString *newString2 = [newString stringByAppendingString:@"/Caretaker/"];
    Firebase* groupRef = [[Firebase alloc] initWithUrl:newString2];
    [groupRef setValue:@{@"caretakerID": userid}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
