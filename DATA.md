# Data inventory and provenance

The repository includes the 15 Excel workbooks required by the retained MATLAB
workflows. They were copied without modification from the curated data archive
formerly shared with the metatranscriptomic repository.

## Layout

| Directory | Files | Scope |
| --- | ---: | --- |
| `data/temporal/` | 6 | Station 3 and Station 6 publication profiles plus two additional ENV1 analyses |
| `data/longitudinal/` | 6 | CTD and nutrient inputs for ENV1–ENV3 transects |
| `data/exploratory/` | 1 | General environmental metadata used by exploratory scripts |
| `data/figures/` | 2 | AMT29 profile inputs used by the plain MATLAB figure workflow |

The total size is approximately 31 MB. Each workbook is below GitHub's
individual file-size limit.

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
data inventory.

## Known missing exploratory input

`scripts/exploratory/oceanographic_exploration.m` references
`nutrients_remedios_cruise.mat`. That file was not present in the curated data
archive and is therefore not included. The same script calls the external
`cmocean` package, which is also not bundled. These dependencies apply only to
that exploratory script and not to the documented publication workflow.
