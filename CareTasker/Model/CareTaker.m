//
//  CareTaker.m
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "CareTaker.h"

@implementation CareTaker

- (void)getPatients:(NSString*) caretakerID {
    NSMutableArray* patients = [[NSMutableArray alloc] init];
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:caretakerID];
    NSString *newString2 = [newString stringByAppendingString:@"/Patients/"];
    Firebase* patientsRef = [[Firebase alloc] initWithUrl:newString2];
    [patientsRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        //NSDictionary* msgData = snapshot.value;
        [patients addObject:snapshot.value];
    }];
}

// A Caretaker can use this function to add
- (void)addToGroup:(NSString*) caretakerID :(NSString*) patientID :(NSString*) type {
    if ([type isEqualToString:@"Patient"]) {
        NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:caretakerID];
        NSString *newString2 = [newString stringByAppendingString:@"/Patients/"];
        NSString *newString3 = [newString2 stringByAppendingString:patientID];
        Firebase* groupRef = [[Firebase alloc] initWithUrl:newString3];
        [groupRef setValue:@{@"caretakerID": patientID}];
    }
    else {
        // This person is not a patient!!!
    }
}

@end
