//
//  EditOrderTableViewController.m
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import "EditOrderTableViewController.h"
#import "ToppingSelectorTableViewController.h"
#import "Order+CoreDataClass.h"
#import "AppDelegate.h"

@import CoreData;

@interface EditOrderTableViewController ()

@property (nonatomic, strong) NSMutableArray <NSString *> *toppings;

@end

@implementation EditOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (_toppingsToShow) {
		// if _toppingsToShow is set, we're just showing the list of toppings
		_toppings = [NSMutableArray arrayWithArray:_toppingsToShow];
		self.navigationItem.rightBarButtonItem = nil;
	} else {
		_toppings = [[NSMutableArray alloc] init];
	}
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button handlers

- (IBAction)cancel:(UIBarButtonItem *)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(UIBarButtonItem *)sender {
	
	// insert a new order entity
	Order *newOrder = [NSEntityDescription insertNewObjectForEntityForName:@"Order" inManagedObjectContext: APP_DELEGATE.persistentContainer.viewContext];
	
	newOrder.toppings = [_toppings componentsJoinedByString:@", "];
	
	[APP_DELEGATE saveContext];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// we'll always have the additional row used to create a new row
    return _toppings.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editOrderCellId" forIndexPath:indexPath];
    
	if (indexPath.row == _toppings.count) {
		cell.textLabel.text = @"Add a topping";
	} else {
		cell.textLabel.text = _toppings[indexPath.row];
	}
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
		   editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	if (indexPath.row == _toppings.count) {
		return UITableViewCellEditingStyleInsert;
	} else {
		return UITableViewCellEditingStyleDelete;
	}
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

		// Delete the row from the data source
		[_toppings removeObjectAtIndex:indexPath.row];
		
		// update the table
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
		
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // The user wants to add a new topping.
		// The selected topping will be delivered to the didSelectTopping method below.
		
		// present the user with the topping selector
		ToppingSelectorTableViewController *toppingsSelector = [[ToppingSelectorTableViewController alloc] init];
		toppingsSelector.delegate = self;
		UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:toppingsSelector];
		[self presentViewController:nav animated:YES completion:nil];
    }   
}

- (void) didSelectTopping:(NSString *)topping
{
	// add it to the model
	[_toppings addObject:topping];
	
	// update the tableView
	[self.tableView reloadData];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
