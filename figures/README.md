# Assembled supplementary figures

Four complete oceanographic matrices are generated here by
`scripts/figures/assemble_supplementary_figures.m`:

- `supplementary_figure_1.png`: temperature, fluorescence-derived chlorophyll-a,
  PAR, salinity, and turbidity using the original article colour scale
- `supplementary_figure_2.png`: ammonium, nitrite, nitrate, silicate, and
  phosphate using the original article colour scale
- `supplementary_figure_1_cmocean.png`: the same CTD composition using cmocean
  palettes
- `supplementary_figure_2_cmocean.png`: the same nutrient composition using a
  cmocean palette

Each output is a 5 × 6 composition. Variables are arranged by row. Columns are
offshore winter, offshore spring, offshore summer, coastal winter, coastal
spring, and coastal summer. Each composition includes panel numbers, shared
axis labels, seasonal headings, and one colour scale per variable.

## Generate

First run the four temporal Live Scripts so that their 72 PNG outputs exist in
`data/temporal/`. Then, from the repository root:

```matlab
addpath(fullfile(pwd, 'scripts', 'figures'));
assemble_supplementary_figures;
```

The function validates that every required panel exists before assembling
anything. It creates:

- `figures/supplementary_figure_1.png`
- `figures/supplementary_figure_2.png`
- `figures/supplementary_figure_1_cmocean.png`
- `figures/supplementary_figure_2_cmocean.png`

An alternative output directory can be supplied as the first argument.

The assembler uses the 30 CTD panels generated for temperature, calibrated
fluorescence, PAR, salinity, and turbidity. It also uses 30 nutrient panels for
ammonium, nitrite, nitrate, silicate, and phosphate. The 12 TIN and bottle
chlorophyll-a outputs are not included because they were not part of
Supplementary Figure 2.

## Colour alternatives

The two unsuffixed files preserve the rainbow (`jet`) scale used in the
article. The `_cmocean` files provide perceptually uniform alternatives from
the oceanography-specific cmocean collection:

| Variable | cmocean palette |
| --- | --- |
| Temperature | `thermal` |
| Chlorophyll-a | `algae` |
| PAR | `solar` |
| Salinity | `haline` |
| Turbidity | `turbid` |
| Nutrients | `matter` |

The assembler maps only pixels belonging to the original `jet` scale. Grey
sampling profiles, observation markers, labels, and numeric scales are left
unchanged. The bundled `third_party/cmocean.m` implementation and its MIT
licence make the alternative output reproducible without a separate MATLAB
add-on.
