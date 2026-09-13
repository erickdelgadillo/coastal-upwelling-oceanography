# Published supplementary figures

This directory contains the two complete oceanographic figures in the layout
used by the associated article:

- `supplementary_figure_1.png`: temperature, fluorescence-derived chlorophyll-a,
  PAR, salinity, and turbidity
- `supplementary_figure_2.png`: ammonium, nitrite, nitrate, silicate, and
  phosphate

Each figure is a 5 × 6 composition. Variables are arranged by row. Columns are
offshore winter, offshore spring, offshore summer, coastal winter, coastal
spring, and coastal summer. Each composition also includes the published panel
numbers, shared labels, colour scales, and caption.

## Provenance

The source figures are the 6202 × 6236 pixel, 900 DPI TIFF files deposited in
Frontiers/Figshare with the article:

- Article: <https://doi.org/10.3389/fmars.2023.1259783>
- Original supplementary package: <https://doi.org/10.3389/fmars.2023.1259783.s001>
- Corrected supplementary package: <https://doi.org/10.3389/fmars.2023.1259783.s005>

The 2026 correction replaced Supplementary Figures 3 and 5, not Figures 1 and
2. This was additionally verified by comparing the original and corrected
packages: the TIFF files for Figures 1 and 2 are byte-identical.

The TIFF images were converted losslessly to RGB PNG so GitHub can display them
directly. Image dimensions and pixel values were preserved. Source TIFF
SHA-256 checksums:

```text
38776e6756bbb609d896ff3939cf4f80b6724624e1478e12fa015ed4f655bcef  Supplementary Figure 1.TIF
9ce27d0f750cf4175ae02fbd27dc63d6e18e8c1313113a12884a5e2141c5d820  Supplementary Figure 2.TIF
```

The four MATLAB Live Scripts generate the individual panels beside their input
workbooks under `data/temporal/`. Those working outputs are intentionally
ignored by Git; only the complete publication-ready compositions are versioned
here.
