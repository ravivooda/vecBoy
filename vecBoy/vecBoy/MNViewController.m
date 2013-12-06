//
//  MNViewController.m
//  vecBoy
//
//  Created by Ravi Vooda on 06/12/13.
//  Copyright (c) 2013 Mafian. All rights reserved.
//

#import "MNViewController.h"
#import <ImageIO/ImageIO.h>
#import <CoreImage/CoreImage.h>

@interface MNViewController ()

@end

@implementation MNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated {
    UIImage *image = [UIImage imageNamed:@"image.jpg"];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:nil];
    CIImage *img = [[CIImage alloc] initWithCGImage:image.CGImage];
    NSArray *features = [detector featuresInImage:img];
    NSLog(@"Features :\n%@",[features description]);
    UIImageView *waste = [[UIImageView alloc] initWithFrame:self.view.frame];
    [waste setImage:image];
    [self.view.window addSubview:waste];
    for (CIFaceFeature *feature in features) {
        CGFloat faceWidth = feature.bounds.size.width;
        NSLog(@"%@",NSStringFromCGRect(feature.bounds));
        // create a UIView using the bounds of the face
        UIView* faceView = [[UIView alloc] initWithFrame:feature.bounds];
        
        // add a border around the newly created UIView
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.view.window addSubview:faceView];
        
        if(feature.hasLeftEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(feature.leftEyePosition.x-faceWidth*0.15, feature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            // set the position of the leftEyeView based on the face
            [leftEyeView setCenter:feature.leftEyePosition];
            // round the corners
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            // add the view to the window
            [self.view.window addSubview:leftEyeView];
        }
        
        if(feature.hasRightEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* leftEye = [[UIView alloc] initWithFrame:CGRectMake(feature.rightEyePosition.x-faceWidth*0.15, feature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [leftEye setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            // set the position of the rightEyeView based on the face
            [leftEye setCenter:feature.rightEyePosition];
            // round the corners
            leftEye.layer.cornerRadius = faceWidth*0.15;
            // add the new view to the window
            [self.view.window addSubview:leftEye];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
