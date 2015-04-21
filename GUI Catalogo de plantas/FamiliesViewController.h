//
//  FamiliesViewController.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 30-03-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamiliesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate >
@property (weak, nonatomic) IBOutlet UITableView *FamilyTableView;


@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) NSMutableArray *filteredFamilyArray;

@end
