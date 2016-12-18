//
//  OrderTableViewController.m
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import "OrderTableViewController.h"
#import "EditOrderTableViewController.h"
#import "AppDelegate.h"
#import "Order+CoreDataClass.h"

@interface OrderTableViewController () {
}

@end

@implementation OrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
	_managedObjectContext = APP_DELEGATE.persistentContainer.viewContext;
    
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Order"];
	
	// sort by topping list
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"toppings" ascending:YES];
	[fetchRequest setSortDescriptors:@[sortDescriptor]];
	
	// Set the fetchedResultsController. This will trigger a fetch.
	self.fetchedResultsController = [[NSFetchedResultsController alloc]
									 initWithFetchRequest:fetchRequest
									 managedObjectContext:_managedObjectContext
									 sectionNameKeyPath:nil
									 cacheName:nil];

	
	if (_allowEditing) {
		self.navigationItem.rightBarButtonItem = self.editButtonItem;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCellId" forIndexPath:indexPath];
	
	Order *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
	cell.textLabel.text = order.toppings;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

		// Delete the object from the database
		Order *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
		[_managedObjectContext deleteObject:order];
		
		[APP_DELEGATE saveContext];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	UIViewController *theVC = nil;
	if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
		theVC = ((UINavigationController *)(segue.destinationViewController)).topViewController;
	} else {
		theVC = segue.destinationViewController;
	}
	
	if ([segue.identifier isEqualToString: @"add"]) {
		// The user wants to create a new custom order
		EditOrderTableViewController *editTVC = (EditOrderTableViewController *)theVC;
		[editTVC.tableView setEditing:YES];
		
	} else if ([segue.identifier isEqualToString: @"show"]) {
		// The user wants to view the list of toppings for this order
		EditOrderTableViewController *editTVC = (EditOrderTableViewController *)theVC;
		
		UITableViewCell *cell = (UITableViewCell *)sender;
		NSArray *toppings = [cell.textLabel.text componentsSeparatedByString:@", "];
		
		editTVC.toppingsToShow = toppings;
	}
}

@end
