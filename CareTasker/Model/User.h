//
//  User.h
//  ss12-care
//
//  Created by Jeffrey Wang on 3/1/14.
//  Copyright (c) 2014 Jeffrey Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;

@end
