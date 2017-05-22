# Supporting materials icann2017-pps

This repository stores data and scripts accompanying an ICANN 2017 submission entitled **Learning a peripersonal space representation as a visuo-tactile prediction task** by Zdenek Straka and Matej Hoffmann.

The programs and documents are distributed without any warranty.  All use of these programs is entirely at the user's own risk.

## Acknowledgement

Some parts of the code are based on the [code](https://github.com/jgmakin/rbmish) provided by J.G. Makin et al. (PLoS Comp. Biology 2013; reference [7] in the article). Base code for training a deep belief network with contrastive divergence was taken from Salukhutdinov and Hinton. See comments in the code for credits.

## Requirements

All of the data have been processed and visualized in MATLAB, and it is the only requirement for retrieving the data and running the scripts on this repository. To clone this repository, the user needs a working git client installed on his/her Operating System. If this is not available, it is also possible to download the repository as a .zip file by clicking on the Download ZIP button on the top of this page.

**Before using the code, add all subfolders (RBM, FFNN, testing, auxiliary and their subfolders) to MatLab's path (`addpath`) and download mat files to RBM and FFNN subfolders (see MAT_DOWNLOAD.txt in the subfolders).**

## Repository Structure

The repository is divided into several subfolders:
- `RBM` - data and scripts used in "RBM learning." subsection of the paper. The flow: vis_veloc_train_set_scen1_FFNN.m --> vis_veloc_train_scen1_FFNN.mat --> EFH_vis_velocity_scen1_FFNN_p1.m --> RBM_vis_velocity_scen1_FFNN_p1ep60.mat.

- `FFNN` - data and scripts used in "Feedforward network learning." subsection of the paper. The flow: PPS_train_set_scenario1_FFNN_p2_v2.m --> PPS_train_scenario1_FFNN_p2_v2.mat --> prepare_FFNN_scenario1_FFNN_p2.m --> ready_FFNN_scenario1_FFNN_p2_v2.mat --> prepare_backprop_pred_p2.m --> backprop_learning_scenario1_FFNN_p2_v2.mat --> train_FFNN_1301p2.m --> FFNN_1301p2.mat.

- `testing` - data and scripts used in "Peripersonal space representation testing" and "Analysis of the results" subsections of the paper.

- `auxiliary` - auxiliary data and scripts. 


## Notes on parameters
Please excuse occassional use of quasi-latex notation (e.g. greek letters, \in,..).
### RF centers
The centers of the visual (position) neuron Receptive fields (RFs) **c**<sub>j</sub><sup>pos</sup>, j \in {1,2,..,289} form a grid of size 17x17 that is placed in the 2D space [0, 0.8]x[-0.1, 0.7] (see the visual space in Fig. 1 left of the article). Some of the centers (y<0) are placed below the visual field. The neurons with these “non-visible” centers are activated only if some neurons with the “visible” centers are activated. Near the edges, this prevents the distortion of the mean \psi(**r**<sup>pos</sup>)  toward the central part of the visual field.

The centers of the velocity neuron RFs **c**<sub>j</sub><sup>vel</sup>, j\in{1,2,..,625} form a grid of size 25x25 in the 2D space [-0.012, 0.012]x[-0.012, 0.012]. Note that this is velocity space - not a subspace of the visual or the tactile space / RF. 

The RF centers c<sub>j</sub><sup>tact</sup>, j\in{1,2,..,25} of the tactile neurons form 1D grid of size 25x1 that is placed in the 1D space [0.1, 0.7]x{0}. However the skin itself covers only the subspace [0.2, 0.6]x{0} (see Fig. 1 left). The neurons with RF center outside the skin are activated only if some neurons with the center on the skin are activated. Again, near the skin edges, this prevents the distortion of the mean \psi(**r**<sup>tact</sup>) toward the central part of the skin.


### Covariance matrices
The covariance matrices used have values:
\Sigma<sub>t</sub><sup>pos</sup>=[0.00125, 0;0, 0.00125], \Sigma<sub>t</sub><sup>vel</sup>=[1.127*10^{-6}, 0;0, 1.127*10^{-6}], \Sigma<sub>t</sub><sup>tact</sup>=[0.00125].
