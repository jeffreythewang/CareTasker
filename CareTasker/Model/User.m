//
//  User.m
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "User.h"

@implementation User

// Called by addUser if the user is a Caretaker, it creates a Caretaker's group
- (void)createGroup:(NSString*) userid {
    NSString *newString = [@"https://caretasker.firebaseio.com/groups/group_" stringByAppendingString:userid];
    NSString *newString2 = [newString stringByAppendingString:@"/Caretaker/"];
    Firebase* groupRef = [[Firebase alloc] initWithUrl:newString2];
    [groupRef setValue:@{@"caretakerID": userid}];
}

@end
