//
//  CareTakerPatientSpecViewController.m
//  CareTasker
//
//  Created by Jeffrey Wang on 3/2/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "CareTakerPatientSpecViewController.h"

@interface CareTakerPatientSpecViewController ()

@end

@implementation CareTakerPatientSpecViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TaskAdderViewControllerDelegate

- (void)TaskAdderViewControllerDidCancel:(TaskAdderViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)TaskAdderViewControllerDidSave:(TaskAdderViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        TaskAdderViewController *taskAdderViewController = [navigationController viewControllers][0];
        taskAdderViewController.delegate = self;
    }
}

@end
