//
//  BSViewController.m
//  BSHorizontalTableViewCell
//
//  Created by bsoyluoglu on 03/19/2017.
//  Copyright (c) 2017 bsoyluoglu. All rights reserved.
//

#import "BSViewController.h"
#import "BSHorizontalTableViewCell.h"

@interface BSViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //Looks better this way.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //Some colors you like.
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark UITableViewDelegate


#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Some number
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //Some number
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Want to see a perfect square.
    return tableView.bounds.size.width;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSRow"];
    if(cell == nil)
    {
        cell = [[BSHorizontalTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"BSRow"];
    }
    
    int rand = arc4random_uniform(5)+2;
    //For demo purposes I wanted atleast 2 views.
    NSMutableArray<UIView *> *views = [NSMutableArray new];
    
    //Random color views
    for (int i = 0; i<=rand; i++) {
        UIView *view = [[UIView alloc] init];
        
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        view.backgroundColor = color;
        [views addObject:view];
    }

    [((BSHorizontalTableViewCell *)cell) setDisplayViews:views];
    
    return cell;
}

@end
