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

    // Write data to Firebase
    [f setValue:@"Do you have data? You'll love Firebase."];
    
    // Read data and react to changes
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
    }];
    
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [label setText:@"CareTasker"];
    [view addSubview:label];
    self.view = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
