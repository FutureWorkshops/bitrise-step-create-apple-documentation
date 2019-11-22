//
//  SimpleClass.m
//  ObjcSimpleFramework
//
//  Created by Igor Ferreira on 22/11/2019.
//  Copyright © 2019 Future Workshops. All rights reserved.
//

#import "OSFSimpleClass.h"

@implementation OSFSimpleClass

- (instancetype _Nonnull)initWithId:(NSString * _Nonnull)objectId {
    self = [super init];
    if (self) {
        self->_objectId = objectId;
    }
    return self;
}

- (NSString * _Nonnull)displayId {
    return self.objectId;
}

- (NSString * _Nonnull)composeWithElement:(NSString * _Nonnull)element {
    return [NSString stringWithFormat:@"%@_%@", element, self.objectId];
}

@end
