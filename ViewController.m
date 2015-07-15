//
//  ViewController.m
//  ScrollView-Image-Gallery
//
//  Created by Jeff Huang on 2015-07-14.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "ViewController.h"
#import "ImageDetailViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *uiScrollerView;
@property (nonatomic) UITapGestureRecognizer *tapGesture;
@property (nonatomic) CGPoint tapPoint;

@property (nonatomic) UIImageView *imagePlaceholder1;
@property (nonatomic) UIImageView *imagePlaceholder2;
@property (nonatomic) UIImageView *imagePlaceholder3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    
    [self.uiScrollerView addGestureRecognizer:self.tapGesture];
    
    UIImage *img1 = [UIImage imageNamed:@"Lighthouse-in-Field"];
    UIImage *img2 = [UIImage imageNamed:@"Lighthouse-night"];
    UIImage *img3 = [UIImage imageNamed:@"Lighthouse-zoomed"];

    self.imagePlaceholder1 = [[UIImageView alloc] initWithImage:img1];
    [self.imagePlaceholder1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.uiScrollerView addSubview:self.imagePlaceholder1];
    [self setViewConstraintWithItem:self.imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeLeft
                          andToItem:self.uiScrollerView
                   andWithAttribute:NSLayoutAttributeLeft
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:self.imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeTopMargin
                          andToItem:self.uiScrollerView
                   andWithAttribute:NSLayoutAttributeTopMargin
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:self.imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeHeight
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeHeight
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.height];
    [self setViewConstraintWithItem:self.imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeWidth
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeWidth
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.width];
    
    self.imagePlaceholder2 = [[UIImageView alloc] initWithImage:img2];
    [self.imagePlaceholder2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.uiScrollerView addSubview:self.imagePlaceholder2];
    [self setViewConstraintWithItem:self.imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeLeading
                          andToItem:self.imagePlaceholder1
                   andWithAttribute:NSLayoutAttributeTrailing
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:self.imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeTopMargin
                          andToItem:self.uiScrollerView
                   andWithAttribute:NSLayoutAttributeTopMargin
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:self.imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeHeight
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeHeight
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.height];
    [self setViewConstraintWithItem:self.imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeWidth
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeWidth
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.width];

    self.imagePlaceholder3 = [[UIImageView alloc] initWithImage:img3];
    [self.imagePlaceholder3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.uiScrollerView addSubview:self.imagePlaceholder3];
    [self setViewConstraintWithItem:self.imagePlaceholder3
                   andWithAttribute:NSLayoutAttributeLeading
                          andToItem:self.imagePlaceholder2
                   andWithAttribute:NSLayoutAttributeTrailing
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:self.imagePlaceholder3
                   andWithAttribute:NSLayoutAttributeRight
                          andToItem:self.uiScrollerView
                   andWithAttribute:NSLayoutAttributeRight
                  andWithMultiplier:1
                    andWithConstant:0];
    [self setViewConstraintWithItem:self.imagePlaceholder3
                   andWithAttribute:NSLayoutAttributeHeight
                          andToItem:nil
                   andWithAttribute:NSLayoutAttributeHeight
                  andWithMultiplier:1
                    andWithConstant:[UIScreen mainScreen].bounds.size.height];
    [self setViewConstraintWithItem:self.imagePlaceholder3
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

- (void)tapImage:(id)sender{
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer*)sender;
    if(tapGesture.state == UIGestureRecognizerStateBegan){
        self.tapPoint = [tapGesture locationInView:self.uiScrollerView];
    }
    if(tapGesture.state == UIGestureRecognizerStateEnded){
        if([self checkView:self.imagePlaceholder1 withCurrentLocation:self.tapPoint]){
            [self performSegueWithIdentifier:@"zoomPhoto" sender:self.imagePlaceholder1];
        }
        else if([self checkView:self.imagePlaceholder2 withCurrentLocation:self.tapPoint]){
            [self performSegueWithIdentifier:@"zoomPhoto" sender:self.imagePlaceholder2];
        }
        else if([self checkView:self.imagePlaceholder3 withCurrentLocation:self.tapPoint]){
            [self performSegueWithIdentifier:@"zoomPhoto" sender:self.imagePlaceholder3];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"zoomPhoto"]){
        ImageDetailViewController *imgDVC = [segue destinationViewController];
        UIImageView *tempHolder = sender;
        imgDVC.zoomView.image = tempHolder.image;
    }
}

- (BOOL)checkView:(UIView*) checkedView withCurrentLocation:(CGPoint) currLoc{
    if (CGRectContainsPoint(checkedView.frame, currLoc)) {
        return true;
    }
    else
        return false;
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
