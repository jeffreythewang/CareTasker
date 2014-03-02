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

@property (nonatomic, strong) IBOutlet UIView *main;

@end

@implementation ViewController

@synthesize main;

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
    [userRef setValue:@{@"fname": @"John", @"lname": @"Smith", @"type": @"Caretaker", @"pass": @"hunter2"}];
    
    // Read data and react to changes
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
    }];
    
    // Home Page
    UIView *home = [[UIView alloc] init];
    [home setBackgroundColor:[UIColor whiteColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [label setText:@"CareTasker"];
    [home addSubview:label];
    self.view = home;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
