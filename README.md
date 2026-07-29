# Drawing Tool — Software Overview

This repository contains the source code and production artifacts for "Drawing Tool," a desktop graphics editor equipped with an integrated interactive tutorial module. The software was engineered using RAD Studio (Delphi 13) and Object Pascal as part of an academic course project.

## Deployment and Execution
The application is distributed as a standalone portable executable and does not require a Delphi runtime environment.
1. Navigate to the **Releases** section on the right-hand panel of this repository.
2. Download the deployment package (`Risovalka.zip`) from the latest stable release.
3. Extract the contents to a local directory and execute `Risovalka.exe`.

## Functional Specifications
* **Vector & Raster Graphics Subsystem:** Provides fundamental drawing instrumentation, including freehand brushes, erasure tools, geometric primitive generation, and dynamic stroke/palette configuration.
* **Interactive Educational Framework:** Features a dedicated module for step-by-step drawing tutorials, rendering sequential instructional overlays directly within the graphical interface.

## Technical Limitations & Workarounds
* **High-DPI UI Scaling Anomalies:** Due to standard legacy framework constraints regarding high-density displays, layout degradation or misalignments may occur within the tutorial window on certain laptop monitors utilizing Windows display scaling factor exceeding 100% (e.g., 125% or 150%). 

