//
//  HealthDisorderViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 12/2/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "HealthDisorderViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>


@interface HealthDisorderViewController ()

@end

@implementation HealthDisorderViewController
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"healthDisorders";
        
        
        self.pullToRefreshEnabled = YES;
        
        
        self.paginationEnabled = NO;
        
        self.objectsPerPage = 999999999;
        
        
        HealthDisorders = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //load all objects sorted
    [self loadObjects];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"healthDisorders"];
    [query setLimit: 1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                
                
                [HealthDisorders addObject:[object objectForKey:@"HDName"]];
                //NSLog(@"Disorder name in parse is: %@", HealthDisorders);
                [self loadObjects];
            }
            
        }
        
        
        
        
    }];
    
    [self loadObjects];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [HealthDisorders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *restaurantTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];

    
    cell.textLabel.text = [HealthDisorders objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
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