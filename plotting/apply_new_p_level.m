%
% apply_new_p_level.m
%

% get updated z structure from p
Znew = structureZ(p);

% construct full field(xi,y,z) from horizontal fields * Z structure
u_var      = uf_hor   * Znew;
v_var      = vf_hor   * Znew;
phi_var    = phif_hor * Znew;
q_var      = qf_hor   * Znew;
omegaM_var = omegaMf;     % leave the same - display at pmax=395 omegaM
                          % !! NOTE: uses Zprime structure if decide to 
                          %          calculate new value

