//
//  ResultWindow.m
//  EntDump
//
//  Created by Dora Orak on 17.09.2025.
//

#import "ResultWindow.h"
#import "CopyableTextField.h"
#import "FlippedStackView.h"

@implementation ResultWindow

-(instancetype)initWithEntitlements:(NSArray*)entitlements ContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingType defer:(BOOL)flag title:(NSString*)title {
    self = [super initWithContentRect:contentRect styleMask:style backing:backingType defer:flag];
    if (self) {
        
        self.releasedWhenClosed = NO;
        
        [self setTitle:title];
        
        FlippedStackView *stackView = [FlippedStackView stackViewWithViews:@[]];
        stackView.orientation = NSUserInterfaceLayoutOrientationVertical;
        stackView.alignment = NSLayoutAttributeCenterX;
        stackView.spacing = 8.0;
        stackView.distribution = NSStackViewDistributionGravityAreas;
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        
        for (NSString* entitlement in entitlements) {
                        
            CopyableTextField *label = [[CopyableTextField alloc] init];
            
            label.stringValue = entitlement;
            label.editable = NO;
            label.selectable = YES;
            label.bezeled = YES;
            label.drawsBackground = YES;
            label.font = [NSFont systemFontOfSize:14];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.translatesAutoresizingMaskIntoConstraints = NO;

            NSGlassEffectView* labelGlassView = [[NSGlassEffectView alloc] initWithFrame:label.bounds];
            labelGlassView.translatesAutoresizingMaskIntoConstraints = NO;
            [labelGlassView setContentView:label];
            
            NSButton *copyButton = [NSButton buttonWithImage:[NSImage imageWithSystemSymbolName:@"document.on.document.fill" accessibilityDescription:@"copy"] target:label action:@selector(copyText:)];
            copyButton.translatesAutoresizingMaskIntoConstraints = NO;
            copyButton.toolTip = @"Copy to Clipboard";
            
            NSGlassEffectView* buttonGlassView = [[NSGlassEffectView alloc] initWithFrame:copyButton.bounds];
            buttonGlassView.translatesAutoresizingMaskIntoConstraints = NO;
            [buttonGlassView setContentView:copyButton];
            
            NSStackView *hStack = [NSStackView stackViewWithViews:@[labelGlassView, buttonGlassView]];
            hStack.orientation = NSUserInterfaceLayoutOrientationHorizontal;
            hStack.alignment = NSLayoutAttributeCenterY;
            hStack.spacing = 8.0;
            hStack.translatesAutoresizingMaskIntoConstraints = NO;
            
            [stackView addArrangedSubview:hStack];

        }

        NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:contentRect];
        scrollView.hasVerticalScroller = YES;
        scrollView.hasHorizontalScroller = NO;
        scrollView.autohidesScrollers = YES;
        scrollView.borderType = NSNoBorder;
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        scrollView.documentView = stackView;

        [self.contentView addSubview:scrollView];

        // Constraints for scrollView
        // Scroll view constraints
        [NSLayoutConstraint activateConstraints:@[
            [scrollView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15],
            [scrollView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [scrollView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:1],
            [scrollView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-1],
        ]];

        // StackView constraints
        [NSLayoutConstraint activateConstraints:@[
            [stackView.topAnchor constraintEqualToAnchor:scrollView.contentView.topAnchor constant:10],
            [stackView.leadingAnchor constraintEqualToAnchor:scrollView.contentView.leadingAnchor constant:3],
            [stackView.trailingAnchor constraintEqualToAnchor:scrollView.contentView.trailingAnchor constant:-1]
        ]];
        
    }
    return self;
}

@end
