//
//  DislikesViewController.m
//  iOS MPM
//
//  Created by guest on 3/30/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import "DislikesViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface DislikesViewController ()

@end

@implementation DislikesViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"User";
        
        self.pullToRefreshEnabled = YES;
        
        self.paginationEnabled = NO;
        
        self.objectsPerPage = 999999999;
        
        findDislikes = [[NSMutableArray alloc] init];
        
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //load all objects sorted
    [self loadObjects];
    
}

-(void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [findDislikes addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedDislikes"]];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//not sectionalized so 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//rows as many as goals pulled from database
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [findDislikes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *goalsTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goalsTableIdentifier];
    
    cell.textLabel.text = [findDislikes objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[PFUser currentUser] removeObject:[findDislikes objectAtIndex:indexPath.row] forKey:@"selectedDislikes"];
        [[PFUser currentUser] saveInBackground];
        
        [findDislikes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end