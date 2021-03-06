//
//  Task.h
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import "Patient.h"

@interface Task : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *dayWeek;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) Patient *belongsTo;

@end
