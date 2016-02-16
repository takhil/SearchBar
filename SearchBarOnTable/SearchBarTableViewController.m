//
//  SearchBarTableViewController.m
//  SearchBarOnTable
//
//  Created by Phanip on 9/3/15.
//  Copyright (c) 2015 Enlume. All rights reserved.
//

#import "SearchBarTableViewController.h"

@interface SearchBarTableViewController ()<UISearchDisplayDelegate>{
    NSArray *names;
}
@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation SearchBarTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     names = @[@"Hari",@"Harsha",@"Hemanth",@"Bharath",@"Bhargav",@"Bhanu",@"Phani",@"Pavan",@"pranay"];
    self.searchResults = [NSMutableArray arrayWithCapacity:[names count]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self. searchDisplayController.searchResultsTableView)
        return [self.searchResults count];
    else
        return  [names count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(tableView == self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [names objectAtIndex:indexPath.row];
    }
                               
    return cell;
}

- (void)filterContentSearchText : (NSString *)searchText scope: (NSString *)scope{
    [self.searchResults removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@" , searchText];
    self.searchResults = [NSMutableArray arrayWithArray:[names filteredArrayUsingPredicate:resultPredicate]];

}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentSearchText:searchString
                            scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                    objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return  YES;
}
@end
