# Generated longitudinal sections

Run `scripts/longitudinal/generate_longitudinal_sections.m` to populate this
directory. The function creates two subdirectories:

- `original/`: historical `jet` colour scale
- `cmocean/`: perceptually uniform, variable-specific oceanographic palettes

Each directory contains 36 panels: five CTD variables and seven
nutrient/chlorophyll-a variables for winter, spring, and summer. Generated PNG
files are derived outputs; the source workbooks remain under
`data/longitudinal/`.

Running the animation generator creates an `animations/` directory with two
16-frame daily CTD summaries:

- `longitudinal_ctd_daily_original.gif`: historical `jet` scale
- `longitudinal_ctd_daily_cmocean.gif`: variable-specific cmocean scales

Each frame combines temperature, salinity, fluorescence, turbidity, and PAR.
The sequence covers ENV1 days 1–8, ENV2 days 1, 3, 5, and 7, and ENV3 days 1,
3, 5, and 7. Run
`scripts/longitudinal/generate_longitudinal_ctd_animation.m` to rebuild both
files from `data/longitudinal/daily_ctd/`.

The generated GIF files are not stored in advance. Their x-axis reports
great-circle distance from the coastal endpoint in kilometres, preserving the
actual separation between profiles over the 65.57 km transect.
