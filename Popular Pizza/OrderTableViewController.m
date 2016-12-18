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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	return _toppings.count;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCellId" forIndexPath:indexPath];
	
	Order *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
	cell.textLabel.text = order.toppings;
    
    return cell;
}

//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
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
