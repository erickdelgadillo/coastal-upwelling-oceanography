# Data inventory and provenance

The repository includes 31 data files: 22 Excel workbooks and 9 CSV files.
They were copied without modification from the curated data archive formerly
shared with the metatranscriptomic repository and from the preserved local
ENVISION MATLAB archive.

## Layout

| Directory | Files | Scope |
| --- | ---: | --- |
| `data/temporal/` | 6 | Station 3 and Station 6 publication profiles plus two additional ENV1 analyses |
| `data/longitudinal/` | 6 | CTD and nutrient inputs used by the static ENV1–ENV3 transects |
| `data/longitudinal/daily_ctd/` | 16 | Available daily CTD transects used by the animations |
| `data/exploratory/` | 1 | General environmental metadata used by exploratory scripts |
| `data/figures/` | 2 | AMT29 profile inputs used by the plain MATLAB figure workflow |

The total size is approximately 32 MB. Each file is below GitHub's individual
file-size limit.

## Published inputs

| Figure | Input | SHA-256 |
| --- | --- | --- |
| Supplementary Figure 1 | `data/temporal/S3_CTD.xlsx` | `eb5b2c0f2b10b4b436196d5d2cdd55a288fe0e91e63746a552b3844ec0c8eff4` |
| Supplementary Figure 1 | `data/temporal/S6_CTD.xlsx` | `25f618983e9589e7de739007ab3a8fc9968fe29be7abdcba98d097283fc186c7` |
| Supplementary Figure 2 | `data/temporal/S3_Metadata.xlsx` | `4b966df02560e496468efc58d7bd38d0dd84c74aa25e3f03de5033b2ec7bb678` |
| Supplementary Figure 2 | `data/temporal/S6_Metadata.xlsx` | `ee69672c0e43d707ff56ac6606365f2f7e5b58c70da8b00ca5f36b252283e7c5` |

The selection is based on script input names, exported panel names, and visual
correspondence with the final supplementary material. Archive modification
dates were not used as the sole selection criterion.

## Integrity

[`data/SHA256SUMS`](data/SHA256SUMS) records every included workbook. From the
repository root, verify the files with:

```bash
sha256sum -c data/SHA256SUMS
```

The workbooks were also checked as valid Office Open XML ZIP containers before
the repository was created.

## Generated outputs

Historical scripts write PNG panels beside their input workbooks. These files
are ignored by Git so running a workflow does not add generated figures to the
data inventory. The four publication workflows were executed interactively on
13 September 2026, producing all 72 expected panel files. The final publication
uses 60 of them: 30 CTD panels in Supplementary Figure 1 and 30 nutrient panels
in Supplementary Figure 2. The 12 additional TIN and bottle chlorophyll-a
outputs are not part of these published figures.

The individual generated files remain in `data/temporal/` as ignored local
outputs. Run `scripts/figures/assemble_supplementary_figures.m` to select the 60
publication panels and create the four complete 5 × 6 colour variants under
[`figures/`](figures/). The matrices are derived exclusively from the locally
generated PNG files.

The six workbooks under `data/longitudinal/` contain the ENV1–ENV3 observations
used for vertical sections across the coast–offshore transect. The preserved
historical Live Scripts contain obsolete row-count assumptions and station
copy-and-paste errors. Use
`scripts/longitudinal/generate_longitudinal_sections.m` to generate corrected,
traceable outputs under `figures/longitudinal/`.

These static sections are individual-day snapshots, not averages. Their CTD
days are ENV1 day 7, ENV2 day 7, and ENV3 day 5; the nutrient sections use day
1 in all three campaigns. The recovered daily CTD set contains ENV1 days 1–8,
ENV2 days 1, 3, 5, and 7, and ENV3 days 1, 3, 5, and 7. ENV3 day 5 contains
nine longitude positions rather than ten. No equivalent multi-day nutrient
transects were found, so the animation workflow is restricted to CTD
variables.

The longitude values are degrees west stored as positive numbers. The plotting
scripts combine longitude and latitude with the haversine formula and use
distance from 8.9145° W as the horizontal coordinate. The calculation uses the
latitude recorded in each input table because the CTD files describe the
transect at 42.0° N whereas the nutrient files record 42.142° N. For CTD, the
offshore endpoint at 9.708° W is 65.57 km from the coastal endpoint.

## Known missing exploratory input

`scripts/exploratory/oceanographic_exploration.m` references
`nutrients_remedios_cruise.mat`. That file was not present in the curated data
archive and is therefore not included. The `cmocean` package is now bundled;
only the missing MAT file prevents that exploratory workflow from running in
full. This limitation does not affect the documented temporal or longitudinal
workflows.
