//
//  OrderTableViewController.h
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface OrderTableViewController : CoreDataTableViewController

@property (nonatomic, strong) NSArray <NSString *> *toppings;
@property (nonatomic) BOOL allowEditing;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


@end
