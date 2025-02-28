#import "RNPermissionHandlerLocationWhenInUse.h"

#import <CoreLocation/CoreLocation.h>

@interface RNPermissionHandlerLocationWhenInUse() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) void (^resolve)(RNPermissionStatus status);
@property (nonatomic, strong) void (^reject)(NSError *error);

@end

@implementation RNPermissionHandlerLocationWhenInUse

+ (NSArray<NSString *> * _Nonnull)usageDescriptionKeys {
  return @[@"NSLocationWhenInUseUsageDescription"];
}

+ (NSString * _Nonnull)handlerUniqueId {
  return @"ios.permission.LOCATION_WHEN_IN_USE";
}

- (void)checkWithResolver:(void (^ _Nonnull)(RNPermissionStatus))resolve
                 rejecter:(void (__unused ^ _Nonnull)(NSError * _Nonnull))reject {
  reject(nil);
}

- (void)requestWithResolver:(void (^ _Nonnull)(RNPermissionStatus))resolve
                   rejecter:(void (^ _Nonnull)(NSError * _Nonnull))reject {
  reject(nil);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  [self checkWithResolver:_resolve rejecter:_reject];
}

@end
