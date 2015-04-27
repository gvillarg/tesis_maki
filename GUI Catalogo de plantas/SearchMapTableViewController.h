//
//  SearchMapTableViewController.h
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 4/26/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchMapTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) IBOutlet UITableView *plantTableVIew;

@end
