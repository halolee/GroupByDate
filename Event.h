//
//  Event.h
//  GroupDate
//
//  Created by Hao Li on 3/06/2015.
//  Copyright (c) 2015 halolee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * sectionIdentifier;
@property (nonatomic, retain) NSString * title;

@end
