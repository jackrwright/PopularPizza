
//  EditOrderTableViewController.h
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToppingSelectorTableViewController.h"

@interface EditOrderTableViewController : UITableViewController <ToppingsSelectorDelegate>

@property (nonatomic, strong) NSArray <NSString *> *toppingsToShow;

@end
