//
//  ResultWindow.m
//  EntDump
//
//  Created by Dora Orak on 17.09.2025.
//

#import "ResultWindow.h"
#import "CopyableTextField.h"

@implementation ResultWindow

-(instancetype)initWithEntitlements:(NSArray*)entitlements ContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingType defer:(BOOL)flag {
    self = [super initWithContentRect:contentRect styleMask:style backing:backingType defer:flag];
    if (self) {
        
        self.releasedWhenClosed = NO;
        
        [self setTitle:@"Entitlements"];
        
        NSStackView *stackView = [NSStackView stackViewWithViews:@[]];
        stackView.orientation = NSUserInterfaceLayoutOrientationVertical;
        stackView.alignment = NSLayoutAttributeCenterX;
        stackView.spacing = 8.0;
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
        [NSLayoutConstraint activateConstraints:@[
            [scrollView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:1],
            [scrollView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-1],
            [scrollView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [scrollView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        ]];
        // Constraints for stackView
        [NSLayoutConstraint activateConstraints:@[
            [stackView.leadingAnchor constraintEqualToAnchor:scrollView.contentView.leadingAnchor constant:3],
            [stackView.trailingAnchor constraintEqualToAnchor:scrollView.contentView.trailingAnchor constant:-1],
            [stackView.topAnchor constraintEqualToAnchor:scrollView.contentView.topAnchor constant:10],
            [stackView.bottomAnchor constraintEqualToAnchor:scrollView.contentView.bottomAnchor constant:-10],
        ]];
        
    }
    return self;
}

@end
