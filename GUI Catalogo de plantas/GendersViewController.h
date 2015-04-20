//
//  GendersViewController.h
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 3/31/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Family.h"

@interface GendersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *familyNameLabel;
@property Family *familySelected;
//@property NSMutableDictionary *familySelected;
@property (weak, nonatomic) IBOutlet UITableView *GenderTableView;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *familyNameHeightConstraint;


@end
