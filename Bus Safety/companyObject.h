//
//  companyObject.h
//  Bus Safety
//
//  Created by Adam Lowther on 10/16/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface companyObject : NSObject{
    NSString *name;
    NSString *allowedToOperate;
    NSString *fatiguedRecord;
    NSString *fitnessRecord;
    NSString *substanceRecord;
    NSString *maintRecord;
    NSString *unsafeRecord;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *allowedToOperate;
@property (nonatomic, copy) NSString *fatiguedRecord;
@property (nonatomic, copy) NSString *fitnessRecord;
@property (nonatomic, copy) NSString *substanceRecord;
@property (nonatomic, copy) NSString *maintRecord;
@property (nonatomic, copy) NSString *unsafeRecord;


+(id) companyName:(NSString *)n isItAllowed:(NSString *)allowed driverFatigue:(NSString *)fatigue driverFitness:(NSString *)fitness driverSubstance:(NSString *)substance vehicleMaint:(NSString *)maint vehicleUnsafe:(NSString *)unsafe;

@end