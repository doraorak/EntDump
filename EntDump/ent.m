//
//  ent.m
//  EntDump
//
//  Created by Dora Orak on 13.09.2025.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

// Function to extract entitlements from a Mach-O binary path
NSArray<NSString *>* GetEntitlements(NSString *machOPath) {
    NSURL *url = [NSURL fileURLWithPath:machOPath];
    SecStaticCodeRef staticCode = NULL;
    NSDictionary *entitlements = nil;
    NSArray<NSString *> *entitlementKeys = nil;

    OSStatus status = SecStaticCodeCreateWithPath((__bridge CFURLRef)url, kSecCSDefaultFlags, &staticCode);
    if (status != errSecSuccess) {
        NSLog(@"Failed to create static code for path: %@ (error: %d)", machOPath, (int)status);
        return nil;
    }
    CFDictionaryRef info = NULL;
    status = SecCodeCopySigningInformation(staticCode, kSecCSSigningInformation, &info);
    if (status == errSecSuccess && info) {
        NSDictionary *infoDict = (__bridge_transfer NSDictionary *)info;
        entitlements = infoDict[(__bridge NSString *)kSecCodeInfoEntitlementsDict];
        if ([entitlements isKindOfClass:[NSDictionary class]]) {
            entitlementKeys = [entitlements allKeys];
        }
    } else {
        NSLog(@"Failed to copy signing information (error: %d)", (int)status);
    }
    if (staticCode) {
        CFRelease(staticCode);
    }
    return entitlementKeys;
}


id GetValueOfEntitlement(NSString *entitlement, NSString* machOPath) {
    
    NSURL *url = [NSURL fileURLWithPath:machOPath];
    SecStaticCodeRef staticCode = NULL;
    NSDictionary *entitlements = nil;

    OSStatus status = SecStaticCodeCreateWithPath((__bridge CFURLRef)url, kSecCSDefaultFlags, &staticCode);
    if (status != errSecSuccess) {
        NSLog(@"Failed to create static code for path: %@ (error: %d)", machOPath, (int)status);
        return nil;
    }
    CFDictionaryRef info = NULL;
    status = SecCodeCopySigningInformation(staticCode, kSecCSSigningInformation, &info);
    if (status == errSecSuccess && info) {
        NSDictionary *infoDict = (__bridge_transfer NSDictionary *)info;
        entitlements = infoDict[(__bridge NSString *)kSecCodeInfoEntitlementsDict];
    }
    if (staticCode) {
        CFRelease(staticCode);
    }
    
    return entitlements[entitlement];
    
}
