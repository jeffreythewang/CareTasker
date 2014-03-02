//
//  TaskAdderViewController.m
//  CareTasker
//
//  Created by Jeffrey Wang on 3/2/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "TaskAdderViewController.h"

@interface TaskAdderViewController ()

@end

@implementation TaskAdderViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

-(void)dismissKeyboard {
    [self.nameTextField resignFirstResponder];
    [self.timeTextField resignFirstResponder];
    [self.dayWeekTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self.delegate TaskAdderViewControllerDidCancel:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender
{
    Task *task = [[Task alloc] init];
    task.name = self.nameTextField.text;
    task.time = self.timeTextField.text;
    task.dayWeek = self.dayWeekTextField.text;
    task.description = self.descriptionTextView.text;

    [self addTask:@"jdoe" :@"fsho" :task.name :task.time :task.dayWeek :task.description];  
    
    [self.delegate TaskAdderViewControllerDidSave:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.nameTextField becomeFirstResponder];
    }
    
    if (indexPath.section == 1) {
        [self.timeTextField becomeFirstResponder];
    }
    
    if (indexPath.section == 2) {
        [self.dayWeekTextField becomeFirstResponder];
    }
}

- (void)addTask:(NSString*) caretakerID :(NSString*) patientID :(NSString*) taskName :(NSString*) tasktime :(NSString*) taskDay :(NSString*) taskDet {
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:caretakerID];
    NSString *newString2 = [newString stringByAppendingString:@"/Patients/"];
    NSString *newString3 = [newString2 stringByAppendingString:patientID];
    NSString *newString4 = [newString3 stringByAppendingString:@"/tasks/"];
    NSString *newString5 = [newString4 stringByAppendingString:taskName];
    Firebase* taskRef = [[Firebase alloc] initWithUrl:newString5];
    [taskRef setValue:@{@"name": taskName, @"time": tasktime, @"day": taskDay, @"details": taskDet}];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
