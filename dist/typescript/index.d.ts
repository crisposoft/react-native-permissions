export { PERMISSIONS } from './permissions';
export { RESULTS } from './results';
export * from './types';
export declare const check: (permission: import("./types").Permission) => Promise<import("./types").PermissionStatus>;
export declare const checkLocationAccuracy: () => Promise<import("./types").LocationAccuracy>;
export declare const checkMultiple: <P extends import("./types").Permission[]>(permissions: P) => Promise<Record<P[number], import("./types").PermissionStatus>>;
export declare const checkNotifications: () => Promise<import("./types").NotificationsResponse>;
export declare const openPhotoPicker: () => Promise<void>;
export declare const openSettings: () => Promise<void>;
export declare const request: (permission: import("./types").Permission, rationale?: import("react-native/Libraries/PermissionsAndroid/PermissionsAndroid").Rationale | (() => Promise<boolean>)) => Promise<import("./types").PermissionStatus>;
export declare const requestLocationAccuracy: (options: import("./types").LocationAccuracyOptions) => Promise<import("./types").LocationAccuracy>;
export declare const requestMultiple: <P extends import("./types").Permission[]>(permissions: P) => Promise<Record<P[number], import("./types").PermissionStatus>>;
export declare const requestNotifications: (options: import("./types").NotificationOption[]) => Promise<import("./types").NotificationsResponse>;
declare const _default: {
    PERMISSIONS: Readonly<{
        readonly ANDROID: import("./permissions.android").AndroidPermissionMap;
        readonly IOS: import("./permissions.ios").IOSPermissionMap;
        readonly WINDOWS: import("./permissions.windows").WindowsPermissionMap;
    }>;
    RESULTS: Readonly<{
        readonly UNAVAILABLE: "unavailable";
        readonly BLOCKED: "blocked";
        readonly DENIED: "denied";
        readonly GRANTED: "granted";
        readonly LIMITED: "limited";
    }>;
    check: (permission: import("./types").Permission) => Promise<import("./types").PermissionStatus>;
    checkLocationAccuracy: () => Promise<import("./types").LocationAccuracy>;
    checkMultiple: <P extends import("./types").Permission[]>(permissions: P) => Promise<Record<P[number], import("./types").PermissionStatus>>;
    checkNotifications: () => Promise<import("./types").NotificationsResponse>;
    openPhotoPicker: () => Promise<void>;
    openSettings: () => Promise<void>;
    request: (permission: import("./types").Permission, rationale?: import("react-native/Libraries/PermissionsAndroid/PermissionsAndroid").Rationale | (() => Promise<boolean>)) => Promise<import("./types").PermissionStatus>;
    requestLocationAccuracy: (options: import("./types").LocationAccuracyOptions) => Promise<import("./types").LocationAccuracy>;
    requestMultiple: <P extends import("./types").Permission[]>(permissions: P) => Promise<Record<P[number], import("./types").PermissionStatus>>;
    requestNotifications: (options: import("./types").NotificationOption[]) => Promise<import("./types").NotificationsResponse>;
};
export default _default;
//# sourceMappingURL=index.d.ts.map