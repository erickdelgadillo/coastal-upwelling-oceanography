# Longitudinal vertical sections

This directory preserves the six historical Live Scripts used to explore the
ENV1–ENV3 transects. They are retained unchanged for provenance:

| Survey | Season | CTD script | Nutrient script | CTD day | Nutrient day |
| --- | --- | --- | --- | ---: | ---: |
| ENV1 | Winter | `env1_ctd.mlx` | `env1_nutrients.mlx` | 7 | 1 |
| ENV2 | Spring | `env2_ctd.mlx` | `env2_nutrients.mlx` | 7 | 1 |
| ENV3 | Summer | `env3_ctd.mlx` | `env3_nutrients.mlx` | 5 | 1 |

The day values in this table are literal sampling days. The static sections do
not average observations across days.

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

The horizontal coordinate is great-circle distance from 8.9145° W, calculated
with the haversine formula at the latitude recorded in each source table. It
retains the actual non-uniform spacing of the sampling profiles. The CTD
transect at 42.0° N spans 0–65.57 km; nutrient tables record 42.142° N. The
archived tables store western longitudes as positive values, which does not
affect the calculated distances.

## Corrected historical defects

- Longitude is read from each observation instead of being reconstructed with
  obsolete hard-coded row counts.
- PO4, SiO2, and chlorophyll-a at stations 4–6 use their own observations
  instead of repeated station 3 values.
- CTD sample markers use the finite raw variable as their mask.
- PAR sample markers use PAR observations rather than the turbidity grid.
- Output names use the correct survey season and avoid inconsistent day
  suffixes.

## Daily CTD animation

Additional CTD transects were recovered without modifying the archived source
files and are stored under `data/longitudinal/daily_ctd/`:

| Campaign | Season | Available days | Longitude positions |
| --- | --- | --- | ---: |
| ENV1 | Winter | 1–8 | 10 per day |
| ENV2 | Spring | 1, 3, 5, 7 | 10 per day |
| ENV3 | Summer | 1, 3, 5, 7 | 10, except day 5 with 9 |

Run `scripts/longitudinal/generate_longitudinal_ctd_animation.m` from the
repository root to create two 16-frame GIFs. The five CTD variables share the
same interpolation, depth grid, and fixed colour limits used by the restored
static workflow, including the distance-from-coast horizontal axis. Only CTD
is animated: the archived longitudinal nutrient tables contain day 1 only.
The repository retains the inputs and generator rather than a GIF produced by
another program; running the MATLAB function creates both animations.
