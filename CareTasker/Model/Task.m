//
//  Task.m
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "Task.h"

@implementation Task

- (void)getTasks:(NSString*) caretakerID :(NSString*) patientID {
    NSMutableArray* tasks = [[NSMutableArray alloc] init];
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:caretakerID];
    NSString *newString2 = [newString stringByAppendingString:@"/Patients/"];
    NSString *newString3 = [newString2 stringByAppendingString:patientID];
    NSString *newString4 = [newString3 stringByAppendingString:@"tasks"];
    Firebase* tasksRef = [[Firebase alloc] initWithUrl:newString4];
    [tasksRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [tasks addObject:snapshot.value];
    }];
}

@end
