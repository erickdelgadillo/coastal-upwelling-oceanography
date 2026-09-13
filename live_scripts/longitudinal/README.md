# Longitudinal vertical sections

This directory preserves the six historical Live Scripts used to explore the
ENV1–ENV3 transects. They are retained unchanged for provenance:

| Survey | Season | CTD script | Nutrient script | CTD day | Nutrient day |
| --- | --- | --- | --- | ---: | ---: |
| ENV1 | Winter | `env1_ctd.mlx` | `env1_nutrients.mlx` | 7 | 1 |
| ENV2 | Spring | `env2_ctd.mlx` | `env2_nutrients.mlx` | 7 | 1 |
| ENV3 | Summer | `env3_ctd.mlx` | `env3_nutrients.mlx` | 5 | 1 |

## Restored workflow

The original Live Scripts no longer match the row counts of the curated CTD
workbooks and contain several copy-and-paste errors in the nutrient station
assignments. Use the restored generator instead:

```matlab
addpath(fullfile(pwd, 'scripts', 'longitudinal'));
generate_longitudinal_sections;
```

The generator reads column names directly from the six workbooks under
`data/longitudinal/`, interpolates each variable over longitude and depth, and
writes 72 panels under `figures/longitudinal/`:

- 15 CTD panels and 21 nutrient/chlorophyll-a panels using the historical
  `jet` scale under `original/`
- the same 36 panels using variable-appropriate cmocean scales under
  `cmocean/`

The fixed colour limits from the historical scripts are preserved so seasons
remain directly comparable. The restored generator corrects only data
selection, plotting masks, labels, paths, and output organisation; it retains
the historical linear `griddata` interpolation and 5 m depth grid.

## Corrected historical defects

- Longitude is read from each observation instead of being reconstructed with
  obsolete hard-coded row counts.
- PO4, SiO2, and chlorophyll-a at stations 4–6 use their own observations
  instead of repeated station 3 values.
- CTD sample markers use the finite raw variable as their mask.
- PAR sample markers use PAR observations rather than the turbidity grid.
- Output names use the correct survey season and avoid inconsistent day
  suffixes.
