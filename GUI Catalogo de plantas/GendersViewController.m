//
//  GendersViewController.m
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 3/31/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "GendersViewController.h"
#import "Family.h"

@interface GendersViewController ()

@end

@implementation GendersViewController

- (void)viewDidLoad {
      [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.familyNameLabel.text = [NSString stringWithFormat: @"%@ %@", @" Familia ", self.familySelected.name];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark  - UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.familySelected.genders count];
    //return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    Gender *gender = [self.familySelected.genders objectAtIndex:indexPath.row];
    cell.textLabel.text = gender.name;
    return cell;
    
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *alphabet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L" , @"M", @"N", @"O", @"P", @"Q", @"R",  @"S", @"T", @"U" , @"V", @"W", @"X" , @"Y", @"Z",  nil] ;
    return alphabet;
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
