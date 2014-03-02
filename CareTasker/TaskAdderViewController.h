//
//  TaskAdderViewController.h
//  CareTasker
//
//  Created by Jeffrey Wang on 3/2/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Task.h"

@class TaskAdderViewController;

@protocol TaskAdderViewControllerDelegate <NSObject>
- (void)TaskAdderViewControllerDidCancel:(TaskAdderViewController *)controller;
- (void)TaskAdderViewControllerDidSave:(TaskAdderViewController *)controller;
@end

@interface TaskAdderViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *dayWeekTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (nonatomic, strong) Task *belongsTo;

- (void)addTask:(NSString*) caretakerID :(NSString*) patientID :(NSString*) taskName :(NSString*) tasktime :(NSString*) taskDay :(NSString*) taskDet;
@property (nonatomic, weak) id <TaskAdderViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
