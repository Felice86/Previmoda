//
//  UIView+Blur.m
//  Previmoda
//
//  Created by Daniele on 01/01/15.
//  Copyright (c) 2015 Previmoda. All rights reserved.
//

#import "UIView+Blur.h"

@implementation UIView (Blur)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImage*)convertViewToImage {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:true];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
