//
//  PopularPizzaTableViewController.m
//  Popular Pizza
//
//  Created by Jack Wright on 12/16/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import "PopularPizzaTableViewController.h"
#import "OrderPopularity.h"
#import "SingleOrderTableViewController.h"
#import "SettingsTableViewController.h"
#import "globals.h"

@interface PopularPizzaTableViewController ()
{
	NSArray <OrderPopularity *>	*orders;
	NSInteger maxPopular;
}
@end

@implementation PopularPizzaTableViewController

- (void) setAvailableToppings:(NSArray<NSString *> *)availableToppings
{
	_availableToppings = availableToppings;
	
	// Persist in user defaults
	[[NSUserDefaults standardUserDefaults] setObject:_availableToppings forKey:kAvailableToppings];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[self buildModelForTable];
	
	[self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// Read the max popular orders from user defaults
	NSNumber *max = [[NSUserDefaults standardUserDefaults] objectForKey:kMaxPopularKey];
	
	if ([max integerValue] != maxPopular) {
		maxPopular = [max integerValue];
		[self.tableView reloadData];
	}
}

- (void) buildModelForTable
{
	NSMutableSet *availableToppingsSet = [[NSMutableSet alloc] init];
	
	// Load the pizza orders JSON file into an array...
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pizzaOrders" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:filePath];
	NSArray *pizzaOrders = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
	
	// create a set of unique topping orders, keeping track of the counts
	NSCountedSet *toppingsSet = [[NSCountedSet alloc] init];
	for (NSDictionary *order in pizzaOrders) {
		NSArray *toppings = [order objectForKey:@"toppings"];
		
		// keep track of the available toppings for later
		[availableToppingsSet addObjectsFromArray:toppings];
		
		// sort the toppings for this order
		NSArray *sortedToppings = [toppings sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
		
		// now we have a sorted array of toppings for this order
		
		// Create a string of toppings by joining the individual toppings with commas
		// and add it to the set. Since we are using an NSCountedSet,
		// only unique strings will be added, but they will still be counted.
		[toppingsSet addObject:[sortedToppings componentsJoinedByString:kToppingSep]];
	}
	
	// Create a sorted array of available toppings for creating custom orders.
	// NSString provides a 'description' method that returns the string.
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
	[self setAvailableToppings: [availableToppingsSet sortedArrayUsingDescriptors:@[sortDescriptor]]];
	
	// Now populate an array for use in the table
	NSMutableArray *theOrders = [[NSMutableArray alloc] initWithCapacity:toppingsSet.count];
	for (NSString *order in toppingsSet) {
		OrderPopularity *op = [[OrderPopularity alloc] init];
		op.count = [toppingsSet countForObject:order];
		op.toppings = order;
		[theOrders addObject:op];
	}
	sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"count" ascending:NO];
	orders = [theOrders sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return maxPopular < 0 ? orders.count : maxPopular;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
	cell.textLabel.text = orders[indexPath.row].toppings;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", orders[indexPath.row].count];
	
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

	SingleOrderTableViewController *orderTVC = [segue destinationViewController];
	
	if (orderTVC) {
		UITableViewCell *tappedRow = (UITableViewCell *)sender;
		orderTVC.navigationItem.title = [NSString stringWithFormat:@"%@ Orders", tappedRow.detailTextLabel.text];
		orderTVC.toppings = [tappedRow.textLabel.text componentsSeparatedByString:kToppingSep];
	}
}

@end
