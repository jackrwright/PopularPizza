//
//  Order+CoreDataProperties.m
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Order+CoreDataProperties.h"

@implementation Order (CoreDataProperties)

+ (NSFetchRequest<Order *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Order"];
}

@dynamic toppings;

@end
