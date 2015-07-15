//
//  ViewController.m
//  ScrollView-Image-Gallery
//
//  Created by Jeff Huang on 2015-07-14.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *uiScrollerView;
@property (strong, nonatomic) NSArray *imgArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imgArray = @[[UIImage imageNamed:@"Lighthouse-in-Field"],
                      [UIImage imageNamed:@"Lighthouse-night"],
                      [UIImage imageNamed:@"Lighthouse-zoomed"]];
    
    UIImage *img = [UIImage imageNamed:@"Lighthouse-in-Field"];
    UIImageView *imagePlaceholder1 = [[UIImageView alloc] initWithImage:img];
    [imagePlaceholder1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.uiScrollerView addSubview:imagePlaceholder1];
    [self setViewConstraintWithItem:imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeLeft
                          andToItem:self.uiScrollerView
                   andWithAttribute:NSLayoutAttributeLeft
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeTopMargin
                          andToItem:self.uiScrollerView
                   andWithAttribute:NSLayoutAttributeTopMargin
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeHeight
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeHeight
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.height];
    [self setViewConstraintWithItem:imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeWidth
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeWidth
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.width];
    
    img = [UIImage imageNamed:@"Lighthouse-night"];
    UIImageView *imagePlaceholder2 = [[UIImageView alloc] initWithImage:img];
    [imagePlaceholder2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.uiScrollerView addSubview:imagePlaceholder2];
    [self setViewConstraintWithItem:imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeLeading
                          andToItem:imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeTrailing
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeTopMargin
                          andToItem:self.uiScrollerView
                   andWithAttribute:NSLayoutAttributeTopMargin
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeHeight
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeHeight
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.height];
    [self setViewConstraintWithItem:imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeWidth
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeWidth
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.width];

    
    img = [UIImage imageNamed:@"Lighthouse-zoomed"];
    UIImageView *imagePlaceholder3 = [[UIImageView alloc] initWithImage:img];
    [imagePlaceholder3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.uiScrollerView addSubview:imagePlaceholder3];
    [self setViewConstraintWithItem:imagePlaceholder3
                   andWithAttribute:NSLayoutAttributeLeading
                          andToItem:imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeTrailing
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:imagePlaceholder3
                   andWithAttribute:NSLayoutAttributeRight
                          andToItem:self.uiScrollerView
                   andWithAttribute:NSLayoutAttributeRight
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:imagePlaceholder3
                   andWithAttribute:NSLayoutAttributeHeight
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeHeight
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.height];
    [self setViewConstraintWithItem:imagePlaceholder3
                   andWithAttribute:NSLayoutAttributeWidth
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeWidth
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.width];
    
    CGSize tempSize = self.uiScrollerView.contentSize;
    tempSize.width = 3*[UIScreen mainScreen].bounds.size.width;
    self.uiScrollerView.contentSize = tempSize;
    
    self.uiScrollerView.pagingEnabled = YES;
    self.uiScrollerView.delegate = self;
    
    for(UIView *v in self.uiScrollerView.subviews)
        NSLog(@"width: %f", v.bounds.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSInteger pageIndex = floor(targetContentOffset -> x/ [UIScreen mainScreen].bounds.size.width);
    
    if((targetContentOffset -> x - (floor(targetContentOffset -> x / [UIScreen mainScreen].bounds.size.width) * [UIScreen mainScreen].bounds.size.width)) > [UIScreen mainScreen].bounds.size.width){
        pageIndex++;
    }
    
    targetContentOffset -> x = pageIndex * [UIScreen mainScreen].bounds.size.width;
}

- (void)setViewConstraintWithItem:(UIImageView*) imgView
                 andWithAttribute:(NSLayoutAttribute) layoutAttribute
                        andToItem:(UIView*) toImgView
                 andWithAttribute:(NSLayoutAttribute) secondLayoutAttribute
                andWithMultiplier:(float) mult
                  andWithConstant:(float) constant{
    [self.uiScrollerView addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                          attribute:layoutAttribute
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toImgView
                                                          attribute:secondLayoutAttribute
                                                         multiplier:mult
                                                           constant:constant]];
}

@end
