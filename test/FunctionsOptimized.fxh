/**
* Commonly used convenience functions.
*/
namespace FunctionsOptimized
{
  namespace Shared
  {
    float dotArithmetic(float2 vec, float weight)
    {
      return dot(vec, float2(weight, weight));
    }
    float dotArithmetic(float3 vec, float weight)
    {
      return dot(vec, float3(weight, weight, weight));
    }
    float dotArithmetic(float4 vec, float weight)
    {
      return dot(vec, float4(weight, weight, weight, weight));
    }
  }

  float max(float a, float b,float c)
  {
    return max(a,max(b,c));
  }
  float max(float a,float b,float c,float d)
  {
    return max(a, max(b,c,d));
  }
  float max(float a,float b,float c,float d, float e)
  {
    return max(a, max(b,c,d,e));
  }
  float max(float a,float b,float c,float d, float e, float f)
  {
    return max(a, max(b,c,d,e,f));
  }
  float max(float a,float b,float c,float d, float e, float f, float g)
  {
    return max(a, max(b,c,d,e,f,g));
  }
  float max(float a,float b,float c,float d, float e, float f, float g, float h)
  {
    return max(a, max(b,c,d,e,f,g,h));
  }
  float max(float a,float b,float c,float d, float e, float f, float g, float h, float i)
  {
    return max(a, max(b,c,d,e,f,g,h,i));
  }

  float2 max(float2 a, float2 b,float2 c)
  {
    return max(a,max(b,c));
  }
  float2 max(float2 a,float2 b,float2 c,float2 d)
  {
    return max(a, max(b,c,d));
  }
  float2 max(float2 a,float2 b,float2 c,float2 d, float2 e)
  {
    return max(a, max(b,c,d,e));
  }
  float2 max(float2 a,float2 b,float2 c,float2 d, float2 e, float2 f)
  {
    return max(a, max(b,c,d,e,f));
  }
  float2 max(float2 a,float2 b,float2 c,float2 d, float2 e, float2 f, float2 g)
  {
    return max(a, max(b,c,d,e,f,g));
  }
  float2 max(float2 a,float2 b,float2 c,float2 d, float2 e, float2 f, float2 g, float2 h)
  {
    return max(a, max(b,c,d,e,f,g,h));
  }
  float2 max(float2 a,float2 b,float2 c,float2 d, float2 e, float2 f, float2 g, float2 h, float2 i)
  {
    return max(a, max(b,c,d,e,f,g,h,i));
  }


  // 3
  float3 max(float3 a, float3 b,float3 c)
  {
    return max(a,max(b,c));
  }

  // 4
  float3 max(float3 a,float3 b,float3 c,float3 d)
  {
    return max(max(a,b), max(c,d));
  }

