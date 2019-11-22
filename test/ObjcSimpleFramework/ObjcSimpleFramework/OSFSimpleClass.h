//
//  SimpleClass.h
//  ObjcSimpleFramework
//
//  Created by Igor Ferreira on 22/11/2019.
//  Copyright © 2019 Future Workshops. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SimpleClass)
/// A simple class to test the documentation process
@interface OSFSimpleClass : NSObject

/// ID of the object
@property (nonatomic, strong, nonnull, readonly) NSString *objectId NS_SWIFT_NAME(id);

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/// Inits the object with a default values
/// @param objectId Value to be associated with the id
- (instancetype _Nonnull)initWithObjectId:(NSString * _Nonnull)objectId
    NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(id:));

/// Returns the plain object id
- (NSString * _Nonnull)displayId;

/// Composes the id with a prefix
/// @param element String to prefix
- (NSString * _Nonnull)composeWithElement:(NSString * _Nonnull)element;

@end

NS_ASSUME_NONNULL_END
