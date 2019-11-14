# mjo_eqwave_model

*An equatorial wave model for the Madden-Julian oscillation (MJO).  Developed in 2005, posted retroactively.*
<br>
<br>
<br>
<br>


## Contents
* [I. Overview](#I-Overview) - *brief description of repository*
* [II. Manifest](#II-Manifest) - *repository structure*
* [III. Quick Start Guide](#III-Quick-Start-Guide) - *downloading repository and running models*
* [IV. Abstract](#IV-Abstract) - *thesis abstract*
* [V. Primitive Model](#V-Primitive-Model) - *description of Primitive Equation model*
* [VI. Balanced Model](#VI-Balanced-Model) - *description of Balanced model*
* [VII. Plotting](#VII-Plotting) - *information on plotting output*
* [VIII. Citations](#VIII-Citations)
<br><br><br>


## I. Overview
This repository contains the original model code used in the MS thesis (Masarik,  2007)<sup>[1](#1)</sup>, and journal article (Schubert and Masarik, 2006)<sup>[2](#2)</sup>.
<br>
[Return to top](#mjo_eqwave_model)
<br><br><br>


## II. Manifest
```bash
mjo_eqwave_model/
├── balanced/                       #   code base for balanced model
├── docs/                           #   portions of thesis (.pdf)
├── lib/                            #   code shared between both models
├── MJO_PARAMS.m                    # adjustable run parameters
├── MJO_PLOT.m                      # main plotting script
├── MJO_SIM.m                       # main simulation script
├── plotting/                       #   scripts for plotting
├── primitive/                      #   code base for primitive equation model
└── README.md
```
[Return to top](#mjo_eqwave_model)
<br><br><br>


## III. Quick Start Guide
blah<br>
[Return to top](#mjo_eqwave_model)
<br><br><br>


## IV. Abstract
The following is a reproduction of the thesis Abstract.<br>
> POTENTIAL VORTICITY AND ENERGY ASPECTS OF THE MJO THROUGH
>                   EQUATORIAL WAVE THEORY
> 
>   Considering linearized motion about a resting basic state, we derive analytical solutions
> of the equatorial beta-plane primitive equations under the assumption that the flow is steady
> in a reference frame moving eastward with a diabatic forcing resembling a Madden-Julian oscillation (MJO)
> convective envelope.  The spectral series solutions allow us to
> decompose the total response into equatorial wave components.
>
>    The diabatic source term in the potential vorticity (PV) principle contains a factor 
> of `beta * y` which acts to suppress PV generation at the equator, while  maximizing it at the
> poleward edges of the convection.  In this way a moving heat source can produce two ribbons
> of lower tropospheric PV anomaly, a positive one off the equator in the northern hemisphere
> and a negative one off the equator in the southern hemisphere, with oppositely signed PV
> anomalies in the upper troposphere.  An approximate relationship between the geopotential
> and streamfunction is used to formulate an invertibility principle.  The balanced wind and 
> mass fields recovered from inverting the primitive equation PV quite accurately reproduce
> the flow west of the forcing.  While this result demonstrates the MJO wake response can
> be described by simple PV dynamics, it also illustrates the Kelvin response ahead of the 
> convection cannot be captured within this balanced framework.
>
>    We then derive the primitive equation total energy principle which reduces to a balance
> between generation and dissipation under the assumed steady state.  The total energy 
> can be expressed as a physical space integral, or equivalently as an infinite sum in spectral
> space through a Parseval relation.  Using the spectral sum we can isolate the individual
> equatorial wave contributions to the total energy.  The dependence of wave response energy
> on the horizontal shape, propagation speed, and meridional position of the prescribed
> forcing are examined by evaluating the Parseval relation for different values of these
> forcing parameters.
>
>
>
>
>
>
[Return to top](#mjo_eqwave_model)
<br><br><br>


## V. Primitive Model
The governing equations for the primitive equation model are presented in Ch 2.1 - Governing Equations.
blah<br>
[Return to top](#mjo_eqwave_model)
<br><br><br>


## VI. Balanced Model
blah<br>
[Return to top](#mjo_eqwave_model)
<br><br><br>


## VII. Plotting
blah<br>
[Return to top](#mjo_eqwave_model)
<br><br><br>


## VIII. Citations
* <sup><a name="1">1</a></sup> Masarik, M. T. 2007: Potential Vorticity and Energy Aspects of the MJO Through Equatorial Wave Theory.  M.S. Thesis, pp. 94, Dept. of Atmos. Sci., Colo. State Univ., Fort Collins, Colo. [PDF](http://schubert.atmos.colostate.edu/publications/theses/masarik_thesis_2007.pdf)
* <sup><a name="2">2</a></sup> Schubert, W. H., and M. T. Masarik, 2006: Potential vorticity apsects of the MJO. _Dynamics of Atmospheres and Oceans_, **42**,
127-151. [PDF](http://dx.doi.org/10.1016/j.dynatmoce.2006.02.003)

<br><br>
[Return to top](#mjo_eqwave_model)
<br><br>

