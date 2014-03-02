//
//  Task.h
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>


@class Task;

@protocol TaskDelegate <NSObject>
- (void)addTask:(NSString*) caretakerID :(NSString*) patientID :(NSString*) task;
@end

@interface Task : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *dayWeek;
@property (nonatomic, strong) NSString *time;

@end
