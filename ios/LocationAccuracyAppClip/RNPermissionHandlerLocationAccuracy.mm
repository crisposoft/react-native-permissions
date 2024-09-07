#import "RNPermissionHandlerLocationAccuracy.h"

#import <CoreLocation/CoreLocation.h>

@interface RNPermissionHandlerLocationAccuracy() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) void (^resolve)(RNPermissionStatus status);
@property (nonatomic, strong) void (^reject)(NSError *error);

@end

@implementation RNPermissionHandlerLocationAccuracy

+ (NSArray<NSString *> * _Nonnull)usageDescriptionKeys {
  return @[@"NSLocationTemporaryUsageDescriptionDictionary"];
}

+ (NSString * _Nonnull)handlerUniqueId {
  return @"ios.permission.LOCATION_ACCURACY";
}

- (void)checkWithResolver:(RCTPromiseResolveBlock _Nonnull)resolve
                 rejecter:(RCTPromiseRejectBlock _Nonnull)reject {
  reject(@"cannot_check_location_accuracy", @"Not available in appclip", nil);
}

- (void)requestWithPurposeKey:(NSString * _Nonnull)purposeKey
                     resolver:(RCTPromiseResolveBlock _Nonnull)resolve
                     rejecter:(RCTPromiseRejectBlock _Nonnull)reject {
  reject(@"cannot_request_location_accuracy", @"Not available in appclip", nil);
}

@end
