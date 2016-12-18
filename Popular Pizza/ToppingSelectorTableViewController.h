//
//  ToppingSelectorTableViewController.h
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToppingsSelectorDelegate <NSObject>

- (void) didSelectTopping: (NSString *)topping;

@end

@interface ToppingSelectorTableViewController : UITableViewController

@property (nonatomic, strong) NSArray <NSString *> *availableTopppings;
@property (nonatomic, assign) id <ToppingsSelectorDelegate> delegate;

@end
