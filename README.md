# SHINY_scATAC-Seq
A Shiny app to explore scATAC-Seq data on Fluidigm C1-800 for low gade glioma. The experiment is described in the article: **Al-Ali R, et al. Single-nucleus chromatin accessibility reveals intratumoral epigenetic heterogeneity in IDH1 mutant gliomas. Acta Neuropathol Commun. 2019;7(1):201. Published 2019 Dec 5. doi:10.1186/s40478-019-0851-y**

## Samples
Samples were collected from university hospital /Kopf-Klinik in Heidelberg.
The nuclei were analyzed on Fluidigm C1 platform. The experiment started with 5 astrocytomas and 2 oligodendrogliomas, at the end, we obtained 3 astrocytomas and 2 oligodendroglioma.

## Data Analysis
Some reads leaks from one cell to the neighbouring ones. This means that data are not reliable in raw form. A double-cleaning method was introduced and presented reasonable results. 
The code for the reads cleaning, alignment, peak calling and annotation is avialable at: /code 



Common tools like ChromVar were tested, but the results were not satifactory. Sample separation was limited. Traditional methods rely on pathway enrichment or transcription factor enrichments to group cells.

A simpler method might be calling peaks, however, uncertenties in the method leads to weak results. However, calling peaks from several reads is showing a promising result. It come with extremly lower number of peaks, but even the smallest cells can provide clues to heterogenity in low grade glioma.

This Shiny app comes wtih results of t-SNE analysis of hyper-peaks in scATAC-Seq of at least 5 reads per peak on 10Kbp.

It is uploaded and runnning on a temporary server with AWS cloud system. The connection has no SSL, thus some servers in academia might block the connection.

http://shiny.turcanlab.org




