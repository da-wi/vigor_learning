# LogRT-model for vigor learning in the monetary incentive delay task

![Overview](https://raw.githubusercontent.com/da-wi/vigor_learning/master/overview.png)

The functions provided in this repository provide the log-response time model for vigor learning in the [monetary incentive delay task](https://github.com/da-wi/mid_fmri_task) as used in Willinger et al. (2021) and Willinger et al. (2022). The scripts work for the [TAPAS](https://github.com/translationalneuromodeling/tapas) toolbox in MATLAB.

## Installation

Copy the new model files `*.m` into you `HGF/` directory of the TAPAS toolbox. 

## Instructions

For the model I used, you will need 3 trial-wise variables for each partipant:
- The (log) response time for the target (of each outcome!)
- The cue value (in your case +1/+5/-1/-5/0)
- The monetary outcome of the trial (+1/+5/-1/-5/0)


There are perception models with one single learning rate (`tapas_rw_binary_dw.m`), two learning rates (`tapas_rw_binary_2lr_dw.m`) for reward and loss, and the observation model of logRTs `tapas_logrt_linear_binary_dw.m`.

For each subject you should be able to fit the model using 

```
estim = tapas_fitModel(log(rt),...
        [cue_value outcome],...
        'tapas_rw_binary_dw_config',...
        'tapas_logrt_linear_binary_dw_config',...
        'tapas_quasinewton_optim_config');
```

With your data looking like this 
```
rt cue_value outcome
251 1 1
280 -5 0
240 -1 -1
.
.
.
```

Where `rt` is the vector of response times, and `cue_val` is a vector with cue values and `outcome` is the vector of, well, the outcome of each trial. Also consider cleaning your behavioral data before fitting the data (e.g., remove unlikely "real" response times like `10ms`). 

## Credits

This software is based on the work of Chris Mathys (HGF Toolbox) that is part of the software collection TAPAS (Frässle et al., 2021). 

## References 

- Frässle, S., et al. (2021). TAPAS: An Open-Source Software Package for Translational Neuromodeling and Computational Psychiatry. Frontiers in Psychiatry, 12:680811. https://doi.org/10.3389/fpsyt.2021.680811

- Willinger, D., Karipidis, I. I., Dimanova, P., Walitza, S., & Brem, S. (2021). Neurodevelopment of the incentive network facilitates motivated behaviour from adolescence to adulthood. _NeuroImage_, 237, 118186.

- Willinger, D., Karipidis, I. I., Neuer, S., Emery, S., Rauch, C., Häberling, I., ... & Brem, S. (2022). Maladaptive avoidance learning in the orbitofrontal cortex in adolescents with major depression. _Biological Psychiatry: Cognitive Neuroscience and Neuroimaging, 7_ (3), 293-301.