//  EntDump
//
//  Created by Dora Orak on 13.09.2025.
//

#import "ViewController.h"
#import "MachODropView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor clearColor].CGColor;
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;

    MachODropView *dropView = [[MachODropView alloc] init];
    dropView.wantsLayer = YES;
    dropView.layer.backgroundColor = [NSColor clearColor].CGColor;
    
    dropView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSImageView *imageView = [[NSImageView alloc] init];
    imageView.imageScaling = NSImageScaleProportionallyUpOrDown;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.wantsLayer = YES;
    imageView.layer.backgroundColor = [NSColor clearColor].CGColor;
    [imageView unregisterDraggedTypes];

    imageView.image = [NSImage imageWithSystemSymbolName:@"square.and.arrow.down" accessibilityDescription:@"Drop Icon"];
    
    [dropView addSubview:imageView];
    
    
    NSTextView *infoTextView = [[NSTextView alloc] init];
    infoTextView.string = @"Drag a Mach-O or a .app here to extract its entitlements.";
    infoTextView.font = [NSFont systemFontOfSize:16];
    infoTextView.alignment = NSTextAlignmentCenter;
    infoTextView.editable = NO;
    infoTextView.selectable = NO;
    infoTextView.drawsBackground = NO;
    infoTextView.translatesAutoresizingMaskIntoConstraints = NO;
        
    [self.view addSubview:dropView];
    [self.view addSubview:infoTextView];
    
    [NSLayoutConstraint activateConstraints:@[
        [infoTextView.centerXAnchor constraintEqualToAnchor:imageView.centerXAnchor],
        [infoTextView.bottomAnchor constraintEqualToAnchor:imageView.topAnchor constant:40],
        [infoTextView.widthAnchor constraintGreaterThanOrEqualToConstant:500],
        [infoTextView.heightAnchor constraintGreaterThanOrEqualToConstant:100],
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [dropView.widthAnchor constraintEqualToConstant:200],
        [dropView.heightAnchor constraintEqualToConstant:200],
        [dropView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [dropView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [imageView.widthAnchor constraintEqualToConstant:100],
        [imageView.heightAnchor constraintEqualToConstant:100],
        [imageView.centerXAnchor constraintEqualToAnchor:dropView.centerXAnchor],
        [imageView.centerYAnchor constraintEqualToAnchor:dropView.centerYAnchor]
    ]];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

