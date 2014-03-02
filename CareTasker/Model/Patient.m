//
//  Patient.m
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "Patient.h"
#import "Task.h"

@implementation Patient

- (NSMutableArray*)getTasks:(NSString*) caretakerID :(NSString*) patientID {
    NSMutableArray* tasks = [[NSMutableArray alloc] init];
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:caretakerID];
    NSString *newString2 = [newString stringByAppendingString:@"/Patients/"];
    NSString *newString3 = [newString2 stringByAppendingString:patientID];
    NSString *newString4 = [newString3 stringByAppendingString:@"/tasks/"];
    Firebase* tasksRef = [[Firebase alloc] initWithUrl:newString4];
    Task *singleTask = [[Task alloc] init];
    [tasksRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *taskData = snapshot.value;
        singleTask.name = taskData[@"name"];
        singleTask.dayWeek = taskData[@"day"];
        singleTask.time = taskData[@"time"];
        singleTask.description = taskData[@"details"];
        [tasks addObject:singleTask];
    }];
    return tasks;
}

@end
