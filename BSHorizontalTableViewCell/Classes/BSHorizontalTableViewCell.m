//
//  BSHorizontalTableViewCell.m
//  Pods
//
//  Created by Berker Soyluoglu on 19/03/17.
//
//

#import "BSHorizontalTableViewCell.h"

@interface BSHorizontalTableViewCell() <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property UIPageViewController *pageViewController;

@property NSInteger currentPage;
@property (nonatomic) NSArray<UIView *> *displayViews;

@property BOOL isInfinite;

@end

@implementation BSHorizontalTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                  isInfinite:(BOOL) isInfinite
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.isInfinite = isInfinite;
    
    self.pageViewController =
    [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                  options:nil];
    
    [self.pageViewController setDataSource:self];
    [self.pageViewController setDelegate:self];
    
    [self.pageViewController.view setFrame:self.contentView.bounds];
    
    [self.contentView addSubview:self.pageViewController.view];
    
    return self;
}

-(void)setDisplayViews:(NSArray<UIView *> *)displayViews{
    _displayViews = displayViews;

    [self.pageViewController setViewControllers:@[[self viewControllerAtIndex:0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    return;
}

- (UIViewController *) viewControllerAtIndex:(NSUInteger) idx
{
    UIViewController *vc = [[UIViewController alloc] init];
    [vc.view setFrame: self.contentView.bounds];
    
    self.currentPage = idx;
    
    vc.view.tag = idx;
    
    [vc.view addSubview:self.displayViews[idx]];
    
    self.displayViews[idx].translatesAutoresizingMaskIntoConstraints = NO;
    
    [vc.view addConstraints:@[
                              
                              [NSLayoutConstraint constraintWithItem:self.displayViews[idx]
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:vc.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0],
                              
                              [NSLayoutConstraint constraintWithItem:self.displayViews[idx]
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:vc.view
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:0],

                              [NSLayoutConstraint constraintWithItem:self.displayViews[idx]
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:vc.view
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:0],

                              [NSLayoutConstraint constraintWithItem:self.displayViews[idx]
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:vc.view
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1
                                                            constant:0],
                              
                              ]];
    
    return vc;
}

#pragma mark -
#pragma mark UIPageViewControllerDataSource

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger idx = viewController.view.tag;
    
    idx ++;
    
    if (self.isInfinite == YES) {
        idx = idx%self.displayViews.count;
    }
    
    if (idx == self.displayViews.count) {
        return nil;
    }
    
    return [self viewControllerAtIndex:idx];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
     viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger idx = viewController.view.tag;
    
    if (idx == 0 && self.isInfinite){
        idx = self.displayViews.count;
    }
    
    if (idx == 0) {
        return nil;
    }
    
    idx --;
    
    return [self viewControllerAtIndex:idx];
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.displayViews.count;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return self.currentPage;
}
@end
