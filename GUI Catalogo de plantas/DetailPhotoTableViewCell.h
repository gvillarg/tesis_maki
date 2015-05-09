//
//  DetailPhotoTableViewCell.h
//  GUI Catalogo de plantas
//
//  Created by inf227al on 08-05-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPhotoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *plantName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
