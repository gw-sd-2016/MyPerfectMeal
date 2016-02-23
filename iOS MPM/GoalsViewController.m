
#import "GoalsViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface GoalsViewController ()

@end

@implementation GoalsViewController
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        
        self.parseClassName = @"healthGoals";
        
        
        self.pullToRefreshEnabled = YES;
        
        
        self.paginationEnabled = NO;
        
        self.objectsPerPage = 999999999;
        
        
        healthGoals = [[NSMutableArray alloc] init];
        findSelectedGoal = [[NSMutableString alloc] init];
        
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
    
    //query everything in class medications
    PFQuery *query = [PFQuery queryWithClassName:@"healthGoals"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                
                //store all objects (goals names) into the goals array
                [healthGoals addObject:[object objectForKey:@"GName"]];
                [self loadObjects];
               


            }
            
        }
        
        
        //find the selected goal (from parse) and set it to string
        findSelectedGoal = [[PFUser currentUser] valueForKey:@"selectedGoal"];
        
        
    }];
    
    
    

    
    
    [self loadObjects];
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
    return [healthGoals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *goalsTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goalsTableIdentifier];
    
    //cell label is same as each element in the array
    cell.textLabel.text = [healthGoals objectAtIndex:indexPath.row];

    //find the cell that matches what was found in the server and check mark it
    if ([[healthGoals objectAtIndex:indexPath.row] isEqualToString:findSelectedGoal ]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    //user selects a goal @ indexpath
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [[PFUser currentUser] setObject:cell.textLabel.text forKey:@"selectedGoal"];
    [[PFUser currentUser] saveInBackground];

   }

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


@end