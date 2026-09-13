# Third-party MATLAB utilities

This directory contains one deduplicated copy of each external utility used by
the historical workflows:

- `brewermap.m` and `brewermap_view.m`, by Stephen Cobeldick, based on color
  schemes by Cynthia Brewer and collaborators. The source files contain their
  copyright and Apache License 2.0 notices.
- `gridfit.m`, by John D'Errico. Its original source header and attribution are
  preserved.
- `cmocean.m`, by Chad Greene, using oceanographic colormaps created by Kristen
  Thyng. It was obtained from the official
  [cmocean MATLAB repository](https://github.com/chadagreene/cmocean) and is
  distributed under the MIT License in `CMOCEAN_LICENSE.txt`.

For the design rationale and suggested variable-specific use, see Thyng et al.
(2016), *True Colors of Oceanography*,
<https://doi.org/10.5670/oceanog.2016.66>.

Do not remove or replace the notices embedded in these files. Before assigning
a repository-wide license, verify that it is compatible with every bundled
third-party component.
