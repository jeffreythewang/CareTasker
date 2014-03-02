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
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view
    [self getTasks :@"jdoe" :@"fsho" :array];
    for (Task *task in array) {
        NSLog(@"%@", task.name);
    }
    NSLog(@"%d", [array count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTasks:(NSString*) caretakerID :(NSString*) patientID :(NSMutableArray*) array {
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:caretakerID];
    NSString *newString2 = [newString stringByAppendingString:@"/Patients/"];
    NSString *newString3 = [newString2 stringByAppendingString:patientID];
    NSString *newString4 = [newString3 stringByAppendingString:@"/tasks/"];
    Firebase* tasksRef = [[Firebase alloc] initWithUrl:newString4];
    Task *singleTask = [[Task alloc] init];
    [tasksRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *taskData = snapshot.value;
        NSString *username = snapshot.name;
        
        //if ([taskData isKindOfClass:[NSDictionary class]]) {
            singleTask.name = taskData[@"name"];
            singleTask.dayWeek = taskData[@"day"];
            singleTask.time = taskData[@"time"];
            singleTask.description = taskData[@"details"];
            [array addObject:singleTask];
        NSLog(@"%d", [array count]);
        //}
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasklist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Task* taskAtCell = [self.tasklist objectAtIndex:indexPath.row];
    NSLog(@"%@", taskAtCell.name);

    cell.textLabel.text = taskAtCell.name;
    return cell;
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
