//
//  AccountCreationViewController.m
//  CareTasker
//
//  Created by Jeffrey Wang on 3/2/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "AccountCreationViewController.h"

@interface AccountCreationViewController ()

@end

@implementation AccountCreationViewController

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

// text field stuff
-(void)dismissKeyboard {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.fNameTextField resignFirstResponder];
    [self.lNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// What to do on cancel and done
- (IBAction)cancel:(id)sender
{
    [self.delegate accountCreationViewControllerDidCancel:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender
{
    User *user = [[User alloc] init];
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    user.firstName = self.fNameTextField.text;
    user.lastName = self.lNameTextField.text;
    
    //[self addUser:user.username :user.password :user.firstName :user.lastName :user.email :@"Caretaker" : user.password];
    
    [self.delegate accountCreationViewControllerDidSave:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addUser:(NSString*) userid :(NSString*) firstName :(NSString*) lastName :(NSString*) email :(NSString*) type :(NSString*) npassword {
    NSString *newString = [@"https://caretasker.firebaseio.com/users/" stringByAppendingString:userid];
    Firebase* userRef = [[Firebase alloc] initWithUrl:newString];
    [userRef setValue:@{@"fname": firstName, @"lname": lastName, @"email": email, @"type": type, @"pass": npassword}];
    if ([type isEqualToString: @"Caretaker"])
        [self createGroup:userid];
}

// Called by addUser if the user is a Caretaker, it creates a Caretaker's group
- (void)createGroup:(NSString*) userid {
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:userid];
    NSString *newString2 = [newString stringByAppendingString:@"/Caretaker/"];
    Firebase* groupRef = [[Firebase alloc] initWithUrl:newString2];
    [groupRef setValue:@{@"caretakerID": userid}];
}

//

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
