//
//  CareTaker.m
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "CareTaker.h"
#include "User.h"

@implementation CareTaker

- (NSMutableArray*)getPatients:(NSString*) caretakerID {
    NSMutableArray* patientIds = [[NSMutableArray alloc] init];
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:caretakerID];
    NSString *newString2 = [newString stringByAppendingString:@"/Patients/"];
    Firebase* patientsRef = [[Firebase alloc] initWithUrl:newString2];
    [patientsRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary* patData = snapshot.value;
        [patientIds addObject:patData[@"patientID"]];
    }];
    NSMutableArray* patients = [[NSMutableArray alloc] init];
    User *singlePatient = [[User alloc] init];
    for (id userid in patientIds) {
        NSString *newString3 = @"https://caretasker.firebaseio.com/users";
        Firebase* patientRef = [[Firebase alloc] initWithUrl:newString3];
        [patientRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
            NSString* username = snapshot.name;
            if ([username isEqualToString:userid]) {
                NSDictionary* patientData = snapshot.value;
                singlePatient.username = username;
                singlePatient.firstName = patientData[@"fname"];
                singlePatient.lastName = patientData[@"lname"];
                [patients addObject:singlePatient];
            }
        }];
    }
    return patients;
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
