# Generated longitudinal sections

Run `scripts/longitudinal/generate_longitudinal_sections.m` to populate this
directory. The function creates two subdirectories:

- `original/`: historical `jet` colour scale
- `cmocean/`: perceptually uniform, variable-specific oceanographic palettes

Each directory contains 36 panels: five CTD variables and seven
nutrient/chlorophyll-a variables for winter, spring, and summer. Generated PNG
files are derived outputs; the source workbooks remain under
`data/longitudinal/`.
