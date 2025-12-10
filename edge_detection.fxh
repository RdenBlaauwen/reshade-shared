#ifndef EDGE_DETECTION_FXH // include guard
#define EDGE_DETECTION_FXH

//// IMPLEMENTATION
// MACROS with example values for the ReShade language:
// The following preprocessor variables should be defined in the main file.
// The values are defaults and can be changed as needed:
// #define EdgeDetectionTexture2D(tex) sampler tex
// #define EdgeDetectionSamplePoint(tex, coord) tex2D(tex, coord)

#include "functions.fxh"
#include "color.fxh"

namespace EdgeDetection {
    /**
     * Hybrid between SMAA's color edge detection and luma edge detection, which relies more on color the more colorful
     * the involved pixels are.
     * Originally from PSMAA, for testing purposes, to compare the performance of an edge detection algorithm
     * which does not use a delta texture and does not rely on a separate delta pass, to that of
     * the PSMAA edge detection method (which *does* separate the delta calculation from the edge detection).
     */
    void HybridDetectionPS(
      float2 texcoord,
      float4 offset[3],
      EdgeDetectionTexture2D(colorTex),
      float2 threshold,
      float localContrastAdaptationFactor,
      out float2 edgesOutput
    )
    {
      // Calculate color deltas:
      float4 delta;
      float4 colorRange;

      float3 C = EdgeDetectionSamplePoint(colorTex, texcoord).rgb;
      float midRange = Functions::max(C) - Functions::min(C);

      float3 Cleft = EdgeDetectionSamplePoint(colorTex, offset[0].xy).rgb;
      float rangeLeft = Functions::max(Cleft) - Functions::min(Cleft);
      float colorfulness = max(midRange, rangeLeft);
      float3 t = abs(C - Cleft);
      delta.x = (colorfulness * Functions::max(t)) + ((1.0 - colorfulness) * Color::luma(t));

      float3 Ctop = EdgeDetectionSamplePoint(colorTex, offset[0].zw).rgb;
      float rangeTop = Functions::max(Ctop) - Functions::min(Ctop);
      colorfulness = max(midRange, rangeTop);
      t = abs(C - Ctop);
      delta.y = (colorfulness * Functions::max(t)) + ((1.0 - colorfulness) * Color::luma(t));

      // We do the usual threshold:
      float2 edges = step(threshold, delta.xy);

      // Early return if there is no edge:
      if (edges.x == -edges.y)
        discard;

      // Calculate right and bottom deltas:
      float3 Cright = EdgeDetectionSamplePoint(colorTex, offset[1].xy).rgb;
      t = abs(C - Cright);
      float rangeRight = Functions::max(Cright) - Functions::min(Cright);
      colorfulness = max(midRange, rangeRight);
      delta.z = (colorfulness * Functions::max(t)) + ((1.0 - colorfulness) * Color::luma(t));

      float3 Cbottom = EdgeDetectionSamplePoint(colorTex, offset[1].zw).rgb;
      t = abs(C - Cbottom);
      float rangeBottom = Functions::max(Cright) - Functions::min(Cright);
      colorfulness = max(midRange, rangeBottom);
      delta.w = (colorfulness * Functions::max(t)) + ((1.0 - colorfulness) * Color::luma(t));

      // Calculate the maximum delta in the direct neighborhood:
      float2 maxDelta = max(delta.xy, delta.zw);

      // Calculate left-left and top-top deltas:
      float3 Cleftleft = EdgeDetectionSamplePoint(colorTex, offset[2].xy).rgb;
      t = abs(Cleft - Cleftleft);
      float rangeLeftLeft = Functions::max(Cright) - Functions::min(Cright);
      colorfulness = max(rangeLeft, rangeLeftLeft);
      delta.z = (colorfulness * Functions::max(t)) + ((1.0 - colorfulness) * Color::luma(t));

      float3 Ctoptop = EdgeDetectionSamplePoint(colorTex, offset[2].zw).rgb;
      t = abs(Ctop - Ctoptop);
      float rangeTopTop = Functions::max(Cright) - Functions::min(Cright);
      colorfulness = max(rangeTop, rangeTopTop);
      delta.w = (colorfulness * Functions::max(t)) + ((1.0 - colorfulness) * Color::luma(t));

      // Calculate the final maximum delta:
      maxDelta = max(maxDelta.xy, delta.zw);
      float finalDelta = max(maxDelta.x, maxDelta.y);

      // Local contrast adaptation:
      edges.xy *= step(finalDelta, localContrastAdaptationFactor * delta.xy);

      edgesOutput = edges;
    }
}

#endif // EDGE_DETECTION_FXH include guard