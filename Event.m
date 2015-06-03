//
//  Event.m
//  GroupDate
//
//  Created by Hao Li on 3/06/2015.
//  Copyright (c) 2015 halolee. All rights reserved.
//

#import "Event.h"

@interface Event()
@property (nonatomic) NSDate *primitiveTimeStamp;
@property (nonatomic) NSString *primitiveSectionIdentifier;
@end

@implementation Event

@dynamic timeStamp;
@dynamic sectionIdentifier;
@dynamic title;
@dynamic primitiveTimeStamp;
@dynamic primitiveSectionIdentifier;


#pragma mark - Transient properties

- (NSString *)sectionIdentifier
{
    // Create and cache the section identifier on demand.
    
    [self willAccessValueForKey:@"sectionIdentifier"];
    NSString *tmp = [self primitiveSectionIdentifier];
    [self didAccessValueForKey:@"sectionIdentifier"];
    
    if (!tmp)
    {
        /*
         Sections are organized by month and year. Create the section identifier as a string representing the number (year * 1000) + month; this way they will be correctly ordered chronologically regardless of the actual name of the month.
         */
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:[self timeStamp]];
        tmp = [NSString stringWithFormat:@"%d", ([components year] * 1000) + [components month]];
        [self setPrimitiveSectionIdentifier:tmp];
    }
    return tmp;
}


#pragma mark - Time stamp setter

- (void)setTimeStamp:(NSDate *)newDate
{
    // If the time stamp changes, the section identifier become invalid.
    [self willChangeValueForKey:@"timeStamp"];
    [self setPrimitiveTimeStamp:newDate];
    [self didChangeValueForKey:@"timeStamp"];
    
    [self setPrimitiveSectionIdentifier:nil];
}


#pragma mark - Key path dependencies

+ (NSSet *)keyPathsForValuesAffectingSectionIdentifier
{
    // If the value of timeStamp changes, the section identifier may change as well.
    return [NSSet setWithObject:@"timeStamp"];
}
@end
