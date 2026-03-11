# reshade-shared

This repository is designed to provide a centralized location for shared code used across multiple ReShade projects. It includes libraries and modules that can be easily integrated into other ReShade shaders to enhance functionality and reduce code duplication.

Questions, bugreports and contributions are welcome and appreciated! Please open an issue or submit a pull request for any improvements or bug fixes.

## Installation

My current approach is to just include the necessary library/module files in any releases of effects which need them for user convenience. That's why I don't recommend downloading these manually, unless you're a dev who wants to use the files in your own project, or if there's something wrong with the provided shared files. In the latter case you can just clone the repo into the folder which contains the effect file (e.g. `SomeRdenBlaauwenEffect.fx`). Make sure that the repo name is `reshade-shared`.

## Files Overview

This repository contains two kinds of files: modules and libraries. **Modules** contain complex functions and techniques. Their purpose is to provide fairly complete functionalities to the shaders they're used in. **Libraries** on the other hand only contain simple functions for use within more complex code. Their purpose is to make writing new code faster and easier.

**Note:** Most files in this repository use namespaces to organize their functions and variables. When using these files, ensure you access the functions and variables through their respective namespaces (e.g., `Color::luma()`, `Debug::applyDebugOptions()`). 

### Libraries

#### `libraries/color.fxh`

This file contains functions related to color. Currently, it only includes a generic luma (brightness) calculation function. Include this file in your shader to access the `Color` namespace.

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

#### `libraries/macros.fxh`

This file provides macros for generating function overloads and other repetitive code patterns. Include this file to use macros for generating function overloads, reducing boilerplate code.

This library is mostly just used in other libraries. If you want to use this repo for yourself, you probably won't need this file.

**Example:**
```hlsl
#include "macros.fxh"
GEN_OVERLOADS_UP_TO_16_PARAMS(float, max)
```

### Modules

Functions in modules cannot be hooked up to passes directly. Instead you'll have to write a wrapepr function which invokes the functions you need and provides them with the data they need. Make sure to read any instructions inside the file carefully, and to define any of the preprocessor variables it asks for. Individual functions typically have a comment explaining what they're for and what kind of inputs they need.

#### `modules/AnomalousPixelBlending.fxh`

This file provides functions for detecting and blending anomalous pixels, useful for anti-aliasing and edge detection. Include this file to access the `AnomalousPixelBlending` namespace, which contains functions for calculating blending strengths and local averages.

### Third-Party Files

The `vendor` directory contains third-party files that are freely usable under public space licenses. These files are included with their original licenses and disclaimers intact.

#### `vendor/SMAA.fxh`

This file contains the Subpixel Morphological Anti-Aliasing (SMAA) algorithm, originally developed by Jorge Jimenez, Jose I. Echevarria, Belen Masia, Fernando Navarro, and Diego Gutierrez. SMAA is licensed under the MIT License.

Include this file in your shader to access the SMAA algorithm. Follow the instructions in the file to set up the required passes and textures.

#### `vendor/modules/BeanSmoothing.fxh`

Smoothes anti-aliased jaggies further. Meant to improve the results of AA algorithms.

This algorithm is a heavily modified version of FXAA 3.11 by Timothy Lottes (COPYRIGHT (C) 2010, 2011 NVIDIA CORPORATION. ALL RIGHTS RESERVED.) and includes components from an experimental version of Lordbean's TSMAA (Temporal Subpixel Morphological Anti-Aliasing). It was developed by Lordbean and modified by RdenBlaauwen. BeanSmoothing is licensed under the MIT License.

#### `vendor/modules/CAS.fxh`

A custom implementation of the sharpening pass contained in AMD's FideliltyFX Contrast Adaptive Sharpening (CAS). This implemention attempts to follow the original implementation and it's options closely, except where changes are necessary to make the code more flexible.

The sharpening pass in this file is originally developed by AMD as part of the FidelityFX suite. CAS is licensed under the MIT License.

**Usage:** Typically you want to call `CasSetup()` first to get the sharpness value, then call `CasFilter()`. If you already have a 9 tap pattern of samples in the context you're using this in, you can just call `CasCalculations()` and pass the color values to skip having to sample again.

**Example:**
```hlsl
#include "CAS.fxh"
float const1;
CAS::CasSetup(const1, mySharpnessParam);
float3 processedColor;
CAS::CasFilter(texcoord, const1, colorLinearSampler, processedColor);
```

## Credits

Runs on Reshade by Crosire.

The `vendor` directory contains third-party files that are freely usable under public space licenses. Special thanks to:

- **Jorge Jimenez, Jose I. Echevarria, Belen Masia, Fernando Navarro, and Diego Gutierrez:** Original developers of the SMAA algorithm.

- **Lordbean:** Developer of the Smoothing function contained in the so-called "BeanSmoothing" file.

- **Timothy Lottes & NVIDIA:**  Developer and owner of FXAA, which the Smoothing function is based on.

- **AMD:** Original developers of the Contrast Adaptive Sharpening (CAS) algorithm as part of the FidelityFX suite.
