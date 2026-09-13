# Coastal upwelling oceanography

![MATLAB](https://img.shields.io/badge/MATLAB-analysis-orange)
![Oceanography](https://img.shields.io/badge/oceanography-CTD%20%26%20nutrients-0077B6)
![Status](https://img.shields.io/badge/status-curated%20publication%20workflow-blue)

MATLAB workflows and oceanographic datasets associated with the study
**“Coastal upwelling systems as dynamic mosaics of bacterioplankton functional
specialization.”**

This repository contains the physical and biogeochemical oceanography part of
the study. The metatranscriptomic and microbial analyses are maintained
separately in
[`coastal-upwelling-metat`](https://github.com/erickdelgadillo/coastal-upwelling-metat).

## Scientific scope

- CTD profiles for coastal and offshore stations
- Nutrient and chlorophyll-a profiles
- Seasonal temporal comparisons
- Longitudinal ENV1–ENV3 transects
- Interpolation and oceanographic visualization in MATLAB

## Published workflow

The final article material was compared with the historical ENVISION working
directory to identify the scripts and workbooks used for the published CTD and
nutrient panels.

| Published figure | Content | Live scripts | Input workbooks |
| --- | --- | --- | --- |
| Supplementary Figure 1 | Temperature, fluorescence-derived chlorophyll-a, PAR, salinity, and turbidity profiles | `station3_ctd.mlx`, `station6_ctd.mlx` | `S3_CTD.xlsx`, `S6_CTD.xlsx` |
| Supplementary Figure 2 | Ammonium, nitrite, nitrate, silicate, and phosphate profiles | `station3_nutrients.mlx`, `station6_nutrients.mlx` | `S3_Metadata.xlsx`, `S6_Metadata.xlsx` |

Station 3 is the offshore station and Station 6 is the coastal station. The
four publication workbooks are under `data/temporal/`. Their checksums and the
detailed figure mapping are documented in
[`live_scripts/temporal/README.md`](live_scripts/temporal/README.md).

The other scripts and workbooks are retained as additional historical or
exploratory analyses and are not claimed to reproduce published figures.

## Published figures

The four publication Live Scripts were executed interactively with MATLAB
R2026a on 13 September 2026 and generated 72 seasonal panel files. The final
article used 60 of these panels in two 5 × 6 compositions:

- [Supplementary Figure 1](figures/supplementary_figure_1.png) — CTD profiles
- [Supplementary Figure 2](figures/supplementary_figure_2.png) — nutrient profiles

Rows represent variables. Columns show winter, spring, and summer at the
offshore station followed by the same seasons at the coastal station. The two
high-resolution PNGs reproduce the published compositions; the original 900
DPI TIFF files from the article were converted losslessly for display on
GitHub. See [`figures/README.md`](figures/README.md) for provenance and the
complete panel mapping.

## Run

Start MATLAB in the repository root:

```matlab
repoRoot = pwd;
paths = coastal_setup('temporal');
open(fullfile(paths.repo_root, 'live_scripts', 'temporal', 'station3_ctd.mlx'));
```

Open and run the desired Live Script. `coastal_setup` adds the bundled
third-party utilities and changes MATLAB's working folder to the matching data
directory, preserving the historical relative input paths.

Available workflow names are `temporal`, `longitudinal`, `exploratory`, and
`figures`. To store the input data elsewhere, set
`COASTAL_UPWELLING_OCEANOGRAPHY_DATA_DIR` to a directory with the same layout.

## Repository structure

```text
coastal-upwelling-oceanography/
├── data/                 # MATLAB input workbooks
│   ├── temporal/         # Published and exploratory temporal inputs
│   ├── longitudinal/     # ENV1–ENV3 transect inputs
│   ├── exploratory/      # General temporal metadata
│   └── figures/          # Inputs for plain MATLAB figure scripts
├── live_scripts/
│   ├── temporal/         # Published temporal profile scripts
│   └── longitudinal/     # Additional transect analyses
├── figures/
│   ├── supplementary_figure_1.png
│   └── supplementary_figure_2.png
├── scripts/
│   ├── figures/          # Historical figure scripts
│   └── exploratory/      # Exploratory analyses
├── third_party/          # External MATLAB utilities and notices
├── coastal_setup.m       # Workflow and data-path setup
├── DATA.md               # Data provenance and inventory
└── README.md
```

## Data provenance

The 15 workbooks were transferred without modification from the curated local
data archive previously used by `coastal-upwelling-metat`. The files total
about 31 MB and are included so the MATLAB workflows do not depend on a
separate private directory. See [`DATA.md`](DATA.md) and
[`data/SHA256SUMS`](data/SHA256SUMS) for the complete inventory and checksums.

The inspected workbooks contain oceanographic observations and no personal
contact information.

## Requirements and validation

The workflows use MATLAB functions including `xlsread` and `exportgraphics`.
`gridfit`, `brewermap`, and `brewermap_view` are retained under `third_party/`
with their original attribution and notices.

The selected publication Live Scripts match their historical counterparts byte
for byte. Their input names and output panels were matched to the final
supplementary figures. The workbooks pass ZIP-container integrity checks.

The four publication Live Scripts were run interactively with MATLAB R2026a on
13 September 2026 and produced all 72 expected PNG panels. Every output was
checked as a valid PNG, and representative panels from both stations, all three
seasons, and both workflows were reviewed visually. Automated batch execution
from the migration environment remained unavailable because MATLAB Service
Host returned licensing error 5201; this did not affect the interactive run.

The historical exploratory script `oceanographic_exploration.m` also references
an unavailable `nutrients_remedios_cruise.mat` file and the external `cmocean`
package. This limitation does not affect the four publication Live Scripts.

## Associated publications

- Delgadillo-Nuño et al. (2024), *Frontiers in Marine Science*,
  <https://doi.org/10.3389/fmars.2023.1259783>
- Correction (2026), *Frontiers in Marine Science*,
  <https://doi.org/10.3389/fmars.2026.1886620>

The 2026 correction replaces Supplementary Figures 3 and 5. The MATLAB
workflows here correspond to Supplementary Figures 1 and 2 and are not
identified as affected by that correction.

## Author

**Erick Delgadillo-Nuño**

Marine microbial ecology · Oceanography · MATLAB · Reproducible scientific workflows
