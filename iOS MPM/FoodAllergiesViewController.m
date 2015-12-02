//
//  FoodAllergiesViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 12/1/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "FoodAllergiesViewController.h"

@interface FoodAllergiesViewController ()

@end

@implementation FoodAllergiesViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"Restaurants";
        
        
        self.pullToRefreshEnabled = YES;
        
        
        self.paginationEnabled = YES;
        
        self.objectsPerPage = 999999999;

        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *restaurantTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];
    
    
    cell.textLabel.text = @"testing Food Allergies";
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
