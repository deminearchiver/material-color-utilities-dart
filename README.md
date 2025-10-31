# Material Color Utilities

Algorithms and utilities that power the Material Design 3 (M3) color system, including choosing theme colors from images and creating tones of colors; all in a new color space.

> This package is unpublished, meaning it is impossible to get it from pub.dev hosted registry. To learn how to use this package, see [Getting started](#getting-started).

<details>
  <summary><h3>Table of contents</h3></summary>
  
- [Material Color Utilities](#material-color-utilities)
  - [Getting started](#getting-started)
    - [With Pub workspaces (recommended)](#with-pub-workspaces-recommended)
    - [Without Pub workspaces](#without-pub-workspaces)
  - [About](#about)
    - [Theory behind MCU](#theory-behind-mcu)
    - [Capabilities Overview](#capabilities-overview)
    - [Learn about color science](#learn-about-color-science)
</details>

<!-- ## Features

TODO: List what your package can do. Maybe include images, gifs, or videos. -->

## Getting started

This package is a maintained but unpublished version of the hosted [`material_color_utilities`](https://pub.dev/packages/material_color_utilities) package. If the same name was used for this package, a naming conflict would occur when publishing to [pub.dev](https://pub.dev). Choosing an alternative name is not a good option, since it locks the consumers of this package to an external dependency alongside the original package.

Based on the aforementioned issues it is recommended to store the source code of this package inside of the source code of a depending project. The name of the package is up the consumer to choose.

The process of integrating this package into your project differs based on whether [Pub workspaces](https://dart.dev/tools/pub/workspaces) are being used or not.

### With Pub workspaces (recommended)

1. Create a new workspace package using `dart create --template=package material_color_utilities`. Note that you can use any directory name.
  
2. Change the `name` field in `material_color_utilities/pubspec.yaml` to your liking (do not use `material_color_utilities`, as it will conflict with the original package). Set `resolution: workspace` and `publish_to: none`. In this example, the `mcu` name will be used:
   
    ```yaml
    name: mcu
    publish_to: none
    resolution: workspace
    ```
    
3. Add the package to the parent workspace:

    ```yaml
    workspace:
      - material_color_utilities # Relative path to the workspace package
    ```
4. Remove unneeded files and directories, such as: `README.md`, `CHANGELOG.md`, `test`, `lib`, etc.
   
5. Clone or download this repository.
   
6. Copy the `lib` folder from this repository into the workspace package.
   
7. Add the workspace package to your project's dependencies as a [Path package](https://dart.dev/tools/pub/dependencies#path-packages):
    
    ```yaml
    dependencies:
      mcu:
        path: ../material_color_utilities # Relative path to the workspace package
    ```
8. Now you can import the package in your code, such as:
   
    ```dart
    import 'package:mcu/material_color_utilities.dart';
    ```

### Without Pub workspaces

Let's assume that your project's package is named `my_app`.

1. Clone or download this repository:

    ```sh
    git clone https://github.com/deminearchiver/material-color-utilities-dart.git
    ```

2. Create a folder with name of your choice anywhere inside the `lib` directory of your project (for this example, we will use `mcu` and place it directly inside of `lib`): `my_app/lib/mcu`.
   
3. Copy the *contents* of the `lib` directory of **this repository** into the `mcu` folder.

4. Now, you can import the package, such as:

    ```dart
    import 'package:my_app/mcu/material_color_utilities.dart`;
    ```

<!-- ## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
``` -->

<!-- ## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more. -->

## About

### Theory behind MCU

Color is a powerful design tool and part of the Material system along with
styles like typography and shape. In products, colors and the way they are used
can be vast and varied. An app’s color scheme can express brand and style.
Semantic colors can communicate meaning. And color contrast control supports
visual accessibility.

In many design systems of the past, designers manually picked app colors to
support the necessary range of color applications and use cases. Material 3
introduces a dynamic color system, which does not rely on hand-picked colors.
Instead, it uses color algorithms to generate beautiful, accessible color
schemes based on dynamic inputs like a user’s wallpaper. This enables greater
flexibility, personalization, and expression, all while streamlining work for
designers and teams.

Material Color Ultilities (MCU) powers dynamic color with a set of color
libraries containing algorithms and utilities that make it easier for you to
develop color themes and schemes in your app.

<video autoplay muted loop src="https://user-images.githubusercontent.com/6655696/146014425-8e8e04bc-e646-4cc2-a3e7-97497a3e1b09.mp4" data-canonical-src="https://user-images.githubusercontent.com/6655696/146014425-8e8e04bc-e646-4cc2-a3e7-97497a3e1b09.mp4" class="d-block rounded-bottom-2 width-fit" style="max-width:640px;"></video>


### Capabilities Overview

<a href="https://github.com/material-foundation/material-color-utilities/raw/main/cheat_sheet.png">
    <img alt="library cheat sheet" src="https://github.com/material-foundation/material-color-utilities/raw/main/cheat_sheet.png" style="max-width:640px;" />
</a>

The library consists of various components, each having its own folder and
tests, designed to be as self-contained as possible. This enables seamless
integration of subsets into other libraries, like Material Design Components
and Android System UI. Some consumers do not require all components, for
example, MDC doesn’t need quantization, scoring, image extraction.

### Learn about color science

[The Science of Color & Design - Material Design](https://material.io/blog/science-of-color-design)
