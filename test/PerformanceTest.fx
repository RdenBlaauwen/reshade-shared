#include "ReShadeUI.fxh"

#ifndef USE_AUTO_FRAMETIME_BASELINE
  #define USE_AUTO_FRAMETIME_BASELINE 0
#endif

uniform bool _RunSUT <
    ui_label = "Run SUT";
    ui_type = "checkbox";
    ui_tooltip = "Switch between code you want to test and the original code";
> = false;

uniform int _IterationCount <
    ui_label = "Test iterations per pixel";
    ui_type = "slider";
    ui_min = 1; ui_max = 100;
    ui_tooltip = "Higher values = more stress testing";
> = 10;

uniform float2 _FrameTimeBounds <
    ui_label = "Frame time bounds";
    ui_type = "slider";
    ui_min = 0f; ui_max = 15f; ui_step = 0.010f;
    ui_tooltip = "x: baseline frametime (ms), y: upper bound frametime (ms)";
> = float2(0.060, 1f);

uniform float _OutputScale <
    ui_label = "Output scale";
    ui_type = "slider";
    ui_min = 0.01; ui_max = 1.0; ui_step = 0.01;
    ui_tooltip = "How visible output is. Needed to prevent optimizer from optimizing away the output.";
> = 0.1;

uniform float3 _GoodPerformanceColor <
    ui_label = "Good performance color";
    ui_type = "color";
    ui_tooltip = "Color shown when frametime is at or below baseline";
> = float3(0, 0.5, 0);

uniform float3 _BadPerformanceColor <
    ui_label = "Bad performance color";
    ui_type = "color";
    ui_tooltip = "Color shown when frametime is at or above upper bound";
> = float3(1, 0, 0);

#include "ReShade.fxh"
#include "../functions.fxh"
#include "FunctionsOptimized.fxh"

uniform float _FrameTime < source = "frametime"; >;
uniform float4 _Date < source = "date"; >;

#ifndef USE_AUTO_FRAMETIME_BASELINE

uniform int _FrameCount < source = "framecount"; >;
uniform float _Timer < source = "timer"; >;

#endif

#define CHANNEL_OFFSET_R 0.1
#define CHANNEL_OFFSET_G 0.2
#define CHANNEL_OFFSET_B 0.3
#define TIME_SCALE 0.1
#define VALUE_FEEDBACK_SCALE 0.01

float getFrameTimeBaseline()
{
    #if USE_AUTO_FRAMETIME_BASELINE
        return _Timer / _FrameCount;
    #else
        return _FrameTimeBounds.x; // Use the lower bound as baseline
    #endif
}

float3 StressTestPS(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target {
    float baseValue = frac(texcoord.x + texcoord.y + _Date.w * TIME_SCALE);
    
    float3 values[12];
    [unroll]
    for(int i = 0; i < 12; i++) {
        values[i] = float3(
            frac(baseValue + i * CHANNEL_OFFSET_R),
            frac(baseValue + i * CHANNEL_OFFSET_G),
            frac(baseValue + i * CHANNEL_OFFSET_B)
        );
    }
    
    float3 result = 0;
    
    [unroll]
    for(int i = 0; i < _IterationCount; i++) {
        if(_RunSUT) {
            result += FunctionsOptimized::max(
                values[0], values[1], values[2], values[3],
                values[4], values[5], values[6], values[7],
                values[8], values[9], values[10], values[11]
            );
        }
        else {
            result += Functions::max(
                values[0], values[1], values[2], values[3],
                values[4], values[5], values[6], values[7],
                values[8], values[9], values[10], values[11]
            );
        }
        
        [unroll]
        for(int j = 0; j < 12; j++) {
            values[j] = frac(values[j] + result * VALUE_FEEDBACK_SCALE);
        }
    }

    // focus on value of frametime between upper and lower bound, to make changes more visible
    float frameTimeSlice = smoothstep(getFrameTimeBaseline(), _FrameTimeBounds.y, _FrameTime);

    float3 output = lerp(_GoodPerformanceColor, _BadPerformanceColor, frameTimeSlice);

    output.b = saturate(length(result) * _OutputScale);

    return output;
}

technique FunctionsPerformanceTest {
    pass {
        VertexShader = PostProcessVS;
        PixelShader = StressTestPS;
    }
}
