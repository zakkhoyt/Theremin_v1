//
//  VWWThereminInstrumentView.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWThereminSynthesizerSettings.h"

@class VWWThereminInstrumentView;

@protocol VWWThereminInstrumentViewDelegate
-(void)VWWThereminInstrumentView:(VWWThereminInstrumentView*)sender touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface VWWThereminInstrumentView : UIView
@property (nonatomic, assign) id <VWWThereminInstrumentViewDelegate> delegate;
@property (nonatomic, retain) VWWThereminSynthesizerSettings* settings;
@property (nonatomic, retain) UIColor* crosshairColor;
@end
