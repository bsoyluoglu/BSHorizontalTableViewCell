//
//  BSHorizontalTableViewCell.h
//  Pods
//
//  Created by Berker Soyluoglu on 19/03/17.
//
//

#import <UIKit/UIKit.h>

@interface BSHorizontalTableViewCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                  isInfinite:(BOOL) isInfinite;

-(void)setDisplayViews:(NSArray<UIView *> *)displayViews;

@end
