//
//  CareTakerPatientSpecViewController.h
//  CareTasker
//
//  Created by Jeffrey Wang on 3/2/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskAdderViewController.h"
#import "Model/Patient.h"

@interface CareTakerPatientSpecViewController : UIViewController <TaskAdderViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray* tasklist;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Patient *belongsTo;

- (void)getTasks:(NSString*) caretakerID :(NSString*) patientID :(NSMutableArray*) array;

@end
