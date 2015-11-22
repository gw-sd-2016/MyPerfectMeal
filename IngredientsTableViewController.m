//
//  IngredientsTableViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/22/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "IngredientsTableViewController.h"

@interface IngredientsTableViewController ()

@end

@implementation IngredientsTableViewController

@synthesize clickedMeal2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", clickedMeal2);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 99;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *restaurantTableIdentifier = @"ingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];
    
    
    
    
    return cell;
}

@end
