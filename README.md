# reshade-shared

A collection of shared functions and libraries for use in ReShade projects. This repository contains reusable code for post-processing effects, including color manipulation, debugging tools, mathematical functions, and specialized algorithms like Anomalous Pixel Blending.

## Introduction

This repository is designed to provide a centralized location for shared code used across multiple ReShade projects. It includes libraries and modules that can be easily integrated into other ReShade shaders to enhance functionality and reduce code duplication.

## Files Overview

**Note:** Most files in this repository use namespaces to organize their functions and variables. When using these files, ensure you access the functions and variables through their respective namespaces (e.g., `Color::luma()`, `Debug::applyDebugOptions()`).

### Libraries

#### `libraries/color.fxh`

This file contains functions related to color. Currently, it only includes a generic luma (brightness) calculation function. Include this file in your shader to access the `Color` namespace.

**Example:**
```hlsl
#include "color.fxh"
float brightness = Color::luma(float3(1.0, 0.5, 0.2));
```

#### `libraries/debug.fxh`

This file provides debugging tools for visualizing and analyzing shader outputs. It includes functions for channel manipulation, windowing, and highlighting out-of-range values. Include this file and define `SHARED_DEBUG__ACTIVE_` to enable debugging features. Use the `Debug` namespace to apply debugging options to your shader outputs.

**Example:**
```hlsl
#include "debug.fxh"
DebugOptions opts = Debug::UIControls::bootstrapDebugOptions();
float4 debugOutput = Debug::applyDebugOptions(color, opts);
```

#### `libraries/functions.fxh`

This file provides commonly used mathematical functions, including max, min, sum, and average calculations for vectors of various sizes. Include this file to access the `Functions` namespace, which contains a variety of mathematical utilities.

**Example:**
```hlsl
#include "functions.fxh"
float maxVal = Functions::max(float3(0.1, 0.5, 0.9));
```

#### `libraries/macros.fxh`

This file provides macros for generating function overloads and other repetitive code patterns. Include this file to use macros for generating function overloads, reducing boilerplate code.

**Example:**
```hlsl
#include "macros.fxh"
GEN_OVERLOADS_UP_TO_16_PARAMS(float, max)
```

### Modules

#### `modules/AnomalousPixelBlending.fxh`

This file provides functions for detecting and blending anomalous pixels, useful for anti-aliasing and edge detection. Include this file to access the `AnomalousPixelBlending` namespace, which contains functions for calculating blending strengths and local averages.

**Example:**
```hlsl
#include "AnomalousPixelBlending.fxh"
float strength = AnomalousPixelBlending::calcBlendingStrength(deltas, threshold, marginFactor);
```

### Third-Party Files

The `vendor` directory contains third-party files that are freely usable under public space licenses. These files are included with their original licenses and disclaimers intact.

#### `vendor/SMAA.fxh`

**Authorship and License:**
This file contains the Subpixel Morphological Anti-Aliasing (SMAA) algorithm, originally developed by Jorge Jimenez, Jose I. Echevarria, Belen Masia, Fernando Navarro, and Diego Gutierrez. SMAA is licensed under the MIT License.

**Description:**
SMAA is a high-quality anti-aliasing technique that provides excellent results with minimal performance impact.

**Usage:** Include this file in your shader to access the SMAA algorithm. Follow the instructions in the file to set up the required passes and textures.

**Example:**
```hlsl
#include "SMAA.fxh"
```

#### `vendor/modules/BeanSmoothing.fxh`

**Authorship and License:**
This file contains the BeanSmoothing algorithm, which is a modified version of FXAA 3.11 and includes components from TSMAA (Temporal Subpixel Morphological Anti-Aliasing). It was developed by Lordbean and modified by RdenBlaauwen. BeanSmoothing is licensed under the MIT License.

**Description:**
BeanSmoothing provides a smoothing effect for post-processing.

**Usage:** Include this file in your shader to access the `BeanSmoothing` namespace, which contains functions for applying the smoothing effect.

**Example:**
```hlsl
#include "BeanSmoothing.fxh"
float3 smoothedColor = BeanSmoothing::smooth(texcoord, offset, colorTex, blendSampler, threshold, maxIterations);
```

#### `vendor/modules/CAS.fxh`

**Authorship and License:**
This file contains the Contrast Adaptive Sharpening (CAS) algorithm, originally developed by AMD as part of the FidelityFX suite. It has been modified by RdenBlaauwen to work with the ReShade graphics language. CAS is licensed under the MIT License.

**Description:**
CAS provides a sharpening effect that adapts to the contrast of the image.

**Usage:** Include this file in your shader to access the `CAS` namespace, which contains functions for applying the sharpening effect.

**Example:**
```hlsl
#include "CAS.fxh"
float const1;
CAS::CasSetup(const1, sharpness);
float3 processedColor;
CAS::CasFilter(texcoord, const1, colorLinearSampler, processedColor);
```

## Credits

This repository includes code and algorithms developed by various contributors. Special thanks to:

- **RdenBlaauwen:** Maintainer of this repository and primary author of the included libraries and modules.

### Third-Party Contributors

The `vendor` directory contains third-party files that are freely usable under public space licenses. We extend our gratitude to the original authors:

- **Jorge Jimenez, Jose I. Echevarria, Belen Masia, Fernando Navarro, and Diego Gutierrez:** Original developers of the SMAA algorithm.

- **Lordbean:** Developer of the BeanSmoothing algorithm, which includes components from FXAA and TSMAA.

- **AMD:** Original developers of the Contrast Adaptive Sharpening (CAS) algorithm as part of the FidelityFX suite.

Thank you for your contributions to the open-source community!

## Installation

To use this library in your ReShade project:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/RdenBlaauwen/reshade-shared.git
   ```

2. **Include the Files:**
   Copy the required files from the `libraries` and `modules` directories into your project's shader directory.

3. **Use the Functions:**
   Include the necessary files in your shader and use the provided functions and namespaces.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## Support

For questions or issues, please open an issue on the GitHub repository.
