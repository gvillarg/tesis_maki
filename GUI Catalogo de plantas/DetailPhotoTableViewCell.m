//
//  DetailPhotoTableViewCell.m
//  GUI Catalogo de plantas
//
//  Created by inf227al on 08-05-15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "DetailPhotoTableViewCell.h"

@implementation DetailPhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.photoImage.layer.cornerRadius = self.photoImage.bounds.size.width / 2;
    self.photoImage.clipsToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
