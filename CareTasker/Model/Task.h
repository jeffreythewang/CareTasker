//
//  Task.h
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSDate *date;

@end
