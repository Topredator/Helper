//
//  TPUIGradientLayer+TPExtension.m
//  Helper
//
//  Created by Topredator on 2024/12/22.
//

#import "TPUIGradientLayer+TPExtension.h"

@implementation TPUIGradientLayer (TPExtension)
+ (TPUIGradientLayer *)tp_commonLayer {
    return [self gradientBeginColor:[TPUI tp_r:53 g:250 b:169] endColor:[TPUI tp_r:70 g:198 b:245]
                          direction:TPUIGradientDirectionLeftToRight];
}
@end
