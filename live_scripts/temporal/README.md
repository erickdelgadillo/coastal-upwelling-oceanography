# Published temporal profile workflow

This directory contains the historical MATLAB Live Scripts used to generate
the environmental profile panels in Supplementary Figures 1 and 2 of the
associated Frontiers in Marine Science article. Their exact input workbooks
are stored under the repository's `data/temporal/` directory.

## Figure mapping

| Figure | Station | Live script | Input | Panels used in the publication |
| --- | --- | --- | --- | --- |
| Supplementary Figure 1 | Offshore (Station 3) | `station3_ctd.mlx` | `S3_CTD.xlsx` | Temperature, salinity, fluorescence, turbidity, and PAR |
| Supplementary Figure 1 | Coast (Station 6) | `station6_ctd.mlx` | `S6_CTD.xlsx` | Temperature, salinity, fluorescence, turbidity, and PAR |
| Supplementary Figure 2 | Offshore (Station 3) | `station3_nutrients.mlx` | `S3_Metadata.xlsx` | NH4, NO2, NO3, SiO2, and PO4 |
| Supplementary Figure 2 | Coast (Station 6) | `station6_nutrients.mlx` | `S6_Metadata.xlsx` | NH4, NO2, NO3, SiO2, and PO4 |

The scripts export individual seasonal panels. The nutrient scripts also
export TIN and bottle chlorophyll-a panels, but those 12 outputs are not used in
Supplementary Figure 2. The published figures arrange the selected panels in a
5 × 6 grid: variables by row, with offshore winter/spring/summer followed by
coastal winter/spring/summer in the columns.

## Run

From the repository root in MATLAB:

```matlab
repoRoot = pwd;
paths = coastal_setup('temporal');
open(fullfile(paths.repo_root, 'live_scripts', 'temporal', 'station3_ctd.mlx'));
```

Open each `.mlx` file and select **Run**. The setup function changes MATLAB's
working folder to `data/temporal/`, so the historical relative filenames
continue to resolve unchanged. Generated PNG files are written beside the
workbooks and ignored by Git. Curated copies from the successful interactive
run on 13 September 2026 remain locally under `data/temporal/`. The complete
matrices can then be generated with
[`assemble_supplementary_figures.m`](../../scripts/figures/assemble_supplementary_figures.m).

All four scripts were run with MATLAB R2026a using the light figure theme. The
run produced all 72 expected panel files: 30 CTD outputs and 42 nutrient and
chlorophyll-a outputs. Sixty panels are represented in the two published
figures.

## Input checksums

The checksums preserve traceability to the selected files in the historical
ENVISION working directory.

```text
eb5b2c0f2b10b4b436196d5d2cdd55a288fe0e91e63746a552b3844ec0c8eff4  S3_CTD.xlsx
4b966df02560e496468efc58d7bd38d0dd84c74aa25e3f03de5033b2ec7bb678  S3_Metadata.xlsx
25f618983e9589e7de739007ab3a8fc9968fe29be7abdcba98d097283fc186c7  S6_CTD.xlsx
ee69672c0e43d707ff56ac6606365f2f7e5b58c70da8b00ca5f36b252283e7c5  S6_Metadata.xlsx
```

The four live scripts also match their selected historical counterparts byte
for byte. File modification dates were not used as the sole selection criterion
because the archive was migrated in 2025; selection was based on script names,
input references, exported panel names, and visual correspondence with the final
supplementary PDF.
