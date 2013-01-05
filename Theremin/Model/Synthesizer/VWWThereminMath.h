//
//  VWWThereminMath.h
//  Theremin
//
//  Created by Zakk Hoyt on 1/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#ifndef Theremin_VWWThereminMath_h
#define Theremin_VWWThereminMath_h

const float M_PI_3_4 = M_PI_2 + M_PI_4;

float square(const float phase){
    float p = 0;
    float r = 0;
    
    p = phase - floor(phase/M_PI) * M_PI;
    
    if(p >= 0 && p < M_PI_4){
        r = 1.0;
    }
    else if(p >= M_PI_4 && p < M_PI_2){
        r = 1.0;
    }
    else if(p >= M_PI_2 && p < M_PI_3_4){
        r = -1.0;
    }
    else{ //if(p > M_PI_3_4 && p < M_PI)
        r = -1.0;
    }
    
    return r;
}


float triangle(const float phase){
    float p = 0;
    float r = 0;
    
    p = phase - floor(phase/M_PI) * M_PI;
    
    if(p >= 0 && p < M_PI_4){
        r = p / M_PI_4;
    }
    else if(p >= M_PI_4 && p < M_PI_2){
        r = 1.0 - ((p - M_PI_4) / M_PI_4);
    }
    else if(p >= M_PI_2 && p < M_PI_3_4){
        r = -(p - M_PI_2) / M_PI_4;
    }
    else{ //if(p > M_PI_3_4 && p < M_PI)
        r = -1.0 - (-(p - M_PI_3_4) / M_PI_4);
    }
    return r;
}

float sawtooth(const float phase){
    float p = 0;
    float r = 0;
    
    p = phase - floor(phase/M_PI) * M_PI;
    
    if(p >= 0 && p < M_PI_4){
        r = p / M_PI_4 / 2.0 - 1.0;
    }
    else if(p >= M_PI_4 && p < M_PI_2){
        r = (p - M_PI_4) / M_PI_4 / 2.0 - 0.5;
    }
    else if(p >= M_PI_2 && p < M_PI_3_4){
        r = (p - M_PI_2) / M_PI_4 / 2.0;
    }
    else{ //if(p > M_PI_3_4 && p < M_PI)
        r = (p - M_PI_3_4) / M_PI_4 / 2.0 + 0.5;
    }
    return r;
}

#endif
