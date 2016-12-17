//
//  CoreDataTableViewController.h
//  Popular Pizza
//
//  Created by Jack Wright on 12/16/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
