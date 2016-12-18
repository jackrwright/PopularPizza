//
//  SingleOrderTableViewController.m
//  Popular Pizza
//
//  This view controller is to display a long list of toppings as a table.
//
//  Created by Jack Wright on 12/18/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import "SingleOrderTableViewController.h"

@interface SingleOrderTableViewController ()

@end

@implementation SingleOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

	return _toppings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    // Configure the cell...
	
	cell.textLabel.text = _toppings[indexPath.row];
    
    return cell;
}

@end