  // 5
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e)
  {
    return max(a, max(b,c,d,e));
  }

  // 6
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f)
  {
    return max(a, max(b,c,d,e,f));
  }

  // 7
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g)
  {
    return max(max(a,b,c,d),max(e,f,g));
  }

  // 8
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h)
  {
    return max(max(a,b,c,d), max(e,f,g,h));
  }

  // 9
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i)
  {
    return max(a, max(b,c,d,e,f,g,h,i));
  }

  // 10
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i, float3 j)
  {
    return max(max(a,b,c,d,e,f,g,h),max(i,j));
  }

  //11
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i, float3 j, float3 k)
  {
    return max(a, max(b,c,d,e,f,g,h,i,j,k));
  }

  // 12
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i, float3 j, float3 k, float3 l)
  {
    return max(max(a,b,c,d,e,f,g,h), max(i,j,k,l));
  }

  // 15
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i, float3 j, float3 k, float3 l, float3 m, float3 n, float3 o)
  {
    return max(max(a,b,c,d,e,f,g,h), max(i,j,k,l,m,n,o));
  }
  // 16
  float3 max(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i, float3 j, float3 k, float3 l, float3 m, float3 n, float3 o, float3 p)
  {
    return max(max(a,b,c,d,e,f,g,h), max(i,j,k,l,m,n,o,p));
  }

  float min(float a, float b,float c)
  {
    return min(a,min(b,c));
  }
  float min(float a,float b,float c,float d)
  {
    return min(a, min(b,c,d));
  }
  float min(float a,float b,float c,float d, float e)
  {
    return min(a, min(b,c,d,e));
  }
  float min(float a,float b,float c,float d, float e, float f)
  {
    return min(a, min(b,c,d,e,f));
  }
  float min(float a,float b,float c,float d, float e, float f, float g)
  {
    return min(a, min(b,c,d,e,f,g));
  }
  float min(float a,float b,float c,float d, float e, float f, float g, float h)
  {
    return min(a, min(b,c,d,e,f,g,h));
  }
  float min(float a,float b,float c,float d, float e, float f, float g, float h, float i)
  {
    return min(a, min(b,c,d,e,f,g,h,i));
  }

  float2 min(float2 a, float2 b,float2 c)
  {
    return min(a,min(b,c));
  }
  float2 min(float2 a,float2 b,float2 c,float2 d)
  {
    return min(a, min(b,c,d));
  }
  float2 min(float2 a,float2 b,float2 c,float2 d, float2 e)
  {
    return min(a, min(b,c,d,e));
  }
  float2 min(float2 a,float2 b,float2 c,float2 d, float2 e, float2 f)
  {
    return min(a, min(b,c,d,e,f));
  }
  float2 min(float2 a,float2 b,float2 c,float2 d, float2 e, float2 f, float2 g)
  {
    return min(a, min(b,c,d,e,f,g));
  }
  float2 min(float2 a,float2 b,float2 c,float2 d, float2 e, float2 f, float2 g, float2 h)
  {
    return min(a, min(b,c,d,e,f,g,h));
  }
  float2 min(float2 a,float2 b,float2 c,float2 d, float2 e, float2 f, float2 g, float2 h, float2 i)
  {
    return min(a, min(b,c,d,e,f,g,h,i));
  }

  float3 min(float3 a, float3 b,float3 c)
  {
    return min(a,min(b,c));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d)
  {
    return min(a, min(b,c,d));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d, float3 e)
  {
    return min(a, min(b,c,d,e));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f)
  {
    return min(a, min(b,c,d,e,f));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g)
  {
    return min(a, min(b,c,d,e,f,g));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h)
  {
    return min(a, min(b,c,d,e,f,g,h));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i)
  {
    return min(a, min(b,c,d,e,f,g,h,i));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i, float3 j)
  {
    return min(a, min(b,c,d,e,f,g,h,i,j));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i, float3 j, float3 k)
  {
    return min(a, min(b,c,d,e,f,g,h,i,j,k));
  }
  float3 min(float3 a,float3 b,float3 c,float3 d, float3 e, float3 f, float3 g, float3 h, float3 i, float3 j, float3 k, float3 l)
  {
    return min(a, min(b,c,d,e,f,g,h,i,j,k,l));
  }

  float max(float2 rg)
  {
    return max(rg.r, rg.g);
  }
  float max(float3 rgb)
  {
    return max(max(rgb.rg), rgb.b);
  }
  float max(float4 rgba)
  {
    return max(max(rgba.rgb), rgba.a);
  }
  
  float min(float2 rg)
  {
    return min(rg.r, rg.g);
  }
  float min(float3 rgb)
  {
    return min(min(rgb.rg), rgb.b);
  }
  float min(float4 rgba)
  {
    return min(min(rgba.rgb), rgba.a);
  }

  float sum(float2 vec)
  {
    return Shared::dotArithmetic(vec, 1.0);
  }
  float sum(float3 vec)
  {
    return Shared::dotArithmetic(vec, 1.0);
  }
  float sum(float4 vec)
  {
    return Shared::dotArithmetic(vec, 1.0);
  }

  float avg(float2 vec)
  {
    return Shared::dotArithmetic(vec, 0.5);
  }
  float avg(float3 vec)
  {
    const float mod = 1.0 / 3.0;
    return Shared::dotArithmetic(vec, mod);
  }
  float avg(float4 vec)
  {
    return Shared::dotArithmetic(vec, 0.25);
  }
  float avg(float x, float y, float z, float w)
  {
    return avg(float4(x,y,z,w));
  }

  bool any(float2 vec)
  {
    return sum(vec) > 0.0;
  }
  bool any(float3 vec)
  {
    return sum(vec) > 0.0;
  }
  bool any(float4 vec)
  {
    return sum(vec) > 0.0;
  }

  /**
   * @SCALE_LINEAR
   * Meant for turning linear values super-linear: Makes it's input bigger in such a way that lower values become 
   * proportionally bigger than higher values. Output never exceeds 1.0;
   *
   * @param `val` input to be scaled
   * @return output val. Amplified in a non-linear fashion.
   */
  float sineScale(float val){
    const float piHalf = 1.5707;
    return val = sin(val * piHalf);
  }

  /**
   * @param input some factor with a value of threshold floor 0.0 - 1.0
   */
  float clampScale(float input, float modifier, float floor, float ceil)
  {
    return clamp(input * modifier, floor, ceil);
  }

}
