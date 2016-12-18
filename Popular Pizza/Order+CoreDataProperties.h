//
//  Order+CoreDataProperties.h
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import "Order+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Order (CoreDataProperties)

+ (NSFetchRequest<Order *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *toppings;
@property (nonatomic) BOOL isFavorite;

@end

NS_ASSUME_NONNULL_END
