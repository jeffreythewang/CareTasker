//
//  TaskAdderViewController.h
//  CareTasker
//
//  Created by Jeffrey Wang on 3/2/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskAdderViewController;

@protocol TaskAdderViewControllerDelegate <NSObject>
- (void)TaskAdderViewControllerDidCancel:(TaskAdderViewController *)controller;
- (void)TaskAdderViewControllerDidSave:(TaskAdderViewController *)controller;
@end

@interface TaskAdderViewController : UITableViewController

@property (nonatomic, weak) id <TaskAdderViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
