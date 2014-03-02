//
//  Patient.h
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import "User.h"
#import "CareTaker.h"

@interface Patient : User

@property (nonatomic, strong) CareTaker *belongsTo;

@end
