//
//  companyObject.m
//  Bus Safety
//
//  Created by Adam Lowther on 10/16/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import "companyObject.h"

@implementation companyObject

@synthesize name = _name;
@synthesize  allowedToOperate = _allowedToOperate;
@synthesize fatiguedRecord, fitnessRecord, unsafeRecord, maintRecord, substanceRecord;

+(id) companyName:(NSString *)n isItAllowed:(NSString *)idk driverFatigue:(NSString *)fatigue driverFitness:(NSString *)fitness driverSubstance:(NSString *)substance vehicleMaint:(NSString *)maint vehicleUnsafe:(NSString *)unsafe
{
    companyObject *newCompany = [[self alloc] init];
    newCompany.name = n;
    newCompany.allowedToOperate = idk;
    newCompany.fitnessRecord = fitness;
    newCompany.fatiguedRecord = fatigue;
    newCompany.substanceRecord = substance;
    newCompany.maintRecord = maint;
    newCompany.unsafeRecord = unsafe;
    
    return newCompany;
}

@end