namespace Color
{
  // TODO: try changing into pre-processor val
  static const float3 LUMA_WEIGHTS = float3(0.2126, 0.7152, 0.0722);

  float luma(float3 rgb) {
    // const float3 LUMA_WEIGHTS = float3(0.2126, 0.7152, 0.0722);
    return dot(rgb, LUMA_WEIGHTS);
  }
}
