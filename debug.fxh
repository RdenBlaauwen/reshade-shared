#include "functions.fxh"

#define SHARED_DEBUG__NEAR_ZERO 0.0001f
#define SHARED_DEBUG__BRANCH [branch]

namespace Debug
{
  float4 routeAlpha(float4 color, uint channel)
  {
    SHARED_DEBUG__BRANCH
    switch (channel)
    {
    case 0:
      color.r = color.a;
      break;
    case 1:
      color.g = color.a;
      break;
    case 2:
      color.b = color.a;
      break;
      // case 3: color.a = color.a; // no-op
    }
    return color;
  }

  float4 colorAsSum(float4 color, float divisor)
  {
    // sum all channels together. divide by 4 to prevent overflow
    float packedSum = Functions::sum(color) / divisor;
    return float2(packedSum, 0f).xyyy;
  }

  float4 singleChannelToWhite(float4 color)
  {
    float singleValue = saturate(Functions::sum(color));
    return float(singleValue).xxxx;
  }

  float4 applyWindow(float4 color, float2 window)
  {
    return smoothstep(window.x, window.y, color);
  }

  float4 applyWindow(float4 color, float2 window, float4 lowColor, float4 highColor)
  {
    if (any(color < window.x))
      return lowColor;
    if (any(color > window.y))
      return highColor;

    return applyWindow(color, window);
  }

  /** float2 windowThresholds: the range of values to visualize
   *  - x: window floor
   *  - y: window ceiling
   * bool singleChannelAsWhite: assumes that only one channel is active (sum of channelsToDisplay <= 1.0). Shows channel as white.
   */
  struct DebugOptions
  {
    float4 channelsToDisplay;
    bool outputChannelsAsSum;
    uint alphaOutputChannel;
    bool singleChannelAsWhite;
    float2 windowThresholds;
    bool highlightOutOfRange;
    float4 lowColor;
    float4 highColor;
  };

  float4 applyDebugOptions(float4 color, DebugOptions opts)
  {
    // change strength of each channel, or even turn them off
    color *= opts.channelsToDisplay;
    float activeChannelsWeight = Functions::sum(opts.channelsToDisplay);

    if (activeChannelsWeight == 0f)
    {
      // no channels are active, early return
      // to prevent division by zero and avoid performance hit
      return color;
    }

    if (opts.outputChannelsAsSum)
    {
      color = colorAsSum(color, activeChannelsWeight);
    }
    else
    {
      color = routeAlpha(color, opts.alphaOutputChannel);
    }

    if (opts.singleChannelAsWhite)
    {
      float nrOfActiveChannels = Functions::sum(step(SHARED_DEBUG__NEAR_ZERO, opts.channelsToDisplay));
      if (nrOfActiveChannels == 1f || opts.outputChannelsAsSum)
      {
        color = singleChannelToWhite(color);
      }
    }
    if (opts.highlightOutOfRange)
    {
      color = applyWindow(color, opts.windowThresholds, opts.lowColor, opts.highColor);
    }
    else
    {
      color = applyWindow(color, opts.windowThresholds);
    }

    return color;
  }
}